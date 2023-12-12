import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  NewsApiModel? news_model;

  bool isLoading = true;
  Future<void> fetchNewsHomeScreen() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=b35895efdc4d4c369c9ed3722afdd421');
    final response = await http.get(url);
    final decodedData = jsonDecode(response.body);
    if (decodedData['status'] == "ok") {
      news_model = NewsApiModel.fromJson(decodedData);
    } else {
      print('Fetch Failed');
    }
    isLoading = false;
    notifyListeners();
  }
}
