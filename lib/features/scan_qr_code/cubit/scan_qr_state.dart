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
  @override
  List<Object> get props => [];
}
