import 'package:equatable/equatable.dart';

class GuestPriceModel extends Equatable {
  final String price;
  final String currency;

  const GuestPriceModel({required this.price, required this.currency});

  factory GuestPriceModel.fromJson(Map<String, dynamic> map) {
    return GuestPriceModel(
      price: map['locationPrice'].toString(),
      currency: map['currency'].toString(),
    );
  }

  @override
  List<Object?> get props => [price, currency];
}
