import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class EmotionVibration {
  final Map<String, Map<String, dynamic>> emotions = {
    "Fear": {
      "color": Colors.black.withOpacity(0.5),
      "pattern": [100, 200, 100, 200]
    },
    "Surprise": {
      "color": Colors.yellow.withOpacity(0.5),
      "pattern": [500]
    },
    "Anger": {
      "color": Colors.red.withOpacity(0.5),
      "pattern": [2000]
    },
    "Sadness": {
      "color": Colors.blue.withOpacity(0.5),
      "pattern": [1000, 2000]
    },
    "Trust": {
      "color": Colors.indigo.withOpacity(0.5),
      "pattern": [500, 500, 500, 500]
    },
    "Happiness": {
      "color": Colors.yellow.withOpacity(0.5),
      "pattern": [300, 300, 300, 300]
    },
    "Disgust": {
      "color": Colors.brown.withOpacity(0.5),
      "pattern": [500, 500]
    },
    "Tension": {
      "color": Colors.grey.withOpacity(0.5),
      "pattern": [500, 500, 500, 500]
    },
    "Excitement": {
      "color": Colors.red.withOpacity(0.5),
      "pattern": [300, 300, 300, 300]
    },
  };

  void vibrateForEmotion(String emotion) {
    if (emotions.containsKey(emotion)) {
      List<int> pattern = emotions[emotion]!['pattern'];
      Vibration.vibrate(pattern: pattern);
    } else {
      print("Unknown emotion: $emotion");
    }
  }

  Color getColorForEmotion(String emotion) {
    if (emotions.containsKey(emotion)) {
      return emotions[emotion]!['color'];
    } else {
      return Colors.white.withOpacity(0.5); // default color with opacity
    }
  }
}
