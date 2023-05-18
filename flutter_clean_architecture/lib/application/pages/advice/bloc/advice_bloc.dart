import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  AdviceBloc() : super(AdviceInitial()) {
    on<AdviceRequestEvent>((event, emit) async {
      emit(AdviceStateLoading());

      debugPrint("Fake get ans advice");
      await Future.delayed(const Duration(seconds: 3));
      debugPrint("Fake advice loaded");

      emit(AdviceStateLoaded(advice: "fake advice from bloc"));
      // emit(AdviceStateError(advice: "Error message from bloc"));
    });
  }
}
