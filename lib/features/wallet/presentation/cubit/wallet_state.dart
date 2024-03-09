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

class WalletLoaded extends WalletState {
  final List<WalletModel> model;

  const WalletLoaded({required this.model});

  @override
  List<Object> get props => [model];
}

class WalletError extends WalletState {
  final String failure;

  const WalletError({required this.failure});

  @override
  List<Object> get props => [failure];
}

// Execute Payment States
class ExecutePaymentLoading extends WalletState {
  @override
  List<Object> get props => [];
}

class ExecutePaymentLoaded extends WalletState {
  final bool status;

  const ExecutePaymentLoaded({required this.status});

  @override
  List<Object> get props => [status];
}

class ExecutePaymentError extends WalletState {
  final String error;

  const ExecutePaymentError({required this.error});

  @override
  List<Object> get props => [error];
}

// Send Payment States
class SendPaymentLoading extends WalletState {
  @override
  List<Object> get props => [];
}

class SendPaymentLoaded extends WalletState {
  final bool status;

  const SendPaymentLoaded({required this.status});

  @override
  List<Object> get props => [status];
}

class SendPaymentError extends WalletState {
  final String error;

  const SendPaymentError({required this.error});

  @override
  List<Object> get props => [error];
}