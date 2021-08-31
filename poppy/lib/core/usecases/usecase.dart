import 'package:dartz/dartz.dart';
import 'package:poppy/core/errors/failures.dart';

abstract class Usecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

class NoParams {}
