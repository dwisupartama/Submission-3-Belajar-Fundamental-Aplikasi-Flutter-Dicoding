import 'package:flutter_test/flutter_test.dart';
import 'package:sub2_restaurant_app/data/model/list_restaurant.dart';

void main() {
  test("Checking Parsing Json on List Restaurant", () {
    var json = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
        {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description":
              "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
          "pictureId": "25",
          "city": "Gorontalo",
          "rating": 4
        }
      ]
    };

    final listRestaurant = ListRestaurant.fromJson(json);

    expect(listRestaurant.restaurants[0].id, "rqdv5juczeskfw1e867");
    expect(listRestaurant.restaurants[0].name, "Melting Pot");
    expect(listRestaurant.restaurants[0].description,
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...");
    expect(listRestaurant.restaurants[0].pictureId, "14");
    expect(listRestaurant.restaurants[0].city, "Medan");
    expect(listRestaurant.restaurants[0].rating, 4.2);
  });
}
