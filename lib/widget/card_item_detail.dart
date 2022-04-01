import 'package:flutter/material.dart';

import '../common/style.dart';

class CardItemDetail extends StatelessWidget {
  final String name;
  final bool isFood;

  CardItemDetail({required this.name, required this.isFood});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              (isFood)
                  ? "https://thumbs.dreamstime.com/b/healthy-food-background-fruits-vegetables-cereal-nuts-superfood-dietary-balanced-vegetarian-eating-products-kitchen-143677456.jpg"
                  : "https://thumbs.dreamstime.com/b/chilled-colorful-beverages-ice-box-summer-party-bottled-41740719.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 16.0,
              color: primaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "IDR 50.000",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
