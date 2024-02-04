part of 'bottom_nav_bar_cubit.dart';

abstract class BottomNavBarState extends Equatable {
  const BottomNavBarState();
}

class BottomNavBarInitial extends BottomNavBarState {
  @override
  List<Object> get props => [];
}

class BottomNavBarLoading extends BottomNavBarState {
  @override
  List<Object> get props => [];
}

class BottomNavBarLoaded extends BottomNavBarState {
  @override
  List<Object> get props => [];
}
class SendNotificationLoaded extends BottomNavBarState {
  @override
  List<Object> get props => [];
}

class IsTokenValidLoaded extends BottomNavBarState {
  final bool isValid;

 const IsTokenValidLoaded({required this.isValid});
  @override
  List<Object> get props => [isValid];
}

class BottomNavBarError extends BottomNavBarState {
  final String failure;

  const BottomNavBarError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class GetUserTokenError extends BottomNavBarState {
  final String failure;

  const GetUserTokenError({required this.failure});

  @override
  List<Object> get props => [failure];
}

// Set And Get Value States
class SetAndGetValueLoading extends BottomNavBarState {
  @override
  List<Object> get props => [];
}

class SetAndGetValueLoaded extends BottomNavBarState {
  @override
  List<Object> get props => [];
}