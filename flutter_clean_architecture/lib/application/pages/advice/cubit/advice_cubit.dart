import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/usecases/advice_usecase.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceCubitState> {
  AdviceCubit() : super(AdviceInitial());
  final AdviceUseCase adviceUseCase = AdviceUseCase();

  void adviceRequest() async {
    emit(AdviceStateLoading());

    final advice = await adviceUseCase.getAdvice();
    emit(AdviceStateLoaded(advice: advice.advice));
    // emit(AdviceStateError(advice: "Error message from bloc"));
  }
}
