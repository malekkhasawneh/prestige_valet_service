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
