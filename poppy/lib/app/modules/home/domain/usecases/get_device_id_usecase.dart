import 'package:poppy/app/modules/home/domain/repositories/device_id_repository_interface.dart';
import 'package:poppy/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poppy/core/usecases/usecase_without_input.dart';

class GetDeviceIdUsecase implements UsecaseWithoutInput<String> {
  IDeviceIdRepository repository;

  GetDeviceIdUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call() async {
    return repository.getDeviceId();
  }
}
