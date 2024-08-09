import '../models/mindset/mindset.dart';

abstract class MindsetRepository {
  Future<Mindset?> getRandomMindset();
}
