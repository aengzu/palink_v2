import 'dart:convert';
import 'package:get/get.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/constants/prompts.dart';
import '../constants/app_url.dart';
import '../controller/user_controller.dart';
import '../models/chat/ai_response.dart';
import '../models/chat/message.dart';
import '../models/tip.dart';

class OpenAIService {
  String? get apiKey => AppUrl().apiKey;

  final String prompt;
  final int conversationId;
  late final ChatOpenAI llm;
  late final ConversationBufferMemory memory;
  late final ConversationBufferMemory tipMemory;
  late final ConversationChain chain;
  late final LLMChain tip;
  final UserController userController = Get.put(UserController());

  final tipPromptTemplate = ChatPromptTemplate.fromTemplate('''
    당신은 다음 설명에 해당하는 적절한 답변을 해야합니다. 
    답변으로 'answer', 'reason' 을 반드시 JSON 객체로 리턴하세요.
    
    {input}
  ''');

  final promptTemplate = ChatPromptTemplate.fromTemplate('''
    당신은 미연입니다. 다음은 미연에 대한 설명입니다. 당신은 USER 를 {userName}으로 부르세요.
    {description}
    답변으로 'text', 'feeling', 'expected_emotion', 'rejection_score', 'affinity_score', 'is_ending'을 반드시 JSON 객체로 리턴하세요.
    
    {chat_history}
    {userName}: {input}
    AI: 
  ''');

  OpenAIService(this.prompt, this.conversationId) {
    _initializeChat();
  }

  void _initializeChat() {

    llm = ChatOpenAI(apiKey: apiKey, defaultOptions: const ChatOpenAIOptions(
      temperature: 0.8,
      model: 'gpt-4-turbo',
      maxTokens: 600,
    ));

    memory = ConversationBufferMemory(
      memoryKey: 'history',
      inputKey: 'input',
      returnMessages: true,
    );

    tipMemory = ConversationBufferMemory(
      memoryKey: 'history',
      inputKey: 'input',
      returnMessages: true,
    );

    chain = ConversationChain(
      memory: memory,
      llm: llm,
      prompt: promptTemplate,
      outputKey: 'response',
      inputKey: 'input', // inputKey 설정
    );

    tip = LLMChain(
      prompt: tipPromptTemplate,
      llm: llm,
      memory: tipMemory,
    );
  }

  Future<Map<String, dynamic>> loadMemory() async {
    final variables = await memory.loadMemoryVariables();
    return variables;
  }

  Future<AIResponse?> invokeChain(String userInput) async {
    final memoryVariables = await loadMemory();
    final chatHistory = memoryVariables['history'] ?? '';

    final inputs = {
      'input': userInput,
      'chat_history': chatHistory,
      'userName': userController.name,
      'description': prompt,
    };

    try {
      final result = await chain.invoke(inputs);

      await memory.saveContext(
        inputValues: inputs,
        outputValues: {'response': result['response']},
      );

      final AIChatMessage aiChatMessage = result['response'] as AIChatMessage;
      print(aiChatMessage.content);

      final Map<String, dynamic> contentMap = jsonDecode(aiChatMessage.content);
      AIResponse aiResponse = AIResponse.fromJson(contentMap);
      return aiResponse;

    } catch (e) {
      print('Failed to invoke chain: $e');
      return null;
    }
  }

  Future<AIResponse?> proceedRolePlaying() async {
    try {
      AIResponse? aiResponse = await invokeChain('당신이 먼저 부탁을 하며 대화를 시작하세요.');
      invokeTip(aiResponse!);
      return aiResponse;
    } catch (e) {
      print('Error in proceedRolePlaying: $e');
      return null;
    }
  }

  Future<Map?> invokeTip(AIResponse aiResponse) async {
    final inputs = {
      'input': "${Prompt.tipPrompt}\n${aiResponse.text}", // 단일 input 키로 구성된 텍스트
    };

    try {
      final result = await tip.invoke({'input': inputs});
      print(result['output']);
      print('팁 이렇게 나옴');

      final AIChatMessage aiChatMessage = result['output'] as AIChatMessage;
      final Map<String, dynamic> tipMap = jsonDecode(aiChatMessage.content);
      String tipAnswer = tipMap['answer'];
      String reason = tipMap['reason'];
      return tipMap;

    } catch (e) {
      print('Failed to invoke tip: $e');
    }
  }
}
