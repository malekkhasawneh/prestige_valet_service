import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/features/payment_gateway/data/datasource/payment_gateway_remote_datasource.dart';
import 'package:prestige_valet_app/features/payment_gateway/domain/repository/payment_gateway_repository.dart';

class PaymentGatewayRepositoryImpl implements PaymentGatewayRepository {
  final NetworkInfo networkInfo;
  final PaymentGatewayRemoteDataSource remoteDataSource;

  PaymentGatewayRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
}
