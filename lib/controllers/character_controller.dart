import 'package:get/get.dart';
import 'package:palink_v2/models/character.dart';
import 'package:palink_v2/constants/app_images.dart';
import 'package:palink_v2/constants/prompts.dart';

class CharacterController extends GetxController {
  final characters = <Character>[
    Character(
      characterId: 1,
      name: '미연',
      type: '동정유발형',
      requestStrength: 1,
      prompt: Prompt.miyeonPrompt,
      description:
          '''미연은 매우 감성적인 타입이에요.\n부탁이 거절되면 실망하거나 슬퍼할 수 있어요\n 미연은 내성적이지만 친구들에게는 따뜻하고 배려심이 많아 깊은 관계를 맺고 있으며, 친구들의 고민을 잘 들어줘요\n미연의 부탁을 공감하고 이해하며 부드럽게 거절하는 것이 중요해요''',
      image: ImageAssets.char1,
      anaylzePrompt: Prompt.miyeonAnalyzePrompt,
    ),
    Character(
      characterId: 2,
      name: '세진',
      type: '은혜갚음형',
      requestStrength: 2,
      prompt: Prompt.sejinPrompt,
      description: "",
      image: ImageAssets.char2,
      anaylzePrompt: Prompt.miyeonAnalyzePrompt,
    ),
    Character(
      characterId: 3,
      name: '현아',
      type: '집요형',
      requestStrength: 3,
      prompt: Prompt.hyunaPrompt,
      description: "",
      image: ImageAssets.char3,
      anaylzePrompt: Prompt.miyeonAnalyzePrompt,
    ),
    Character(
      characterId: 4,
      name: '진혁',
      type: '분노형',
      requestStrength: 4,
      prompt: Prompt.jinhyukPrompt,
      description: "",
      image: ImageAssets.char4,
      anaylzePrompt: Prompt.miyeonAnalyzePrompt,
    ),
  ].obs;
}
