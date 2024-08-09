import 'package:palink_v2/domain/models/mindset/mindset.dart';
import 'package:palink_v2/domain/repository/mindset_repository.dart';


class GetRandomMindsetUseCase {
  final MindsetRepository repository;

  GetRandomMindsetUseCase(this.repository);

  Future<Mindset?> execute() async {
    return await repository.getRandomMindset();
  }
}
