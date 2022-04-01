import 'package:flutter/cupertino.dart';

import '../data/api/api_service.dart';
import '../data/model/list_restaurant.dart';
import '../utils/result_state.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late ListRestaurant _restaurantList;
  late ResultState _state;
  String _message = "";

  ListRestaurant get restaurantList => _restaurantList;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.allRestaurant();
      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error : $e';
    }
  }
}
