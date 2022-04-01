import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './favorites_list.dart';
import './restaurant_detail.dart';
import './setting_screen.dart';
import '../provider/list_restaurant_provider.dart';
import '../ui/search_page.dart';
import '../utils/notification_helper.dart';
import '../utils/result_state.dart';
import '../widget/card_list_restaurant.dart';
import '../widget/search_empty.dart';
import '../widget/search_loading.dart';

class RestaurantList extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetail.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyRestaurantList(),
    );
  }
}

class BodyRestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SearchPage.routeName,
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          size: 24.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            FavoritesList.routeName,
                          );
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 24.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SettingScreen.routeName,
                          );
                        },
                        icon: Icon(
                          Icons.settings,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Restaurant",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Recomendation restaurant for you",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Consumer<ListRestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return SearchLoading(
                    title: "Please Wait",
                    subtitle: "Is loading restaurant list",
                  );
                } else if (state.state == ResultState.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        bottom: 40.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      shrinkWrap: true,
                      itemCount: state.restaurantList.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant =
                            state.restaurantList.restaurants[index];
                        return CardListRestaurant(
                          restaurant: restaurant,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                    ),
                  );
                } else if (state.state == ResultState.noData) {
                  return SearchEmpty(
                    icon: Icons.restaurant_menu,
                    title: "No restaurant list ",
                    subtitle: "",
                  );
                } else if (state.state == ResultState.error) {
                  return SearchEmpty(
                    icon: Icons.cloud_off_sharp,
                    title: "Failed to load restaurant data ",
                    subtitle: "Please check your internet connection ",
                  );
                } else {
                  return Center(child: Text(''));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
