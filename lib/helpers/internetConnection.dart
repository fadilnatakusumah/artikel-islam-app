import 'dart:io';
import 'package:connectivity/connectivity.dart';

Future<bool> checkIsConnected() async {
  bool connected = false;

  var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
// // I am connected to a mobile network.
//   } else if (connectivityResult == ConnectivityResult.wifi) {
// // I am connected to a wifi network.
//   }
  try {
    final result = await InternetAddress.lookup("google.com");
    print("result checkIsConnected $result");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connected = true;
    }
  } on SocketException catch (err) {
    print("error isConnected: $err");
  }

  print("connectivityResult $connectivityResult");
  print("connected $connected");
  if (connected && connectivityResult != ConnectivityResult.none) {
    return true;
  }
  return false;
}
