import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectionService {
  static bool isNetworkAvailable = false;

  static Future<bool> init() async {
    _listenForConnectivityChanges();
    ConnectivityResult connectionResult = await Connectivity().checkConnectivity();
    isNetworkAvailable = connectionResult != ConnectivityResult.none;
    return isNetworkAvailable;
  }

  static void _listenForConnectivityChanges() {
    networkAvailableStream().listen((event) => isNetworkAvailable = event);
  }

  static Stream<bool> networkAvailableStream() =>
      Connectivity().onConnectivityChanged.map((event) => event != ConnectivityResult.none);
}
