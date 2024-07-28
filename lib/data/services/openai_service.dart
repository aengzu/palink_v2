import 'dart:convert';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/core/constants/app_url.dart';
import 'package:palink_v2/core/constants/prompts.dart';
import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/domain/models/character.dart';
import 'package:palink_v2/domain/models/user.dart';

class OpenAIService {
  String? get apiKey => AppUrl().apiKey;

  final Character character;
  final int conversationId;
  late final ChatOpenAI llm;
  late final ConversationBufferMemory memory;
  late final ConversationBufferMemory tipMemory;
  late final ConversationChain chain;
  late final LLMChain tip;
  late final LLMChain analyze;

  final tipPromptTemplate = ChatPromptTemplate.fromTemplate('''
    당신은 다음 설명에 해당하는 적절한 답변을 해야합니다. 
    답변으로 'answer', 'reason' 을 반드시 JSON 객체로 리턴하세요.
    당신의 대화 상대는 AI 캐릭터입니다. 당신은 USER의 입장에서 대답을 해야합니다.
    
    {input}
  ''');

  final promptTemplate = ChatPromptTemplate.fromTemplate('''
    당신은 USER 를 {userName}으로 부르세요. rejection_score는 누적되어야하고 만약 -5 이하면 is_end를 즉시 1로 설정하세요.
    다음은 당신에 대한 설명입니다.
    {description}
    답변으로 'text', 'feeling', 'expected_emotion', 'rejection_score', 'affinity_score', 'is_end'을 반드시 JSON 객체로 리턴하세요. ("```"로 시작하는 문자열을 생성하지 마세요)
    
    {chat_history}
    {userName}: {input}
    AI: 
  ''');

  final analyzeTemplate = ChatPromptTemplate.fromTemplate('''
    당신은 다음의 거절 점수 표와 대화 기록들을 보고, 사용자의 대화 능력을 평가해야합니다. 거절 점수 표는 캐릭터마다 다릅니다.
    반드시 한국어로 하며, AI 캐릭터의 말투를 사용해서 평가해주세요.
    {input}
    
    답변으로 'evaluation' (string), 'used_rejection' (string), 'final_rejection_score' (int) 을 반드시 JSON 객체로 리턴하세요.
    'evaluation'은 사용자의 대화 능력을 AI의 입장에서 100자 이내로 평가한 문자열입니다.
    'used_rejection'은 사용자가 대화에서 '사용한 거절 능력(해당 능력의 점수)'의 목록을 나타냅니다. 아이템의 구분은 ',' 로 나타냅니다. 
    'final_rejction_score'은 총 거절 점수입니다.
  ''');

  OpenAIService(this.character, this.conversationId) {
    _initializeChat();
  }

  void _initializeChat() {
    llm = ChatOpenAI(
        apiKey: apiKey,
        defaultOptions: const ChatOpenAIOptions(
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

  Future<AIResponse?> invokeChain(User user, String userInput) async {
    final memoryVariables = await loadMemory();
    final chatHistory = memoryVariables['history'] ?? '';

    final inputs = {
      'input': userInput,
      'chat_history': chatHistory,
      'userName': user.name,
      'description': character.prompt,
    };

    try {
      final result = await chain.invoke(inputs);

      await memory.saveContext(
        inputValues: inputs,
        outputValues: {'response': result['response']},
      );

      final AIChatMessage aiChatMessage = result['response'] as AIChatMessage;

      final Map<String, dynamic> contentMap = jsonDecode(aiChatMessage.content);
      AIResponse aiResponse = AIResponse.fromJson(contentMap);
      print(aiResponse.rejectionScore);
      String jsonString = aiChatMessage.content;
      print(jsonString);

      return aiResponse;
    } catch (e) {
      print('Failed to invoke chain: $e');
      return null;
    }
  }

  Future<AIResponse?> proceedRolePlaying(User user) async {
    try {
      AIResponse? aiResponse = await invokeChain(user, '당신이 먼저 부탁을 하며 대화를 시작하세요.');
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

      final AIChatMessage aiChatMessage = result['output'] as AIChatMessage;
      final Map<String, dynamic> tipMap = jsonDecode(aiChatMessage.content);
      return tipMap;
    } catch (e) {
      print('Failed to invoke tip: $e');
    }
  }

  Future<Map?> invokeAnalyze(String input) async {
    analyze = LLMChain(
      prompt: analyzeTemplate,
      llm: llm,
    );
    final inputs = {
      'input': "${character.anaylzePrompt}\n${input}",
    };
    try {
      final result = await analyze.invoke({'input': inputs});

      // JSON 문자열이 올바르게 반환되었는지 확인
      AIChatMessage aiChatMessage = result['output'] as AIChatMessage;
      String jsonString = aiChatMessage.content;
      print(jsonString);

      // JSON 문자열을 디코딩하기 전에 포맷 확인
      if (jsonString.startsWith('```json') && jsonString.endsWith('```')) {
        jsonString = jsonString.substring(7, jsonString.length - 3).trim();
      }

      final Map<String, dynamic> analyzeMap = jsonDecode(jsonString);
      return analyzeMap;
    } catch (e) {
      print('여기서 발생한 에런가?');
      print('Failed to invoke analyze: $e');
      return null;
    }
  }
}
