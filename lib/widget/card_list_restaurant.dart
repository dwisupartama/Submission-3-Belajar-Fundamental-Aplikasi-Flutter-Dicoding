import 'package:flutter/material.dart';

import '../common/navigation.dart';
import '../common/style.dart';
import '../data/model/restaurant.dart';
import '../ui/restaurant_detail.dart';

class CardListRestaurant extends StatelessWidget {
  Restaurant restaurant;

  CardListRestaurant({required this.restaurant});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigation.intentWithData(RestaurantDetail.routeName, restaurant.id);
      },
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "img${restaurant.id}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                  width: 120,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 13,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: "name${restaurant.id}",
                      child: Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Hero(
                      tag: "location${restaurant.id}",
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: primaryTextColor.withOpacity(0.5),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: secondaryColor,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          restaurant.rating.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
