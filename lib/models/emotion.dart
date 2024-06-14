

class Emotion{
  final String emotionType;
  final String vibrationPattern;
  final String backgroundColor;

  Emotion({required this.emotionType, required this.vibrationPattern, required this.backgroundColor});

  factory Emotion.fromJson(Map<String, dynamic> json) {
    return Emotion(
      emotionType: json['emotion_type'],
      vibrationPattern: json['vibration_pattern'],
      backgroundColor: json['background_color']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emotion_type': emotionType,
      'vibration_pattern' : vibrationPattern,
      'background_color': backgroundColor,
    };
  }
}

