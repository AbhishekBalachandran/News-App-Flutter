import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:http/http.dart' as http;

class SearchScreenController with ChangeNotifier {
  NewsApiModel? news_model;
  bool isLoading = true;

  Future<void> fetchNewsSearchScreen({String searchKeyword = 'general'}) async {
    isLoading = true;
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?q=$searchKeyword&apiKey=b35895efdc4d4c369c9ed3722afdd421');
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
