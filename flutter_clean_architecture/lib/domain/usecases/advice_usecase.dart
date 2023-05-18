import '../entities/advice_entity.dart';

class AdviceUseCase {
  Future<AdviceEntity> getAdvice() async {
    // call a repository to get data (failure or success)
    // proceed with business logic (manipulate data)
    await Future.delayed(const Duration(seconds: 3));

    return const AdviceEntity(advice: "fake advice to test", id: 1);
  }
}
