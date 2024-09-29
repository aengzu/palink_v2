class Message {
  String id;
  bool sender;
  String messageText;
  String timestamp;
  int affinityScore;
  List<int> rejectionScore;
  List<String> reactions;
  String? feeling;


  Message({
    required this.id,
    required this.sender,
    required this.messageText,
    required this.timestamp,
    this.feeling,
    int? affinityScore,
    List<int>? rejectionScore,
    List<String>? reactions,}) : reactions = reactions ?? [], affinityScore = affinityScore ?? 50, rejectionScore = rejectionScore ?? [];

  // copyWith 메서드 추가
  Message copyWith({
    String? id,
    bool? sender,
    String? messageText,
    String? timestamp,
    int? affinityScore,
    List<int>? rejectionScore,
    List<String>? reactions,
    String? feeling,
  }) {
    return Message(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      messageText: messageText ?? this.messageText,
      timestamp: timestamp ?? this.timestamp,
      affinityScore: affinityScore ?? this.affinityScore,
      rejectionScore: rejectionScore ?? this.rejectionScore,
      reactions: reactions ?? this.reactions,
      feeling: feeling ?? this.feeling,
    );
  }
}


