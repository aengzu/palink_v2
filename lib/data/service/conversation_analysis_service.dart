import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/data/models/ai_response/analysis_request.dart';
import 'package:palink_v2/data/models/ai_response/analysis_response.dart';

class ConversationAnalysisService {
  final LLMChain conversationAnalysisChain;

  ConversationAnalysisService._(this.conversationAnalysisChain);

  // Initialization with exception handling for API key
  factory ConversationAnalysisService.initialize() {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API_KEY is not set in .env file');
    }

    final openAI = ChatOpenAI(
      apiKey: apiKey,
      defaultOptions: const ChatOpenAIOptions(
        temperature: 0.8,
        model: "gpt-4o-mini",
        maxTokens: 340,
      ),
    );

    // 프롬프트 넣기
    final conversationAnalysisPrompt = ChatPromptTemplate.fromTemplate('''
    당신은 다음의 대화 기록들과 사용한 거절 방법, 미달성 퀘스트를 보고, 사용자의 대화 능력을 평가해야합니다. 부탁을 거절하는 능력을 평가하고자 합니다. 
    대화 기록에선 사용자의 'userMessage' 에 대한 ai의 반응인 'text' 가 있으며, 'userMessage' 에서 사용된 거절 방법이 'rejection_content' 으로 그리고 거절 점수가 'rejection_score' 로 나타납니다. 
    대화 기록에서 'userMessage' 기록들을 보고 유저의 거절 능력을 평가해주세요. 대화 상대의 성격을 보고, 사용자가 대화 상대 특성에 적합한 거절 방식을 사용하여 거절했는지도 고려해야합니다. 
      
 [대화 기록]
 {chatHistory}
  
  [대화 상대의 성격]
  - 대화 상대가 진혁이라면 상대의 감정을 고려하기 보다는 자신의 의사를 명확히 표현해야하며 사용자가 저자세 거절(ㅠ 와 같은 표현 자주 사용)을 한다면 이를 피드백 내용에서 지적합니다, 대화 상대가 미연이라면 상대방의 감정을 고려하며 거절해야합니다. 세진이라면 거절의 이유를 명확히 표현해야하며 현아라면 집요한 요청에 대해 단호하게 거절해야합니다.
  {description}

답변으로 'evaluation'(string), 'usedRejection'(string), 'type'(string) 을 반드시 JSON 객체로 리턴하세요. (\```json 로 시작하는 문자열을 생성하지 마세요. 전체는 290자 이내로 출력되어야합니다.)
      
 'evaluation'은 사용자의 대화 능력을 AI의 입장에서 300자 이내로 평가한 문자열입니다. (string)
 'evalution' 은 사용자의 대화능력을 평가할 뿐 아니라 사용자의 대화 능력을 개선할 수 있는 피드백을 제공해야합니다.
 대화 기록에서 인용할 만한 텍스트가 있다면 직접적으로 인용하여 지적 및 칭찬을 해도됩니다.  또한, 대화 기록에서 사용자의 말이 character 의 감정을 상하게 할 부분이 있거나,  
 사용자가 과하게 자기 표현을 못하는 경우에 이를 지적해주세요. 사용자가 대화 주제에서 벗어나거나 부탁을 수락했다면 이를 지적해주세요.
 
 - 'usedRejection'은 사용자가 대화에서 사용한 거절 방법을 나타내는 문자열입니다. 대화 기록에서 사용한 거절 카테고리를 중복 없이 쉼표로 구별하여 나열해주세요. (,(쉼표)로 구분한 string)
 - 'type'은 사용자의 대화 능력을 귀엽게 별명으로 유형화하여 하나의 단어로 나타낸 것입니다.예를 들어 '앵무새거절러', '단호박거절러', '감성파거절러', '거절승낙러', '욕쟁이거절러' 등이 있으나 창의력을 발휘해보세요.(string)
    ''');

    final conversationAnalysisChain = LLMChain(
      llm: openAI,
      prompt: conversationAnalysisPrompt,
      outputKey: 'analysis',
    );

    return ConversationAnalysisService._(conversationAnalysisChain);
  }

  Future<AnalysisResponse?> analyzeConversation(
      AnalysisRequest analysisRequest) async {
    try {
      final String chatHistoryString = analysisRequest.chatHistory.toString();
      final String descriptionString = analysisRequest.description.toString();


      final inputs = {'chatHistory': chatHistoryString, 'description': descriptionString};

      final result = await conversationAnalysisChain.invoke(inputs);


      // 결과에서 analysis 부분 확인
      final AIChatMessage aiChatMessage = result['analysis'] as AIChatMessage;

      // 로그 추가: AI 응답 내용 확인
      print('DEBUG: AIChatMessage Content: ${aiChatMessage.content}');

      final String aiContent = aiChatMessage.content;
      final Map<String, dynamic> aiResponseMap = jsonDecode(aiContent);

      return AnalysisResponse.fromJson(aiResponseMap);
    } catch (e, stackTrace) {
      // 에러 로그 추가
      print('Failed to analyze rejection: $e');
      return null;
    }
  }
}
