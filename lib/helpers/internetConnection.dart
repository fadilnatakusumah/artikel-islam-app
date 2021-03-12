import 'dart:io';

Future<bool> checkIsConnected() async {
  bool connected = false;
  try {
    final result = await InternetAddress.lookup("google.com");
    print("result checkIsConnected $result");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connected = true;
    }
  } on SocketException catch (err) {
    print("error isConnected: $err");
  }
  return connected;
}
