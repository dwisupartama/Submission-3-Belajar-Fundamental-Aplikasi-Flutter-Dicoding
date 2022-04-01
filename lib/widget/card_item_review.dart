import 'package:flutter/material.dart';

import '../common/style.dart';

class CardItemReview extends StatelessWidget {
  String name;
  String date;
  String reviewText;

  CardItemReview({
    required this.name,
    required this.date,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: 10.0,
          ),
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 15.0,
            bottom: 20.0,
          ),
          decoration: BoxDecoration(
            color: primaryTextColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 12,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                reviewText,
              ),
            ],
          ),
        )
      ],
    );
  }
}
