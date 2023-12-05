part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class RetrieveCarLoaded extends HomeState {
  final ParkedCarsModel parkedCarsModel;

  const RetrieveCarLoaded({required this.parkedCarsModel});
  @override
  List<Object> get props => [parkedCarsModel];
}

class WashCarLoaded extends HomeState {
  final ParkedCarsModel parkedCarsModel;

  const WashCarLoaded({required this.parkedCarsModel});
  @override
  List<Object> get props => [parkedCarsModel];
}

class HomeLoaded extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeError extends HomeState {
  final String failure;

  const HomeError({required this.failure});

  @override
  List<Object> get props => [failure];
}
