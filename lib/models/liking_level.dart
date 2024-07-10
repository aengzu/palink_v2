class LikingLevel {
  final int likingLevel;
  final int messageId;

  LikingLevel({required this.likingLevel, required this.messageId});

  factory LikingLevel.fromJson(Map<String, dynamic> json) {
    return LikingLevel(
        likingLevel: json['liking_level'], messageId: json['message_id']);
  }

  Map<String, dynamic> toJson() {
    return {'liking_level': likingLevel, 'message_id': messageId};
  }
}
