part of 'wallet_cubit.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  @override
  List<Object> get props => [];
}

class WalletLoading extends WalletState {
  @override
  List<Object> get props => [];
}

class ExecutePaymentLoading extends WalletState {
  @override
  List<Object> get props => [];
}

class WalletLoaded extends WalletState {
  final List<WalletModel> model;

  const WalletLoaded({required this.model});

  @override
  List<Object> get props => [model];
}

class ExecutePaymentLoaded extends WalletState {
  final MFDirectPaymentResponse model;

  const ExecutePaymentLoaded({required this.model});

  @override
  List<Object> get props => [model];
}

class WalletError extends WalletState {
  final String failure;

  const WalletError({required this.failure});

  @override
  List<Object> get props => [failure];
}
