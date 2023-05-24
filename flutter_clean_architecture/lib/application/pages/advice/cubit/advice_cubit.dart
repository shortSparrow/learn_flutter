import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';
import 'package:flutter_clean_architecture/domain/usecases/advice_usecase.dart';

part 'advice_state.dart';

const serverFailureMessage = "oops, API error, please try again";
const cacheFailureMessage = "oops, cache failed, please try again";
const generalFailureMessage = "oops, something went wrong, please try again";

class AdviceCubit extends Cubit<AdviceCubitState> {
  AdviceCubit({required this.adviceUseCase}) : super(AdviceInitial());

  final AdviceUseCase adviceUseCase;

  void adviceRequest() async {
    emit(AdviceStateLoading());

    final failureOradvice = await adviceUseCase.getAdvice();
    failureOradvice.fold(
        (failure) =>
            emit(AdviceStateError(errorMessage: _mapFailureToMessage(failure))),
        (advice) => emit(AdviceStateLoaded(advice: advice.advice)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
