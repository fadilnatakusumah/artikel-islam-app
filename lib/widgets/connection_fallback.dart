// import 'package:artikel_islam/helpers/internetConnection.dart';
// import 'package:flutter/material.dart';
//
// class ConnectionFallback extends StatelessWidget {
//   final Widget child;
//
//   const ConnectionFallback({Key key, this.child}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: checkIsConnected(),
//         initialData: false,
//         builder: (context, AsyncSnapshot<bool> snapshot) {
//           print("snapshot.connectionState ${snapshot.connectionState}");
//           print("snapshot.data ${snapshot.data}");
//           if (snapshot.connectionState == ConnectionState.done &&
//               snapshot.data == true) {
//             print("1");
//             return child;
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             print("2");
//             return Container();
//           }
//           return Center(
//             child: Text("Internet tidak tersambung"),
//           );
//         });
//   }
// }
