import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/search_restaurant_provider.dart';
import '../utils/result_state.dart';
import '../widget/card_list_restaurant.dart';
import '../widget/search_empty.dart';
import '../widget/search_loading.dart';

class SearchRestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, result, _) {
        if (result.state == ResultStateSearch.noKey) {
          return SearchEmpty(
            icon: Icons.search,
            title: "Type what restaurant",
            subtitle: "you want to search",
          );
        } else if (result.state == ResultStateSearch.loading) {
          return SearchLoading(
            title: "Please Wait",
            subtitle: "Looking for a restaurant ",
          );
        } else if (result.state == ResultStateSearch.hasData) {
          return Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                bottom: 40.0,
                left: 20.0,
                right: 20.0,
              ),
              shrinkWrap: true,
              itemCount: result.searchRestaurant.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = result.searchRestaurant.restaurants[index];
                return CardListRestaurant(
                  restaurant: restaurant,
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
            ),
          );
        } else if (result.state == ResultStateSearch.noData) {
          return SearchEmpty(
            icon: Icons.search_off,
            title: "Keyword not found",
            subtitle: "Please enter another keyword",
          );
        } else if (result.state == ResultStateSearch.error) {
          return SearchEmpty(
            icon: Icons.cloud_off_sharp,
            title: "Failed to load restaurant data ",
            subtitle: "Please check your internet connection ",
          );
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}
