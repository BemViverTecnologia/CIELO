import 'package:dartz/dartz.dart';
import 'package:poppy/core/errors/failures.dart';

abstract class UsecaseWithoutInput<Output> {
  Future<Either<Failure, Output>> call();
}
