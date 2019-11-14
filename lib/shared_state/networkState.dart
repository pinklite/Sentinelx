import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sentinelx/channels/NetworkChannel.dart';

class NetworkState extends ChangeNotifier {
  NetworkState._privateConstructor();

  static final NetworkState _instance = NetworkState._privateConstructor();

  TorStatus torStatus = TorStatus.IDLE;
  factory NetworkState() {
    return _instance;
  }

  void startTor() {
    NetworkChannel().startTor();
  }

  setTorStatus(TorStatus status) {
    this.torStatus = status;
    this.notifyListeners();
  }
}