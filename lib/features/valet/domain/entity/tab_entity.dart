import 'package:equatable/equatable.dart';

class TabEntity extends Equatable {
  final int id;
  final String text;

  const TabEntity({required this.id, required this.text});

  @override
  List<Object?> get props => [id, text];
}
