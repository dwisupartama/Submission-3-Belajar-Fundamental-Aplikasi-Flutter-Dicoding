import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/database_favorite_provider.dart';
import '../utils/result_state.dart';
import '../widget/card_list_restaurant.dart';
import '../widget/search_empty.dart';
import '../widget/search_loading.dart';

class FavoritesList extends StatelessWidget {
  static const routeName = '/favorites_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyFavoritesList(),
    );
  }
}

class BodyFavoritesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 24.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Favorite Restaurant",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "A list of your favorite restaurants ",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Consumer<DatabaseFavoriteProvider>(
              builder: (context, result, child) {
                if (result.state == ResultState.loading) {
                  return SearchLoading(
                    title: "Please Wait",
                    subtitle: "Is loading restaurant list",
                  );
                } else if (result.state == ResultState.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        bottom: 40.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      shrinkWrap: true,
                      itemCount: result.favorite.length,
                      itemBuilder: (context, index) {
                        var restaurant = result.favorite[index];
                        return CardListRestaurant(
                          restaurant: restaurant,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                    ),
                  );
                } else {
                  return SearchEmpty(
                    icon: Icons.restaurant_menu,
                    title: "No restaurant list ",
                    subtitle: result.message,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
