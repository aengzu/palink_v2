import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/data/models/ai_response/tip_request.dart';
import 'package:palink_v2/data/models/ai_response/tip_response.dart';

class TipService {
  final LLMChain tipChain;

  TipService._(this.tipChain);

  // Initialization with exception handling for API key
  factory TipService.initialize() {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API_KEY is not set in .env file');
    }

    final openAI = ChatOpenAI(
      apiKey: apiKey,
      defaultOptions: const ChatOpenAIOptions(
        temperature: 0.7,
        model: 'gpt-3.5-turbo',
        maxTokens: 200,
      ),
    );

    final rejectionPrompt = ChatPromptTemplate.fromTemplate('''[명령]
당신은 다음 설명에 해당하는 적절한 답변을 해야합니다. 답변으로 'answer', 'reason' 을 반드시 JSON 객체로 리턴하세요.(\'''로 시작하는 문자열을 생성하지 않는다)
다음의 message에 대한 답변을 생성하시오. (이름을 답변에 넣지 마세요)
message : {message}

[규칙] 
- 당신은 대화 상대와 친구 사이입니다. 대화 상대는 당신에게 거절하기 힘든 부탁을 요구하거나, 화를 내거나, 갈등 상태에 있거나 할 수 있다.
- 당신은 그런 상대의 발화에 대한 적절한 응답을 해야 합니다.
- 대화 시 당황하지 않고 나-대화법과 비폭력 대화법을 사용해서 바람직한 대화 방향으로 이끌어야합니다. 
-  만약 감정을 표현해야한다면 다양한 감정단어로 자신의 감정을 명확하게 표현해야 하며 가장 적합한 답변을 해주세요.
-  다음 답변 제공 시 다음의 대화 퀘스트를 고려하여 제공해주세요. : {unachievedQuests}

[말투]
- 'answer' 생성 시 상대와는 친구사이이기 때문에 말투는 친구와 대화하듯이 말해야 합니다. 높임말을 절대 사용하지마세요. (감사해 -> 고마워 / 죄송해 -> 미안해 / 부탁드린다 -> 부탁해)

[규칙] 
-  잘못한 게 없다면 절대로 사과하지 않는다.
 - 넌 상대가 부탁을 한다면 절대로 부탁을 수용하면 안된다. 올바른 방식으로 거절을 해야한다. 
-  출력은 'answer' 과 'reason'을 가진다. 당신은 거절 필요 시 위에서 제공한 퀘스트들을 활용하며 answer 을 만들어야한다. 
-  'reason'은 'answer' 을 생성한 이유를 공식어(반말 X)를 사용하여 설명하세요.''');

    final tipChain = LLMChain(
      llm: openAI,
      prompt: rejectionPrompt,
      outputKey: 'tip',
    );

    return TipService._(tipChain);
  }

  Future<TipResponse?> createTip(TipRequest tipRequest) async {
    try {
      final input = {
        'message': tipRequest.message!,
        'unachievedQuests': tipRequest.unachievedQuests!
      };

      print('TipService.createTip input: $input');
      final result = await tipChain.invoke(input);
      print('TipService.createTip result: $result');
      final AIChatMessage aiChatMessage = result['tip'] as AIChatMessage;
      final String aiContent = aiChatMessage.content;

      final Map<String, dynamic> aiResponseMap = jsonDecode(aiContent);

      return TipResponse.fromJson(aiResponseMap);

    } catch (e) {
      print('Failed to generate tip: $e');
      return null;
    }
  }
}
