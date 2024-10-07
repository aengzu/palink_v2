import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_request.dart';
import 'package:palink_v2/data/models/ai_response/ai_message_response.dart';


class ResponseService {
  final ConversationChain chatChain;
  final ConversationBufferMemory memoryBuffer;

  ResponseService._(this.chatChain, this.memoryBuffer);

  // Initialization with exception handling for API key
  factory ResponseService.initialize() {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API_KEY is not set in .env file');
    }

    final memoryBuffer = ConversationBufferMemory(
      memoryKey: 'history',
      inputKey: 'input',
      returnMessages: false,
    );

    final openAI = ChatOpenAI(
      apiKey: apiKey,
      defaultOptions: const ChatOpenAIOptions(
        temperature: 0.8,
        model: 'gpt-4o-mini',
        maxTokens: 100,
      ),
    );

    final chatChain = ConversationChain(
      memory: memoryBuffer,
      llm: openAI,
      prompt:
        ChatPromptTemplate.fromTemplate('''
        당신은 마지막 말에 대해 적절한 답변을 해야합니다. 
        당신은 USER 를 {userName}으로 부르세요. {userName} 이 풀네임이라면 성은 빼고 이름만 부르세요. 
        다음은 당신에 대한 설명입니다. 

        {persona}

        당신은 'message', 'isEnd'을 반드시 JSON 객체로 리턴하세요. (\```json 로 시작하는 문자열을 생성하지 마세요)
         
        - message: 메시지 내용을 나타냅니다. (string) 
        - isEnd : 만약 user의 마지막 말 또는 지난 대화 기록에 부탁에 대한 수락(승낙)이 있다면 반드시 isEnd 를 바로 true로 설정하시오.(ex) 상대의 부탁에 대해 '알았어', '그래!','좋아', '알았어 도와줄게', '그래 나한테 맡겨', '알았어 내가 할게' 등) 그게 아니라면 default 값은 false 입니다. 만약 isEnd 가 false 이라면 물러서지 않고 계속 부탁합니다.(bool)

        [규칙] 
        - 맥락을 유지하며 {userName}의 마지막 말에 대한 대답을 리턴해주세요. 당신은 이전에 당신이 했던 말을 그대로 반복하지 않습니다.
        - 이전에 부탁을 했다면 해당 맥락을 기억하며 대화를 해야합니다. 새로운 부탁이 아닌 해당 부탁을 이어주세요.
        - 대화 기록이 비어있다면 부탁을 요청하면서 대화를 시작하세요. 
        - 대화 기록에서 sender 가 true 면 사용자가, false 면 AI가 말한 것이지만, 부탁하는 가장 첫 메시지는 sender 가 true 로 되어있어도 대화 상대가 말한 것입니다.
        - 'message'는 80자 이내로 출력하세요.
        - 대화 기록을 보고 사용자가 대화 상대의 부탁을 수락하는 말이 있거나(ex) 알았어 내게 맡겨, 내가 도와줄게) 전체 사용자의 대화의 흐름이 '부탁거절'에서 벗어났다면 isEnd 를 true 로 설정한다. (ex) 나랑 사귈래? 등)
        
        [대화기록]
        - {chatHistory}

        [{userName} 의 마지막 말]
        {userName} : {input}
      '''),

      inputKey: 'input',
      outputKey: 'response',
    );

    return ResponseService._(chatChain, memoryBuffer);
  }

  // 응답 생성 메서드
  Future<AIMessageResponse?> getChatResponse(AIMessageRequest messageRequest) async {
    try {
      // Pass the input nested under 'input'
      final input = {
          'userName': messageRequest.userName!,
          'persona': messageRequest.persona!,
          'input': messageRequest.userMessage!,
          'chatHistory': messageRequest.chatHistory!,
      };


      // Invoke the chat chain
      final result = await chatChain.invoke(input);
      // AIChatMessage 객체를 얻음
      final AIChatMessage aiChatMessage = result['response'] as AIChatMessage;

      // AI의 응답 내용을 문자열로 추출
      final String aiContent = aiChatMessage.content;

      // 응답 내용을 JSON으로 파싱
      final Map<String, dynamic> aiResponseMap = jsonDecode(aiContent);

      // 파싱된 데이터를 사용하여 AIMessageResponse 생성
      return AIMessageResponse.fromJson(aiResponseMap);
    } catch (e, stackTrace) {
      print('Error during chat response generation: $e');
      return null;
    }
  }
}


