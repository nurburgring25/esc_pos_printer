/*
 * esc_pos_printer
 * Created by Andrey Ushakov
 * 
 * Copyright (c) 2019-2020. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:io';

import 'enums.dart';

class NetworkPrinter {
  late Socket _socket;

  Future<PosPrintResult> connect(String host, {
    int port = 9100,
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      _socket = await Socket.connect(host, port, timeout: timeout);

      return Future<PosPrintResult>.value(PosPrintResult.success);
    } catch (e) {
      return Future<PosPrintResult>.value(PosPrintResult.timeout);
    }
  }

  /// [delayMs]: milliseconds to wait after destroying the socket
  void disconnect({int? delayMs}) async {
    _socket.destroy();
    if (delayMs != null) {
      await Future.delayed(Duration(milliseconds: delayMs), () => null);
    }
  }

  void rawBytes(List<int> cmd, {bool isKanji = false}) {
    _socket.add(cmd);
  }
}