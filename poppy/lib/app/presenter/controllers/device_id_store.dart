import 'package:flutter_triple/flutter_triple.dart';
import 'package:poppy/app/domain/usecases/get_device_id_usecase.dart';
import 'package:poppy/core/errors/failures.dart';

class DeviceIdStore extends NotifierStore<Failure, String> {
  final GetDeviceIdUsecase _deviceIdUsecase;
  DeviceIdStore(this._deviceIdUsecase) : super('');

  getDeviceId() async {
    setLoading(true);

    final result = await _deviceIdUsecase();

    result.fold((l) => update('Erro ao buscar id do device'), (r) => update(r));

    setLoading(false);
  }
}
