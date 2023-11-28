part of 'pick_up_cubit.dart';

abstract class PickUpState extends Equatable {
  const PickUpState();
}

class PickUpInitial extends PickUpState {
  @override
  List<Object> get props => [];
}

class PickUpLoading extends PickUpState {
  @override
  List<Object> get props => [];
}

class PickUpLoaded extends PickUpState {
  final GatesModel gatesModel;

  const PickUpLoaded({required this.gatesModel});
  @override
  List<Object> get props => [gatesModel];
}
class PickUpError extends PickUpState {
  final String failure;

  const PickUpError({required this.failure});
  @override
  List<Object> get props => [failure];
}

// Set And Get Value States
class SetValueLoading extends PickUpState {
  @override
  List<Object> get props => [];
}
class SetValueLoaded extends PickUpState {
  @override
  List<Object> get props => [];
}