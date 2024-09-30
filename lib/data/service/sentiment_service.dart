import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/data/models/ai_response/liking_response.dart';

class SentimentService {
  final LLMChain sentimentAnalysisChain;

  SentimentService._(this.sentimentAnalysisChain);

  factory SentimentService.initialize() {
    final openAI = ChatOpenAI(
      apiKey: dotenv.env['API_KEY']!,
      defaultOptions: const ChatOpenAIOptions(
        temperature: 0.6,
        model: 'gpt-4o-mini',
        maxTokens: 50,
      ),
    );

    // 감정 분석 프롬프트
    final sentimentAnalysisPrompt = ChatPromptTemplate.fromTemplate('''
      [명령]
      - 당신은 다음의 대화 메시지에 대해 user 의 발화 이후 AI의 호감도의 변화를 측정합니다. 대화 상황은 친구 간의 대화 상황입니다. 
      - user 의 발화를 듣고 난 후  당신(AI) 의 현재 감정과 호감도의 증감을 json 객체로 리턴합니다. user의 메시지가 없다면 AI 메시지만 보고 현재 감정을 추론하시오. 이 경우 호감도 증감은 0입니다.

      [대화]
      AI(당신) : {aiMessage}
      user : {userMessage}

      [출력]
      - 출력은 'feeling' 과 'likability' 의 json 객체입니다. (\```json 로 시작하는 문자열을 생성하지 마세요. 전체는 30자 이내로 출력되어야합니다.)
      - 'feeling' : 기쁨, 슬픔, 분노, 불안, 혐오, 중립, 사랑 중 100% 중 구성된 모든 감정들을 나열합니다. 감정의 구분은 ','로 나타내며 가장 큰 감정 부터 나열하시오. (string) (ex) 기쁨 60, 중립 40) (string)
      - 'likability' : 12, 5, -12, -18 중 하나의 값으로 나타남 (int)

      [호감도 변화 계산 규칙]
      - user의 메시지에 대해 다음의 요소에 의해 호감도의 점수가 결정됩니다.
      - 메시지가 긍정적인 감정을 표현하거나 상대방을 배려하는 느낌을 줄 때 = 점수: +12
      - 메시지가 특별히 긍정적이거나 부정적이지 않은 평범한 메시지일 때. = 점수: +5
      - 메시지가 부정적이거나 상대방을 불쾌하게 할 수 있을 때 = 점수: -12
      - 메시지에 욕설 또는 비하가 포함되어 있을 때 = 점수 : -18
    ''');

    // LLMChain 생성
    final sentimentAnalysisChain = LLMChain(
      prompt: sentimentAnalysisPrompt,
      llm: openAI,
      outputKey: 'output',
    );

    return SentimentService._(sentimentAnalysisChain);
  }

  Future<LikingResponse?> analyzeSentiment(String userMessage, String aiMessage) async {
    try {
      final input = {'userMessage': userMessage, 'aiMessage': aiMessage};
      final result = await sentimentAnalysisChain.invoke(input);
      final AIChatMessage aiChatMessage = result['output'] as AIChatMessage;
      final String aiContent = aiChatMessage.content;

      // 응답 내용을 JSON으로 파싱
      final Map<String, dynamic> aiResponseMap = jsonDecode(aiContent);

      // 파싱된 데이터를 사용하여 AIMessageResponse 생성
      return LikingResponse.fromJson(aiResponseMap);
    } catch (e) {
      print('Failed to analyze sentiment: $e');
      return null;
    }
  }
}
