import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/review_provider.dart';
import '../providers/restaurant_detail_provider.dart';
import '../providers/restaurant_provider.dart';  
import '../services/api_service.dart';

class ReviewForm extends StatefulWidget {
  final String restaurantId;

  const ReviewForm({
    super.key,
    required this.restaurantId,
  });

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final nameController = TextEditingController();
  final reviewController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview(BuildContext context) async {
    final reviewProvider = context.read<ReviewProvider>();
    final detailProvider = context.read<RestaurantDetailProvider>();
    final messenger = ScaffoldMessenger.of(context);

    try {
      await reviewProvider.postReview(
        id: widget.restaurantId, // FIXED
        name: nameController.text,
        review: reviewController.text,
      );

      if (!mounted) return;

      detailProvider.fetchDetail();

      messenger.showSnackBar(
        const SnackBar(
          content: Text("Review berhasil ditambahkan"),
        ),
      );

      nameController.clear();
      reviewController.clear();
    } catch (e) {
      if (!mounted) return;

      messenger.showSnackBar(
        const SnackBar(
          content: Text("Gagal mengirim review. Periksa koneksi internet."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReviewProvider(ApiService()),
      child: Consumer<ReviewProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Your Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reviewController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Your Review",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: provider.state == ResultState.loading
                      ? null
                      : () => _submitReview(context),
                  child: provider.state == ResultState.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Submit Review"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}