// Widget for searched films

import 'package:flutter/material.dart';
import 'package:letter_shaped/pages/film_detail_page.dart';
import 'package:provider/provider.dart';

import 'package:letter_shaped/main.dart';
import 'package:letter_shaped/models/films_search.dart';

class FilmCard extends StatelessWidget {
  const FilmCard({required this.filmsSearch});

  final FilmsSearch filmsSearch;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    
    if (filmsSearch.response == 'False') {
      return Text('No films found.');
    }

    return SingleChildScrollView(
      child: Container(
        height: 500,
        child: ListView.builder(
          itemCount: filmsSearch.films.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  var film = await appState.fetchFilmByTitle(appState.client, filmsSearch.films[index].title);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilmDetailPage(film: film)),
                  );
                },

                child: ListTile(
                  leading: ClipRRect(
                    child: Image.network(filmsSearch.films[index].poster),
                  ),
                
                  title: Text(
                    filmsSearch.films[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text('${filmsSearch.films[index].year} ${filmsSearch.films[index].type}'),
                  
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}