part of 'advice_cubit.dart';

abstract class AdviceCubitState extends Equatable {
  const AdviceCubitState();

  @override
  List<Object> get props => [];
}

class AdviceInitial extends AdviceCubitState {}

class AdviceStateLoading extends AdviceCubitState {}

class AdviceStateLoaded extends AdviceCubitState {
  final String advice;

  const AdviceStateLoaded({required this.advice});

  @override
  List<Object> get props => [advice];
}

class AdviceStateError extends AdviceCubitState {
  final String errorMessage;

  const AdviceStateError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
