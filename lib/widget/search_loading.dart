import 'package:flutter/material.dart';

class SearchLoading extends StatelessWidget {
  String title;
  String subtitle;

  SearchLoading({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20.0,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
