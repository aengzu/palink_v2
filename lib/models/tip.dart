// 팁 모델
class Tip {
  final int tipId;
  final String tipText;
  final int messageId;

  Tip({required this.tipId, required this.tipText, required this.messageId});

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
        tipId: json['tip_id'],
        tipText: json['tip_text'],
        messageId: json['message_id']);
  }

  Map<String, dynamic> toJson() {
    return {'tip_id': tipId, 'tip_text': tipText, 'message_id': messageId};
  }
}

// Tip 생성 시 사용하는 데이터 DTO
class TipDto {
  final String tipText;
  final int messageId;

  TipDto({required this.tipText, required this.messageId});

  factory TipDto.fromJson(Map<String, dynamic> json) {
    return TipDto(tipText: json['tip_text'], messageId: json['message_id']);
  }

  Map<String, dynamic> toJson() {
    return {'tip_text': tipText, 'message_id': messageId};
  }
}
