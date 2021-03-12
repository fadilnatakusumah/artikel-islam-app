import 'dart:convert';

import 'package:artikel_islam/constants/strings.dart';
import 'package:artikel_islam/models/article.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ArticleService with ChangeNotifier {
  SharedPreferences _prefs;
  List<Article> _savedArticles = [];

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    loadSavedArticles();
  }

  Future<List<Article>> searchArticle({
    CategoryArticle categoryArticle,
    String query,
  }) async {
    print("categoryArticle.endpointUrl: ${categoryArticle.endpointUrl}");
    List<Article> results = [];
    try {
      final request = await http.get("${categoryArticle.endpointUrl}?s=${query}");
      final response = json.decode(request.body);
      if (response["success"] == true) {
        final list = response["data"]["data"] as List;
        list.map((data) {
          results.add(new Article.fromJson(data));
        }).toList();
      }
    } catch (err) {
      print("err $err");
    }
    return results;
  }

  // Future<List<Article>> getListArticles(String endpointUrl) async {
  //   print("get list articles: ${endpointUrl}");
  //   http.get(endpointUrl).then((value) {
  //     final response = json.decode(value.body);
  //     final List<Article> results = [];
  //     if (response["success"] == true) {
  //       final list = response["data"]["data"] as List;
  //       list.map((data) {
  //         results.add(new Article.fromJson(data));
  //       });
  //     }
  //     return results;
  //   });
  // }

  Future<List<Article>> getListArticles(String endpointUrl) async {
    // return http
    //     .get(endpointUrl)
    //     .then((value) {
    //   final response = json.decode(value.body);
    //   // print('response $response');
    //   final List<Article> results = [];
    //   if (response["success"] == true) {
    //     final list = response["data"]["data"] as List;
    //   }
    // };
  }

  Future<void> saveToLocal(Article article) {
    print("===saving article===");
    if (_prefs == null) return null;
    final List<String> getArticles = _prefs.getStringList(LOCAL_ARTICLES);
    if (getArticles != null) {
      getArticles.add(json.encode(article.toMap()));
      _prefs.setStringList(LOCAL_ARTICLES, getArticles);
    } else {
      List<String> newListArticles = [];
      newListArticles.add(json.encode(article.toMap()));
      _prefs.setStringList(LOCAL_ARTICLES, newListArticles);
    }
    loadSavedArticles();
  }

  Future<void> unsaveFromLocal(Article article) {
    print("===unsaving article===");
    if (_prefs == null) return null;
    final listOfArticles = _prefs.getStringList(LOCAL_ARTICLES);
    listOfArticles.removeWhere((String element) {
      final Map<String, dynamic> articleMap = json.decode(element) as Map;
      return articleMap["id"] == article.id;
    });
    _prefs.setStringList(LOCAL_ARTICLES, listOfArticles);
    loadSavedArticles();
  }

  void loadSavedArticles() {
    print("===loading saved articles===");
    if (_prefs == null) return null;
    final List<Article> articles = [];
    final List<String> getArticles = _prefs.getStringList(LOCAL_ARTICLES);
    if (getArticles != null) {
      getArticles.forEach((element) {
        articles.add(Article.fromJson(json.decode(element)));
      });
    }
    this._savedArticles = articles;
    notifyListeners();
  }

  Article loadDetailArticle(Article article) {
    final List<String> listOfArticles = _prefs.getStringList(LOCAL_ARTICLES);

    var findArticle = listOfArticles.firstWhere((String element) {
      final savedArticle = json.decode(element);
      print("article saved $article");
      // print('article["id"] ${article["id"]}');
      // print('widget.article.id ${article.id}');
      return savedArticle["id"] == article.id;
    });
    return Article.fromJson(jsonDecode(findArticle));
  }

  get savedArticles {
    return _savedArticles;
  }

  bool isAlreadySaved(Article article) {
    try {
      var check = _savedArticles.firstWhere(
        (savedArticle) => article.id == savedArticle.id,
        orElse: () => null,
      );
      return check != null ? true : false;
    } catch (err) {
      print("err $err");
      return false;
    }
    // if (check != null) return true;
    print("article ${article.title}");
  }
}
