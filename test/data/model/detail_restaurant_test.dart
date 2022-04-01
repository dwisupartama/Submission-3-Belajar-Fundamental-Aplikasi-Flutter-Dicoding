import 'package:flutter_test/flutter_test.dart';
import 'package:sub2_restaurant_app/data/model/detail_restaurant.dart';

void main() {
  test("Checking Parsing Json on Detail Restaurant", () {
    var json = {
      "error": false,
      "message": "success",
      "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
          {"name": "Italia"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"}
          ],
          "drinks": [
            {"name": "Es krim"}
          ]
        },
        "rating": 4.2,
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          }
        ]
      }
    };

    final detailRestaurant = DetailRestaurant.fromJson(json);

    expect(detailRestaurant.restaurant.id, "rqdv5juczeskfw1e867");
    expect(detailRestaurant.restaurant.name, "Melting Pot");
    expect(detailRestaurant.restaurant.description,
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...");
    expect(detailRestaurant.restaurant.city, "Medan");
    expect(detailRestaurant.restaurant.address, "Jln. Pandeglang no 19");
    expect(detailRestaurant.restaurant.pictureId, "14");
    expect(detailRestaurant.restaurant.categories[0].name, "Italia");
    expect(detailRestaurant.restaurant.menus.foods[0].name, "Paket rosemary");
    expect(detailRestaurant.restaurant.menus.drinks[0].name, "Es krim");
    expect(detailRestaurant.restaurant.rating, 4.2);
    expect(detailRestaurant.restaurant.customerReviews[0].name, "Ahmad");
    expect(detailRestaurant.restaurant.customerReviews[0].review,
        "Tidak rekomendasi untuk pelajar!");
    expect(detailRestaurant.restaurant.customerReviews[0].date,
        "13 November 2019");
  });
}
