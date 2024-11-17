// UI for more detailed information on a film

import 'package:flutter/material.dart';

import 'package:letter_shaped/widgets/film_detail_heading_card.dart';
import 'package:letter_shaped/widgets/ratings_scroll_view.dart';

import 'package:letter_shaped/models/film.dart';


class FilmDetailPage extends StatelessWidget {
  const FilmDetailPage({required this.film});

  final Film film;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:() {
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back)),

        title: Text('Film Image'),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilmDetailHeadingCard(film: film),
              SizedBox(height: 12),
              Text(film.plot),
              SizedBox(height: 20),
              Text('Ratings'),
              RatingsScrollView(ratings: film.ratings),
              SizedBox(height: 12),
              //DetailsCard(actors: film.actors, directors: film.director, writers: film.writer, awards: film.awards)
            ],
          ),
        ),
      ),
    );
  }
}