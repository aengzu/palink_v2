class AIResponse {
  final int conversationId;
  final String text;
  final int isEnd;
  final int affinityScore;
  final String expectedEmotion;
  final int rejectionScore; // 추가된 필드

  AIResponse({
    required this.conversationId,
    required this.text,
    required this.isEnd,
    required this.affinityScore,
    required this.expectedEmotion,
    required this.rejectionScore, // 초기화 추가
  });

  // JSON에서 데이터를 변환하는 factory constructor 필요
  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      conversationId: json['conversationId'],
      text: json['text'],
      isEnd: json['isEnd'],
      affinityScore: json['affinityScore'],
      expectedEmotion: json['expectedEmotion'],
      rejectionScore: json['rejectionScore'], // 필드 매핑 추가
    );
  }
}
