import 'package:flutter/cupertino.dart';

import '../data/api/api_service.dart';
import '../data/model/search_restaurant.dart';
import '../utils/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    _fetchSearchRestaurant();
  }

  late SearchRestaurant _searchRestaurant;
  late ResultStateSearch _state;
  String _message = "";
  String key = "";

  SearchRestaurant get searchRestaurant => _searchRestaurant;
  ResultStateSearch get state => _state;
  String get message => _message;

  Future<dynamic> _fetchSearchRestaurant() async {
    if (key != "") {
      try {
        _state = ResultStateSearch.loading;
        notifyListeners();
        final result = await apiService.searchRestaurant(key);
        if (result.restaurants.isEmpty) {
          _state = ResultStateSearch.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultStateSearch.hasData;
          notifyListeners();
          return _searchRestaurant = result;
        }
      } catch (e) {
        _state = ResultStateSearch.error;
        notifyListeners();
        return _message = 'Error : $e';
      }
    } else {
      _state = ResultStateSearch.noKey;
      notifyListeners();
      return _message = 'No Key';
    }
  }

  void addSearchKey(String key) {
    this.key = key;
    _fetchSearchRestaurant();
    notifyListeners();
  }
}
