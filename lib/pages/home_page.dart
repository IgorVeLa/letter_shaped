// UI for home page

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letter_shaped/main.dart';
import 'package:letter_shaped/models/films_search.dart';
import 'package:letter_shaped/widgets/film_card.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LetterShaped',
          style: TextStyle(fontFamily: 'Gilroy-ExtraBold', fontWeight: FontWeight.bold),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: searchController,
                onChanged: (String value) {
                  searchText = searchController.text;
                },
              ),
            ),

            ElevatedButton(
              onPressed: () => setState(() {
                appState.filmSearch = appState.fetchFilmBySearch(appState.client, searchText);
              }), 
            child: Text('Search'),
            ),
            SizedBox(height: 12),
            FutureBuilder<FilmsSearch>(
              future: appState.filmSearch,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FilmCard(filmsSearch: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // default: loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ), 
    );
  }
}