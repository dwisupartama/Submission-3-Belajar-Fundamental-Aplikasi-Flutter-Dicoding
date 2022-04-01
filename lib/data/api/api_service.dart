import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/detail_restaurant.dart';
import '../model/list_restaurant.dart';
import '../model/review_response.dart';
import '../model/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<ListRestaurant> allRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load all restaurant');
    }
  }

  Future<DetailRestaurant> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/" + id));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load all restaurant');
    }
  }

  Future<SearchRestaurant> searchRestaurant(String key) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=" + key));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search restaurant');
    }
  }

  Future<ReviewResponse> addReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse(_baseUrl + "review"),
      body: {
        "id": id,
        "name": name,
        "review": review,
      },
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return ReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load review restaurant : ${response.statusCode}');
    }
  }
}
