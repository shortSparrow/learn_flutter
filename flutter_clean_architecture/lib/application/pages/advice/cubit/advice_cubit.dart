import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceCubitState> {
  AdviceCubit() : super(AdviceInitial());

  void adviceRequest() async {
    emit(AdviceStateLoading());

    await Future.delayed(const Duration(seconds: 3));

    emit(const AdviceStateLoaded(advice: "fake advice from bloc"));
    // emit(AdviceStateError(advice: "Error message from bloc"));
  }
}
