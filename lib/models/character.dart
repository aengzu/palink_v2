import 'package:palink_v2/constants/app_images.dart';
import 'package:palink_v2/constants/prompts.dart';

class Character {
  final int characterId;
  final String name;
  final String type;
  final int requestStrength;
  final String prompt;
  final String description;
  final String image;
  final String anaylzePrompt;

  Character({
    required this.characterId,
    required this.name,
    required this.type,
    required this.requestStrength,
    required this.prompt,
    required this.description,
    required this.image,
    required this.anaylzePrompt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'requestStrength': requestStrength,
      'prompt': prompt,
      'description': description,
      'image': image,
      'anaylzePrompt': anaylzePrompt,
    };
  }
}
