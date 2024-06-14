
class ExpectedResponse {
  final String answer;
  final String reason;

  ExpectedResponse({required this.answer, required this.reason});

  factory ExpectedResponse.fromJson(Map<String, dynamic> json) {
    return ExpectedResponse(
      answer: json['answer'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'reason': reason,
    };
  }
}

class AIResponse {
  final String text;
  final String feeling;
  final String expectedEmotion;
  final int rejectionScore;
  final int affinityScore;
//  final List<ExpectedResponse> expectedResponses;
  final int isEnd;

  AIResponse({
    required this.text,
    required this.feeling,
    required this.expectedEmotion,
    required this.rejectionScore,
    required this.affinityScore,
  //  required this.expectedResponses,
    required this.isEnd,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    // var expectedResponsesFromJson = json['expected_responses'] as List;
    // List<ExpectedResponse> expectedResponsesList = expectedResponsesFromJson.map((i) => ExpectedResponse.fromJson(i)).toList();

    return AIResponse(
      text: json['text'],
      feeling: json['feeling'],
      expectedEmotion: json['expected_emotion'],
      rejectionScore: json['rejection_score'],
      affinityScore: json['affinity_score'],
      isEnd: json['is_end'],
    //  expectedResponses: expectedResponsesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'feeling': feeling,
      'expected_emotion': expectedEmotion,
      'rejection_score': rejectionScore,
      'affinity_score': affinityScore,
      'is_end': isEnd,
   //   'expected_responses': expectedResponses.map((response) => response.toJson()).toList(),
    };
  }
}