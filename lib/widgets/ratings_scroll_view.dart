// Widget for a scroll view that displays ratings from various sources

import 'package:flutter/material.dart';

import 'package:letter_shaped/models/rating.dart';

class RatingsScrollView extends StatelessWidget {
  const RatingsScrollView({required this.ratings});

  final List<Rating> ratings;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
      
        child: Row(
          children: ratings
              .map(
                (rating) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Text(rating.source),
                      SizedBox(width: 5),
                      Text(rating.value),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      
      );
  }
}