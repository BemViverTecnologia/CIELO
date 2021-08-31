import 'package:dartz/dartz.dart';
import 'package:poppy/core/errors/failures.dart';

abstract class IDeviceIdRepository {
  Future<Either<Failure, String>> getDeviceId();
}
