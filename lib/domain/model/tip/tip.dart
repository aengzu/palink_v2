import 'package:json_annotation/json_annotation.dart';
part 'tip.g.dart';

@JsonSerializable()
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

