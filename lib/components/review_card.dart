import 'package:car_renting/classes/rate_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewCard extends StatelessWidget {
  final Rate rate;

  const ReviewCard({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 User Image
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: _buildUserImage(),
            ),

            const SizedBox(width: 12),

            // 📄 User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rate.userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rate.comment,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Tajawal',
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // ⭐ Rating
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.amber[700], size: 18),
                const SizedBox(width: 4),
                Text(
                  rate.rate.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserImage() {
    final id = rate.userId;

    final image = rate.userImage;

    if (image == null || image.isEmpty) {
      return SvgPicture.asset(
        'assets/images/no-image-user.svg',
        key: ValueKey(id),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    }

    if (image.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        image,
        key: ValueKey(id),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholderBuilder: (context) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Image.network(
      image,
      key: ValueKey(id),
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) => progress == null
          ? child
          : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
        'assets/images/no-image-user.svg',
        key: ValueKey(id),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }
}
