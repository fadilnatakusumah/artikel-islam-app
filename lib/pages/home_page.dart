import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:artikel_islam/constants/api_endpoint.dart';
import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/widgets/article_section.dart';
import 'package:artikel_islam/widgets/popular_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  final listData = <User>[];

  Future<void> getListData() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(milliseconds: 2500));
    setState(() => isLoading = false);
  }

  Widget _buildWidgetListDataAndroid() {
    return RefreshIndicator(
        onRefresh: getListData,
        child: Column(
          children: [
            PopularCategories(isLoading: isLoading),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  ArticleSection(
                    endpointUrl: ApiEndpoint.KONSULTASI_SYARIAH,
                    title: "Konsultasi Syariah",
                  ),
                  ArticleSection(
                    endpointUrl: ApiEndpoint.KONSULTASI_SYARIAH,
                    title: "Konsultasi Syariah",
                  )
                ],
              ),
            ),
          ],
        )
        // ListView.builder(
        //   padding: EdgeInsets.all(16),
        //   itemBuilder: (context, index) {
        //     var user = listData[index];
        //     return Card(
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(user.nama),
        //             Text(
        //               '${user.nomor}',
        //               style: Theme.of(context).textTheme.caption,
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        //   itemCount: listData.length,
        // ),
        );
  }

  Future refreshData() async {
    listData.clear();
    await Future.delayed(Duration(seconds: 2));
    for (var index = 0; index < 10; index++) {
      var nama = 'User ${index + 1}';
      var nomor = Random().nextInt(100);
      listData.add(User(nama, nomor));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          color: Colors.grey,
        ),
        backgroundColor: Colors.transparent,
        title: Text("Artikel"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            color: Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border_outlined),
            onPressed: () {},
            color: Colors.grey,
          )
        ],
      ),
      body: Platform.isIOS
          ? Container()
          : Provider.value(
              value: isLoading,
              updateShouldNotify: (_, __) => true,
              child: _buildWidgetListDataAndroid(),
            ),
      // body: SingleChildScrollView(
      //   child: RefreshIndicator(
      //     onRefresh: getListData,
      //     child: Container(
      //       child: Text(isLoading ? "LOADING" : "DONE"),
      //     ),
      //   ),
      //   // child: Container(
      //   //   color: Colors.transparent,
      //   //   child: Column(
      //   //     children: [
      //   //       Container(
      //   //         height: 30,
      //   //         margin: EdgeInsets.all(12),
      //   //         child: ListView(
      //   //           scrollDirection: Axis.horizontal,
      //   //           children: [
      //   //             Container(
      //   //               padding:
      //   //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //   //               margin: EdgeInsets.only(right: 5),
      //   //               child: Text(
      //   //                 "Konsultasi Syariah",
      //   //                 style: TextStyle(
      //   //                     color: Colors.white,
      //   //                     fontWeight: FontWeight.bold,
      //   //                     fontSize: 15),
      //   //               ),
      //   //               decoration: BoxDecoration(
      //   //                   color: Colors.red,
      //   //                   borderRadius: BorderRadius.circular(20)),
      //   //             ),
      //   //             Container(
      //   //               padding:
      //   //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //   //               margin: EdgeInsets.only(right: 5),
      //   //               child: Text(
      //   //                 "Muslimorid",
      //   //                 style: TextStyle(
      //   //                     color: Colors.white,
      //   //                     fontWeight: FontWeight.bold,
      //   //                     fontSize: 15),
      //   //               ),
      //   //               decoration: BoxDecoration(
      //   //                   color: Colors.blueAccent,
      //   //                   borderRadius: BorderRadius.circular(20)),
      //   //             ),
      //   //             Container(
      //   //               padding:
      //   //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //   //               margin: EdgeInsets.only(right: 5),
      //   //               child: Text(
      //   //                 "Rumaysho",
      //   //                 style: TextStyle(
      //   //                     color: Colors.white,
      //   //                     fontWeight: FontWeight.bold,
      //   //                     fontSize: 15),
      //   //               ),
      //   //               decoration: BoxDecoration(
      //   //                   color: Colors.deepOrange,
      //   //                   borderRadius: BorderRadius.circular(20)),
      //   //             ),
      //   //             Container(
      //   //               padding:
      //   //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //   //               margin: EdgeInsets.only(right: 5),
      //   //               child: Text(
      //   //                 "Firanda.com",
      //   //                 style: TextStyle(
      //   //                     color: Colors.white,
      //   //                     fontWeight: FontWeight.bold,
      //   //                     fontSize: 15),
      //   //               ),
      //   //               decoration: BoxDecoration(
      //   //                   color: Colors.lightBlueAccent,
      //   //                   borderRadius: BorderRadius.circular(20)),
      //   //             ),
      //   //             // Container(width: 100, child: Text("Muslimorid")),
      //   //             // Container(width: 100, child: Text("Rumaysho"))
      //   //           ],
      //   //         ),
      //   //       ),
      //   //       Column(
      //   //         crossAxisAlignment: CrossAxisAlignment.start,
      //   //         children: [
      //   //           Padding(
      //   //             padding: const EdgeInsets.only(top: 12.0, left: 12.0),
      //   //             child: Text(
      //   //               "Konsultasi Syariah",
      //   //               textAlign: TextAlign.left,
      //   //               style: TextStyle(
      //   //                 fontSize: 18,
      //   //               ),
      //   //             ),
      //   //           ),
      //   //           Container(
      //   //             height: 250,
      //   //             padding: EdgeInsets.all(10),
      //   //             child: isLoading
      //   //                 ? ListSkeleton(
      //   //                     style: SkeletonStyle(
      //   //                       theme: SkeletonTheme.Light,
      //   //                       isShowAvatar: false,
      //   //                       barCount: 3,
      //   //                       colors: [
      //   //                         Colors.grey,
      //   //                         Colors.black12,
      //   //                         Colors.black26,
      //   //                       ],
      //   //                       isAnimation: true,
      //   //                     ),
      //   //                   )
      //   //                 : ListView(
      //   //                     scrollDirection: Axis.horizontal,
      //   //                     children: renderKonsultasiSyariah,
      //   //                     // [
      //   //                     //   Card(
      //   //                     //     child: Column(
      //   //                     //       children: [
      //   //                     //         Image.network(
      //   //                     //           "https://i1.sndcdn.com/artworks-000249209479-6tn1y6-t500x500.jpg",
      //   //                     //           height: 150,
      //   //                     //         )
      //   //                     //       ],
      //   //                     //     ),
      //   //                     //   )
      //   //                     // ],
      //   //                   ),
      //   //           )
      //   //         ],
      //   //       )
      //   //     ],
      //   //   ),
      //   // ),
      // ),
    );
  }
}

class User {
  final String nama;
  final int nomor;

  User(this.nama, this.nomor);
}
