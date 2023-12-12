import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class AllNewsController with ChangeNotifier {
  bool isLoading = true;
  NewsApiModel? newsModel;
  fetchAllNews({String category = 'general'}) async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=b35895efdc4d4c369c9ed3722afdd421');
    final response = await http.get(url);
    final decodedData = jsonDecode(response.body);
    if (decodedData['status'] == "ok") {
      newsModel = NewsApiModel.fromJson(decodedData);
    } else {
      print('Fetch Failed');
    }
    isLoading = false;
    notifyListeners();
  }
}
