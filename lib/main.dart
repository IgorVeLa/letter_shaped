// App initialisation and UI for home page

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:letter_shaped/models/films_search.dart';
import 'package:letter_shaped/models/film.dart';

import 'package:letter_shaped/pages/home_page.dart';


void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Letter Shaped',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          fontFamily: 'Gilroy'
        ),
        //debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final http.Client client = http.Client();
  late Future<FilmsSearch> filmSearch;

  MyAppState() {
    filmSearch = fetchFilmBySearch(client, '');
  }

  Future<FilmsSearch> fetchFilmBySearch(http.Client client, String filmTitle) async {
    final response = await client
      .get(Uri.parse('https://www.omdbapi.com/?apikey=${dotenv.env["API_KEY"]!}&s=${filmTitle}'));

    if (response.statusCode == 200) {
      print('Server response 200');
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return FilmsSearch.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch film');
    }
  }

  Future<Film> fetchFilmByTitle(http.Client client, String filmTitle) async {
    final response = await client
      .get(Uri.parse('https://www.omdbapi.com/?apikey=${dotenv.env["API_KEY"]!}&t=${filmTitle}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Film.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch film');
    }
  }
}
