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

class GenerateQrLoading extends ScanQrState {
  @override
  List<Object> get props => [];
}

class GenerateQrLoaded extends ScanQrState {
  final ParkedCarsModel parkedCarsModel;

  const GenerateQrLoaded({required this.parkedCarsModel});

  @override
  List<Object> get props => [parkedCarsModel];
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

class RetrieveGuestCarLoaded extends ScanQrState {
  @override
  List<Object> get props => [];
}

class RetrieveGuestCarLoadedError extends ScanQrState {
  final String failure;

  const RetrieveGuestCarLoadedError({required this.failure});

  @override
  List<Object> get props => [failure];
}
class PrinterNotConnectedError extends ScanQrState {
  final String failure;

  const PrinterNotConnectedError({required this.failure});

  @override
  List<Object> get props => [failure];
}
class SetValueLoading extends ScanQrState {
  @override
  List<Object> get props => [];
}
class SetValueLoaded extends ScanQrState {
  @override
  List<Object> get props => [];
}