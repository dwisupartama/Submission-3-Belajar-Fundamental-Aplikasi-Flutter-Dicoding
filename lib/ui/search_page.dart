import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/style.dart';
import '../provider/search_restaurant_provider.dart';
import '../widget/search_restaurant_list.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodySearchPage(),
    );
  }
}

class BodySearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchProvider =
        Provider.of<SearchRestaurantProvider>(context, listen: false);
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
                    "Search",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Search the restaurant you want",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: secondaryColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: primaryTextColor.withOpacity(0.05),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: secondaryColor,
                              size: 20,
                            ),
                            hintText: "Search Restaurant",
                          ),
                          style: TextStyle(fontSize: 14),
                          onSubmitted: (value) {
                            searchProvider.addSearchKey(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SearchRestaurantList(),
          ],
        ),
      ),
    );
  }
}
