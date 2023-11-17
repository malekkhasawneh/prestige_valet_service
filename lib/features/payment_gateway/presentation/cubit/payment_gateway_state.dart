part of 'payment_gateway_cubit.dart';

abstract class PaymentGatewayState extends Equatable {
  const PaymentGatewayState();
}

class PaymentGatewayInitial extends PaymentGatewayState {
  @override
  List<Object> get props => [];
}

class PaymentGatewayLoading extends PaymentGatewayState {
  @override
  List<Object> get props => [];
}
class PaymentGatewayLoaded extends PaymentGatewayState {
  @override
  List<Object> get props => [];
}
class PaymentGatewayError extends PaymentGatewayState {
  final String failure;

  const PaymentGatewayError({required this.failure});
  @override
  List<Object> get props => [failure];
}
