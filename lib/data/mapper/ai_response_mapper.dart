import 'package:palink_v2/data/models/ai_response/ai_message_response.dart';
import 'package:palink_v2/data/models/ai_response/ai_response.dart';
import 'package:palink_v2/data/models/ai_response/liking_response.dart';
import 'package:palink_v2/data/models/ai_response/rejection_response.dart';
import 'package:palink_v2/data/models/chat/message_request.dart';
import 'package:palink_v2/domain/entities/character/character.dart';

extension AIResponseMapper on AIResponse {
  MessageRequest toMessageRequest() {
    return MessageRequest(
      sender: false,
      messageText: text,  // AIResponse의 텍스트 사용
      timestamp: DateTime.now().toIso8601String(),  // 현재 시간을 타임스탬프로 변환
      aiResponse: this,  // AIResponse를 그대로 매핑
    );
  }
}

extension InitialAIResponseMapper on AIResponse {
  MessageRequest toInitialMessageRequest() {
    return MessageRequest(
      sender: true,
      messageText: text,  // AIResponse의 텍스트 사용
      timestamp: DateTime.now().toIso8601String(),  // 현재 시간을 타임스탬프로 변환
      aiResponse: this,  // AIResponse를 그대로 매핑
    );
  }
}


extension InitialAIMessageResponseMapper on AIMessageResponse {
  AIResponse toInitialAIResponse(LikingResponse likingResponse) {
    return AIResponse(
      text: message,
      feeling: likingResponse.feeling,  // LikabilityResponse의 feeling을 AIResponse의 feeling으로 매핑
      affinityScore: likingResponse.likability,  // 호감도 점수 매핑
      rejectionScore: [],
      rejectionContent: [],  // 거절 카테고리 리스트 그대로 매핑
      finalRejectionScore: 0,  // 최종 거절 점수 (거절 카테고리 수로 계산)
      finalAffinityScore: 0,  // 최종 호감도 점수 그대로 사용
    );
  }
}

extension AIMessageResponseMapper on AIMessageResponse {
  AIResponse toAIResponse(LikingResponse likingResponse, RejectionResponse rejectionResponse, Character character) {
    final rejectionScores = getRejectionScoresByCharacter(character);

    // rejectionContent 리스트를 기반으로 rejectionScore 리스트 생성
    List<int> rejectionScoreList = rejectionResponse.rejectionContent
        .map((category) => rejectionScores[category] ?? 0)  // 점수를 찾고, 없으면 0으로 설정
        .toList();

    return AIResponse(
      text: message,  // ChatResponse의 텍스트를 AIResponse의 텍스트로 설정
      feeling: likingResponse.feeling,  // 감정 분석 결과를 그대로 매핑
      affinityScore: likingResponse.likability,  // 호감도 점수 매핑
      rejectionScore: rejectionScoreList,  // 계산된 rejectionScore 리스트
      rejectionContent: rejectionResponse.rejectionContent,  // 거절 카테고리 리스트
      finalRejectionScore: 0,  // 계산된 최종 거절 점수
      finalAffinityScore: 0,  // 최종 호감도 점수 그대로 사용
    );
  }
}



Map<String, int> getRejectionScoresByCharacter(Character character) {
  // 캐릭터별 거절 점수표를 반환하는 함수
  switch (character.name) {
    case '미연':
      return {
        "상황에 대한 공감": 2,
        "과거 배려에 대한 감사함 표시": 2,
        "대안 제시": 4,
        "단호한 거절": -3,
        "잘못에 대한 사과": 4,
        "이유있는 거절": 2,
        "무시하거나 냉담한 반응": -4,
        "비꼬는 태도": -4,
        "이유 없는 거절": -4,
        "불성실한 대답": -3,
        "수락하지 못함에 대한 아쉬움 표현, 도와주고 싶은 마음 표현": 3,
        "원인을 상대로 돌리기": -4,
        "주제에서 벗어난 말": -1,
        "세 글자 이하의 성의없는 답변": -1,
        "티나는 거짓말": -4,
        "욕설": -4
      };
    case '세진':
      return {
        "상황에 대한 공감": 2,
        "과거 배려에 대한 감사함 표시": 2,
        "대안 제시": 4,
        "단호한 거절": -3,
        "잘못에 대한 사과": 4,
        "이유있는 거절": 2,
        "무시하거나 냉담한 반응": -4,
        "비꼬는 태도": -4,
        "이유 없는 거절": -4,
        "불성실한 대답": -3,
        "수락하지 못함에 대한 아쉬움 표현, 도와주고 싶은 마음 표현": 3,
        "원인을 상대로 돌리기": -4,
        "주제에서 벗어난 말": -1,
        "세 글자 이하의 성의없는 답변": -1,
        "티나는 거짓말": -4,
        "욕설": -4
      };
    case '현아':
      return {
        "상황에 대한 공감": 2,
        "거절해야 하는 상황 설명": 4,
        "단호하게 거절": 3,
        "반복된 요청에 재차 단호한 거절": 3,
        "무시하거나 냉담한 반응": -5,
        "이유 없는 거절": -3,
        "불성실한 대답": -3,
        "원인을 상대방에게 돌리기": -4,
        "주제에서 벗어난 말": -1
      };
    case '진혁':
      return {
        "부탁 내용 확인": 1,
        "거절해야 하는 상황 설명": 4,
        "아쉬움 표현": 3,
        "단호한 거절": 3,
        "무시하거나 냉담한 반응": -2,
        "비꼬는 태도": -1,
        "이유 없는 거절": -3,
        "불성실한 대답": -3,
        "원인을 상대방에게 돌리기": -3,
        "주제에서 벗어난 말": -1,
        "인신공격, 욕설": -5
      };
    default:
      return {};
  }
}

