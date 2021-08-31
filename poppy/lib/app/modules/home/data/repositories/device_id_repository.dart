import 'package:dartz/dartz.dart';
import 'package:poppy/app/modules/home/data/datasources/device_id_datource_interface.dart';
import 'package:poppy/app/modules/home/domain/repositories/device_id_repository_interface.dart';
import 'package:poppy/core/errors/exceptions.dart';
import 'package:poppy/core/errors/failures.dart';

class DeviceIdRepository implements IDeviceIdRepository {
  IDeviceIdDatasource datasource;

  DeviceIdRepository(this.datasource);
  @override
  Future<Either<Failure, String>> getDeviceId() async {
    try {
      final res = await datasource.getDeviceIdFromNative();

      return res.isNotEmpty ? Right(res) : Left(EmptyDeviceIdFailure());
    } on DeviceException {
      return Left(DeviceCallFailure());
    } on UnimplementedChannelException {
      return Left(DeviceCallFailure());
    }
  }
}
