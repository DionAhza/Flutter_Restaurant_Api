import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';

import '../providers/review_provider.dart';
import '../services/api_service.dart';

class ReviewForm extends StatefulWidget {

  final String restaurantId;

  const ReviewForm({
    super.key,
    required this.restaurantId,
  });

  @override
  State<ReviewForm> createState() =>
      _ReviewFormState();

}

class _ReviewFormState extends State<ReviewForm> {

  final nameController = TextEditingController();

  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

      create: (_) => ReviewProvider(ApiService()),

      child: Consumer<ReviewProvider>(

        builder: (context, provider, child) {

          return Column(

            children: [

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Your Name",
                ),
              ),

              TextField(
                controller: reviewController,
                decoration: InputDecoration(
                  labelText: "Your Review",
                ),
              ),

              SizedBox(height: 10),

              ElevatedButton(

                onPressed: provider.state ==
                        ResultState.loading
                    ? null
                    : () async {

                        await provider.postReview(

                          id: widget.restaurantId,

                          name: nameController.text,

                          review:
                              reviewController.text,

                        );

                        ScaffoldMessenger.of(context)
                            .showSnackBar(

                          SnackBar(
                            content:
                                Text("Review berhasil"),
                          ),

                        );

                      },

                child: provider.state ==
                        ResultState.loading
                    ? CircularProgressIndicator()
                    : Text("Submit Review"),

              ),

            ],

          );

        },

      ),

    );

  }

}