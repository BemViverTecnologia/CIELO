import 'package:flutter/services.dart';
import 'package:poppy/shared/utils/keys/channels.dart';

class MethodChannels {
  static MethodChannel get lioChannel => MethodChannel(Channels.lioChannel);
}
