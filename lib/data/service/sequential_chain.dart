import 'dart:convert';

import 'package:langchain/langchain.dart';
import 'package:palink_v2/data/models/ai_response/chat_request.dart';
import 'package:palink_v2/data/models/ai_response/chat_response.dart';
import 'response_service.dart';
import 'sentiment_service.dart';

class AIChainService {
  final SequentialChain sequentialChain;
  final SentimentService sentimentService; // SentimentService를 클래스 변수로 선언

  AIChainService._(this.sequentialChain, this.sentimentService);

  factory AIChainService.initialize() {
    final responseService = ResponseService.initialize();
    final sentimentService =
        SentimentService.initialize(); // SentimentService 인스턴스 초기화

    // SequentialChain에 각 체인을 연결합니다.
    final sequentialChain = SequentialChain(
      chains: [
        responseService.chatChain, // 첫 번째 체인
        sentimentService.sentimentAnalysisChain, // 두 번째 체인
      ],
      inputKeys: {'input', 'userMessage'}, // 첫 번째 체인에 입력으로 전달할 키
      outputKeys: {'response', 'output'}, // 최종 출력의 키 (sentiment 분석 결과)
    );

    return AIChainService._(
        sequentialChain, sentimentService); // SentimentService 전달
  }

  Future<ChatResponse?> runChain(ChatRequest chatRequest) async {
    try {
      // 필수 값이 null인지 확인
      if (chatRequest.userName == null ||
          chatRequest.persona == null ||
          chatRequest.userMessage == null) {
        print(
            'Error: 필수 값 누락 - userName: ${chatRequest.userName}, persona: ${chatRequest.persona}, userMessage: ${chatRequest.userMessage}');
        throw ArgumentError(
            'chatRequest의 필수 값이 누락되었습니다: userName, persona, userMessage는 null일 수 없습니다.');
      }

      // 입력 값 디버깅을 위한 로그 출력
      print(
          'Running chain with userName: ${chatRequest.userName}, persona: ${chatRequest.persona}, userMessage: ${chatRequest.userMessage}');

      // 첫 번째 체인의 입력 값
      final input = {
        'userName': chatRequest.userName!,
        'persona': chatRequest.persona!,
        'input': chatRequest.userMessage!,
        'userMessage': chatRequest.userMessage!,
      };

      // SequentialChain 실행
      final result = await sequentialChain.invoke(input);
      // 결과에서 'response' 키로부터 AIChatMessage 객체를 얻습니다.
      final AIChatMessage aiChatMessage = result['response'] as AIChatMessage;

      // AI의 응답 내용을 문자열로 추출합니다.
      final aiMessage = aiChatMessage.content;

    // 만약 aiMessage가 JSON 문자열이라면, 이를 파싱하여 필요한 데이터를 추출합니다.
      final Map<String, dynamic> contentMap = jsonDecode(aiMessage);

      // 이제 'message' 필드를 사용할 수 있습니다.
      final String message = contentMap['message'] as String;

// 감정 분석 체인에 전달할 input 설정
      final sentimentInput = {
        'response': message, // 첫 번째 체인의 'message'를 두 번째 체인의 'response'로 사용
        'userMessage': chatRequest.userMessage!, // 유저 메시지 전달
      };

      // 감정 분석 실행
      final sentimentResult = await sentimentService.sentimentAnalysisChain.invoke(sentimentInput);

      // 감정 분석 결과에서 필요한 데이터 추출
      final AIChatMessage sentimentChatMessage = sentimentResult['output'] as AIChatMessage;
      final Map<String, dynamic> sentimentContentMap = jsonDecode(sentimentChatMessage.content);

      print('AIChainService: sentimentContentMap: $sentimentContentMap');
      // 최종 결과를 ChatResponse로 변환하여 반환
      return ChatResponse.fromJson({
        ...contentMap,
        ...sentimentContentMap,
      });


    } catch (e) {
      print('체인 실행 실패: $e');
      return null;
    }
  }
}
