import 'package:flutter/material.dart';

import '../data/model/detail_restaurant.dart';
import '../widget/card_item_detail.dart';

class DrinkSectionDetail extends StatelessWidget {
  final Menus menus;

  DrinkSectionDetail({required this.menus});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Drinks",
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
                name: menus.drinks[index].name,
                isFood: false,
              );
            },
            itemCount: menus.drinks.length,
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
          ),
        ),
      ],
    );
  }
}
