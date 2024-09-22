import 'package:get/get.dart';
import 'package:palink_v2/data/models/ai_response/analysis_response.dart';
import 'package:palink_v2/domain/entities/analysis/analysis_dto.dart';
import 'package:palink_v2/domain/entities/character/character.dart';


class FeedbackViewmodel extends GetxController {
 final AnalysisDto analysisDto;
 final Character character;

 FeedbackViewmodel({required this.analysisDto, required this.character});
}
