import 'package:floor/floor.dart';

@Entity(tableName: 'mindset')
class MindsetEntity {
  @PrimaryKey()
  final int id;
  final int group;
  final String content;
  final String reason;

  MindsetEntity({
    required this.id,
    required this.group,
    required this.content,
    required this.reason,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group': group,
      'content': content,
      'reason': reason,
    };
  }
}
