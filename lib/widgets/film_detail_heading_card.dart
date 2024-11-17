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
                    fontSizeFactor: 1.4, 
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

          Spacer(),
          
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(film.poster,
            height: 210,
            width: 140,
            fit: BoxFit.cover,
            ),
          ),
        ]
      );
  }
}