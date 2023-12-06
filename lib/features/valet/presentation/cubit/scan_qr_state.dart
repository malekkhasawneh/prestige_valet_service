part of 'scan_qr_cubit.dart';

abstract class ScanQrState extends Equatable {
  const ScanQrState();
}

class ScanQrInitial extends ScanQrState {
  @override
  List<Object> get props => [];
}
class ScanQrLoading extends ScanQrState {
  @override
  List<Object> get props => [];
}

class ScanQrLoaded extends ScanQrState {
  final ParkedCarsModel parkedCarsModel;

  const ScanQrLoaded({required this.parkedCarsModel});

  @override
  List<Object> get props => [parkedCarsModel];
}

class GetValetHistoryLoaded extends ScanQrState {
  final ParkHistoryModel valetHistoryModel;

  const GetValetHistoryLoaded({required this.valetHistoryModel});

  @override
  List<Object> get props => [valetHistoryModel];
}

class ScanQrError extends ScanQrState {
  final String failure;

  const ScanQrError({required this.failure});

  @override
  List<Object> get props => [failure];
}
