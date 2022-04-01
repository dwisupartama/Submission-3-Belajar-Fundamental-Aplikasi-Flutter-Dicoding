import 'package:flutter/cupertino.dart';

import '../data/api/api_service.dart';
import '../data/model/detail_restaurant.dart';
import '../utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String idRestaurant;

  DetailRestaurantProvider({
    required this.apiService,
    required this.idRestaurant,
  }) {
    _fetchDetailRestaurant();
  }

  late DetailRestaurant _detailRestaurant;
  late ResultState _state;
  String _message = "";

  DetailRestaurant get detailRestaurant => _detailRestaurant;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.detailRestaurant(idRestaurant);
      if (result.restaurant.name == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error : $e';
    }
  }
}
