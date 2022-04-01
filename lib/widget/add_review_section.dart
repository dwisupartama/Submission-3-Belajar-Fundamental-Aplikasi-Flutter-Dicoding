import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/style.dart';
import '../provider/review_restaurant_provider.dart';

class AddReviewSection extends StatefulWidget {
  String id;

  AddReviewSection({required this.id});

  @override
  State<AddReviewSection> createState() => _AddReviewSectionState();
}

class _AddReviewSectionState extends State<AddReviewSection> {
  final fullNameController = TextEditingController();
  final reviewController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider =
        Provider.of<ReviewRestaurantProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Add Review",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: [
            TextField(
              cursorColor: secondaryColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                fillColor: primaryColor.withOpacity(0.3),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                prefixIcon: Icon(
                  Icons.person,
                  color: secondaryColor,
                  size: 20,
                ),
                hintText: "Full Name",
              ),
              style: TextStyle(fontSize: 14),
              controller: fullNameController,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              cursorColor: secondaryColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                fillColor: primaryColor.withOpacity(0.3),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                hintText: "Review",
              ),
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: 6,
              style: TextStyle(fontSize: 14),
              controller: reviewController,
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                ElevatedButton(
                  onPressed: () {
                    reviewProvider.addReview(widget.id, fullNameController.text,
                        reviewController.text);
                  },
                  child: Text("Review"),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
