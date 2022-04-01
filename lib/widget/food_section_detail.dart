import 'package:flutter/material.dart';

import '../data/model/detail_restaurant.dart';
import '../widget/card_item_detail.dart';

class FoodSectionDetail extends StatelessWidget {
  final Menus menus;

  FoodSectionDetail({required this.menus});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Foods",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CardItemDetail(
                name: menus.foods[index].name,
                isFood: true,
              );
            },
            itemCount: menus.foods.length,
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
          ),
        ),
      ],
    );
  }
}
