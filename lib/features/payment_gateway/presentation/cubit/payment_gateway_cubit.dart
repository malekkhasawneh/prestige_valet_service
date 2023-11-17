import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_gateway_state.dart';

class PaymentGatewayCubit extends Cubit<PaymentGatewayState> {
  PaymentGatewayCubit() : super(PaymentGatewayInitial());
}
