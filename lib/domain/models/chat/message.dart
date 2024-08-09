class Message {
  bool sender;
  String messageText;
  String timestamp;
  int affinityScore;
  int rejectionScore;


  Message({
    required this.sender,
    required this.messageText,
    required this.timestamp,
    required this.affinityScore,
    required this.rejectionScore,
  });
}

