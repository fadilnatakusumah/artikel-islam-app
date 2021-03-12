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
      ),
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
    );
  }
}

class User {
  final String nama;
  final int nomor;

  User(this.nama, this.nomor);
}
