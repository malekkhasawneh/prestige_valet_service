part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoading extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoaded extends SplashState {
  final bool isLogin;

 const SplashLoaded({required this.isLogin});
  @override
  List<Object> get props => [isLogin];
}
class SplashError extends SplashState {
  final String failure;

 const SplashError({required this.failure});
  @override
  List<Object> get props => [failure];
}
