// TODO: extra details for film detail page 

import 'package:flutter/material.dart';

class ExtraDetailsCard extends StatelessWidget {
  final String actors;
  final String directors;
  final String writers;
  final String awards;

  const ExtraDetailsCard({
    required this.actors,
    required this.directors,
    required this.writers,
    required this.awards,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text('Cast')
          ],
        ),

        Column(
          children: [
            Text('Crew')
          ],
        ),

        Column(
          children: [
            Text('Awards')
          ],
        ),
      ],
    );
  }
}