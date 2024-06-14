class Message {
  int messageId;
  bool sender;
  String messageText;
  String timestamp;
  int conversationId;

  Message({
    required this.messageId,
    required this.sender,
    required this.messageText,
    required this.timestamp,
    required this.conversationId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['message_id'],
      sender: json['sender'],
      messageText: json['message_text'],
      timestamp: json['timestamp'],
      conversationId: json['conversation_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'sender': sender,
      'message_text': messageText,
      'timestamp': timestamp,
      'conversation_id': conversationId,
    };
  }
}

class MessageDto {
  bool sender;
  String messageText;
  String timestamp;
  int conversationId;

  MessageDto({
    required this.sender,
    required this.messageText,
    required this.timestamp,
    required this.conversationId,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(
      sender: json['sender'],
      messageText: json['message_text'],
      timestamp: json['timestamp'],
      conversationId: json['conversation_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message_text': messageText,
      'timestamp': timestamp,
      'conversation_id': conversationId,
    };
  }
}
