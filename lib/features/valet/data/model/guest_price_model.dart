import 'package:equatable/equatable.dart';

class GuestPriceModel extends Equatable {
  final double price;
  final double currency;

  const GuestPriceModel({required this.price, required this.currency});

  factory GuestPriceModel.fromJson(Map<String, dynamic> map) {
    return GuestPriceModel(
      price: map['locationPrice'],
      currency: map['currency'],
    );
  }

  @override
  List<Object?> get props => [price, currency];
}
