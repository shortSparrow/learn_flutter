part of 'advice_bloc.dart';

@immutable
abstract class AdviceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdviceRequestEvent extends AdviceEvent {}
