import 'package:get/get.dart';
import 'package:palink_v2/domain/models/analysis_dto/analysis_dto.dart';
import 'package:palink_v2/domain/models/character/character.dart';

class FeedbackViewmodel extends GetxController {
 final AnalysisDto analysisDto;
 final Character character;

 FeedbackViewmodel({required this.analysisDto, required this.character});
}
