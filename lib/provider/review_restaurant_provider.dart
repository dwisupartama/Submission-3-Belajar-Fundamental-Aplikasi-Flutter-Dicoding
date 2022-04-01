import 'package:flutter/cupertino.dart';

import '../data/api/api_service.dart';
import '../data/model/review_response.dart';
import '../utils/result_state.dart';

class ReviewRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewRestaurantProvider({required this.apiService}) {
    _fetchReviewRestaurant();
  }

  late ReviewResponse _reviewResponse;
  late ResultStateReview _state;
  String _message = "";
  late String _id;
  late String _name;
  late String _review;
  bool _isAddReview = false;

  ReviewResponse get reviewResponse => _reviewResponse;
  ResultStateReview get state => _state;
  String get message => _message;

  Future<dynamic> _fetchReviewRestaurant() async {
    if (_isAddReview) {
      try {
        _state = ResultStateReview.loading;
        notifyListeners();
        final result = await apiService.addReview(_id, _name, _review);
        if (result.customerReviews.isEmpty) {
          _state = ResultStateReview.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultStateReview.hasData;
          notifyListeners();
          return _reviewResponse = result;
        }
      } catch (e) {
        _state = ResultStateReview.error;
        notifyListeners();
        return _message = 'Error : $e';
      }
      _isAddReview = false;
    } else {
      _state = ResultStateReview.noAddReview;
      notifyListeners();
      return _message = 'No Add Review';
    }
  }

  void addReview(String id, String name, String review) {
    if (name != "" || review != "") {
      _id = id;
      _name = name;
      _review = review;
      _isAddReview = true;

      _fetchReviewRestaurant();

      notifyListeners();
    }
  }
}
