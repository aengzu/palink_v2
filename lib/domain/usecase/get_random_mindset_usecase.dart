
import 'package:palink_v2/data/models/mindset/mindset_response.dart';
import 'package:palink_v2/domain/repository/mindset_repository.dart';


class GetRandomMindsetUseCase {
  final MindsetRepository repository;

  GetRandomMindsetUseCase(this.repository);

  Future<MindsetResponse?> execute() async {
    return await repository.getRandomMindset();
  }
}
