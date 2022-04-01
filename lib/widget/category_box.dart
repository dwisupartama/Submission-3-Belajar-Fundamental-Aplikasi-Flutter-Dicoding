import 'package:flutter/material.dart';

import '../common/style.dart';

class CategoryBox extends StatelessWidget {
  String category;

  CategoryBox({required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            category,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          decoration: BoxDecoration(
            color: primaryTextColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
