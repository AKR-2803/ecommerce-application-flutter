// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_major_project/models/user.dart';

class Review {
  final User user;
  final String reviewString;
  final int reviewedAt;
  final List<String>? reviewImages;
  Review({
    required this.user,
    required this.reviewString,
    required this.reviewedAt,
    this.reviewImages,
  });
}
