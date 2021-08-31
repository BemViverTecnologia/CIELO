import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NoDeviceIdFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NoProductsFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class GetDeviceIdFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyDeviceIdFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class DeviceCallFailure extends Failure {
  @override
  List<Object?> get props => [];
}
