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
  @override
  List<Object> get props => [];
}
