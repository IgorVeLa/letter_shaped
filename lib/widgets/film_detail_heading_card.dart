// Widget for the heading of film detail page

import 'package:flutter/material.dart';

import 'package:letter_shaped/models/film.dart';

class FilmDetailHeadingCard extends StatelessWidget {
  const FilmDetailHeadingCard({required this.film});

  final Film film;
  
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(film.poster,
            height: 315,
            width: 210,
            fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 40),

          // Film text detail
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),

                child: Container(
                  width: 200,
                  child: Text(film.title,
                  style: TextStyle(
                    fontSize: 14, 
                    fontWeight: FontWeight.bold
                    ).apply(
                    fontSizeFactor: 2, 
                    fontSizeDelta: 0
                    ),
                  ),
                ),
              ),
              
              Text(film.year),
              Text(film.director,
              style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(film.runtime),
            ],
          ),
        ]
      );
  }
}