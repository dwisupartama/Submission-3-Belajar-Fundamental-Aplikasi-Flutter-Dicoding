import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/style.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant.dart';
import '../provider/database_favorite_provider.dart';
import '../provider/detail_restaurant_provider.dart';
import '../provider/review_restaurant_provider.dart';
import '../utils/result_state.dart';
import '../widget/add_review_section.dart';
import '../widget/card_item_review.dart';
import '../widget/category_box.dart';
import '../widget/drink_section_detail.dart';
import '../widget/food_section_detail.dart';
import '../widget/search_empty.dart';
import '../widget/search_loading.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/detail_restaurant';

  final String restaurant_id;

  RestaurantDetail({required this.restaurant_id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
          apiService: ApiService(), idRestaurant: restaurant_id),
      child: BodyRestaurantDetail(),
    );
  }
}

class BodyRestaurantDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return Column(
              children: [
                SearchLoading(
                  title: "Please Wait",
                  subtitle: "Loading restaurant data",
                ),
              ],
            );
          } else if (state.state == ResultState.hasData) {
            return DetailDescription(
              state: state,
            );
          } else if (state.state == ResultState.noData) {
            return Column(
              children: [
                SearchEmpty(
                  icon: Icons.restaurant_menu,
                  title: "No restaurant list ",
                  subtitle: "",
                ),
              ],
            );
          } else if (state.state == ResultState.error) {
            return Column(
              children: [
                SearchEmpty(
                  icon: Icons.cloud_off_sharp,
                  title: "Failed to load restaurant data ",
                  subtitle: "Please check your internet connection ",
                ),
              ],
            );
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}

class DetailDescription extends StatelessWidget {
  DetailRestaurantProvider state;

  DetailDescription({required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: "img${state.detailRestaurant.restaurant.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/large/${state.detailRestaurant.restaurant.pictureId}",
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 300.0,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Hero(
                        tag: "name${state.detailRestaurant.restaurant.id}",
                        child: Container(
                          child: Text(
                            state.detailRestaurant.restaurant.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      Hero(
                        tag: "location${state.detailRestaurant.restaurant.id}",
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: primaryTextColor.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              state.detailRestaurant.restaurant.address +
                                  ", " +
                                  state.detailRestaurant.restaurant.city,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 18,
                            color: secondaryColor,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            state.detailRestaurant.restaurant.rating.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: state.detailRestaurant.restaurant.categories
                            .map((e) => new CategoryBox(category: e.name))
                            .toList(),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        state.detailRestaurant.restaurant.description,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      FoodSectionDetail(
                          menus: state.detailRestaurant.restaurant.menus),
                      DrinkSectionDetail(
                          menus: state.detailRestaurant.restaurant.menus),
                      SizedBox(
                        height: 20.0,
                      ),
                      ReviewSection(state: state)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 40.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Consumer<DatabaseFavoriteProvider>(
                    builder: (context, result, child) {
                  return FutureBuilder<bool>(
                      future: result
                          .isFavorite(state.detailRestaurant.restaurant.id),
                      builder: (context, snapshot) {
                        var isFavorite = snapshot.data ?? false;
                        var dataRestaurant = Restaurant(
                          id: state.detailRestaurant.restaurant.id,
                          name: state.detailRestaurant.restaurant.name,
                          description:
                              state.detailRestaurant.restaurant.description,
                          pictureId:
                              state.detailRestaurant.restaurant.pictureId,
                          city: state.detailRestaurant.restaurant.city,
                          rating: state.detailRestaurant.restaurant.rating,
                        );
                        return isFavorite
                            ? InkWell(
                                onTap: () => result.removeFavorite(
                                    state.detailRestaurant.restaurant.id),
                                child: Container(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.favorite,
                                    color: secondaryColor,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () => result.addFavorite(dataRestaurant),
                                child: Container(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: secondaryColor,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              );
                      });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  final DetailRestaurantProvider state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Review",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 10.0,
        ),
        Consumer<ReviewRestaurantProvider>(
          builder: (context, result, _) {
            if (result.state == ResultStateReview.noAddReview) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: state.detailRestaurant.restaurant.customerReviews
                    .map((e) => new CardItemReview(
                          name: e.name,
                          date: e.date,
                          reviewText: e.review,
                        ))
                    .toList(),
              );
            } else if (result.state == ResultStateReview.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (result.state == ResultStateReview.hasData) {
              return Column(
                children: result.reviewResponse.customerReviews
                    .map((e) => new CardItemReview(
                          name: e.name,
                          date: e.date,
                          reviewText: e.review,
                        ))
                    .toList(),
              );
            } else if (result.state == ResultStateReview.noData) {
              return Text("No Data Review");
            } else if (result.state == ResultStateReview.error) {
              return Text("Error => ${result.message}");
            } else {
              return Text("");
            }
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        AddReviewSection(id: state.detailRestaurant.restaurant.id),
      ],
    );
  }
}
