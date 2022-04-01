import 'package:flutter_test/flutter_test.dart';
import 'package:sub2_restaurant_app/data/model/review_response.dart';

void main() {
  test("Checking Parsing Json on Review Response", () {
    var json = {
      "error": false,
      "message": "success",
      "customerReviews": [
        {
          "name": "Ahmad",
          "review": "Tidak rekomendasi untuk pelajar!",
          "date": "13 November 2019"
        },
        {
          "name": "test",
          "review": "makanannya lezat",
          "date": "29 Oktober 2020"
        }
      ]
    };

    final reviewResponse = ReviewResponse.fromJson(json);

    expect(reviewResponse.customerReviews[0].name, "Ahmad");
    expect(reviewResponse.customerReviews[0].review,
        "Tidak rekomendasi untuk pelajar!");
    expect(reviewResponse.customerReviews[0].date, "13 November 2019");
  });
}
