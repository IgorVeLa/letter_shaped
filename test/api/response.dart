// Tests relating to the OMDB API

import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:letter_shaped/models/films_search.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'response.mocks.dart';
import 'package:letter_shaped/main.dart';
import 'package:letter_shaped/models/film.dart';

@GenerateMocks([http.Client])
Future<void> main() async {
  await dotenv.load(fileName: ".env");

  var myAppState = MyAppState();

  group('fetchFilms', () {
    test('return a film by title if http call is successful', () async {
      final client = MockClient();

      when(client
              .get(Uri.parse('https://www.omdbapi.com/?apikey=${dotenv.env["API_KEY"]!}&t=past lives')))
          .thenAnswer((_) async => http.Response(
            '{"Title":"Past Lives","Year":"2023","Rated":"PG-13","Released":"23 Jun 2023",'
            '"Runtime":"105 min","Genre":"Drama, Romance","Director":"Celine Song","Writer":"Celine Song",'
            '"Actors":"Greta Lee, Teo Yoo, John Magaro","Plot":"Nora and Hae Sung, two deeply connected'
            'childhood friends, are wrested apart after Nora\'s family emigrates from South Korea. Twenty '
            'years later, they are reunited for one fateful week as they confront notions of love and destiny.",'
            '"Language":"Korean, English, Mandarin, French","Country":"United States, South Korea",'
            '"Awards":"Nominated for 2 Oscars. 80 wins & 227 nominations total",'
            '"Poster":"https://m.media-amazon.com/images/M/MV5BYjQyMTNhNjUtN2VmYy00NWRhLTkwOTctMGVmNTBmNDIxYjZhXkEyXkFqcGc@._V1_SX300.jpg",'
            '"Ratings":[{"Source":"Internet Movie Database","Value":"7.8/10"},{"Source":"Rotten Tomatoes","Value":"95%"},'
            '{"Source":"Metacritic","Value":"94/100"}],"Metascore":"94","imdbRating":"7.8","imdbVotes":"135,047",'
            '"imdbID":"tt13238346","Type":"movie","DVD":"N/A","BoxOffice":"\$11,185,625",'
            '"Production":"N/A","Website":"N/A","Response":"True"}', 200));

      expect(await myAppState.fetchFilmByTitle(client, 'past lives'), isA<Film>());
    });

    test('throws an exception from title call if the http completes with an error', () {
      final client = MockClient();

      when(client
              .get(Uri.parse('https://www.omdbapi.com/?apikey=${dotenv.env["API_KEY"]!}&t=past lives')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(myAppState.fetchFilmByTitle(client, 'past lives'), throwsException);
    });

    test('return a filmsSearch by search if http is succesful', () async {
      final client = MockClient();

      when(client
              .get(Uri.parse('https://www.omdbapi.com/?apikey=${dotenv.env["API_KEY"]!}&s=batman')))
      .thenAnswer((_) async => http.Response(
        '{"Search":[{"Title":"Batman Begins","Year":"2005","imdbID":"tt0372784","Type":"movie",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BODIyMDdhNTgtNDlmOC00MjUxLWE2NDItODA5MTdkNzY3ZTdhXkEyXkFqcGc@._V1_SX300.jpg"},'
        '{"Title":"The Batman","Year":"2022","imdbID":"tt1877830","Type":"movie",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BMmU5NGJlMzAtMGNmOC00YjJjLTgyMzUtNjAyYmE4Njg5YWMyXkEyXkFqcGc@._V1_SX300.jpg"},'
        '{"Title":"Batman v Superman: Dawn of Justice","Year":"2016","imdbID":"tt2975590","Type":"movie",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BZTJkYjdmYjYtOGMyNC00ZGU1LThkY2ItYTc1OTVlMmE2YWY1XkEyXkFqcGc@._V1_SX300.jpg"},'
        '{"Title":"Batman","Year":"1989","imdbID":"tt0096895","Type":"movie",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BYzZmZWViM2EtNzhlMi00NzBlLWE0MWEtZDFjMjk3YjIyNTBhXkEyXkFqcGc@._V1_SX300.jpg"},'
        '{"Title":"Batman Returns","Year":"1992","imdbID":"tt0103776","Type":"movie",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BZTliMDVkYTktZDdlMS00NTAwLWJhNzYtMWIwMDZjN2ViMGFiXkEyXkFqcGc@._V1_SX300.jpg"},'
        '{"Title":"Batman & Robin","Year":"1997","imdbID":"tt0118688","Type":"movie",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BYzU3ZjE3M2UtM2E4Ni00MDI5LTkyZGUtOTFkMGIyYjNjZGU3XkEyXkFqcGc@._V1_SX300.jpg"},'
        '{"Title":"Batman Forever","Year":"1995","imdbID":"tt0112462","Type":"movie",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BMTUyNjJhZWItMTZkNS00NDc4LTllNjUtYTg3NjczMzA5ZTViXkEyXkFqcGc@._V1_SX300.jpg"},'
        '{"Title":"The Lego Batman Movie","Year":"2017","imdbID":"tt4116284","Type":"movie",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BMTcyNTEyOTY0M15BMl5BanBnXkFtZTgwOTAyNzU3MDI@._V1_SX300.jpg"},'
        '{"Title":"Batman: The Animated Series","Year":"1992-1995","imdbID":"tt0103359","Type":"series",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BYjgwZWUzMzUtYTFkNi00MzM0LWFkMWUtMDViMjMxNGIxNDUxXkEyXkFqcGc@._V1_SX300.jpg"},'
        '{"Title":"Batman v Superman: Dawn of Justice (Ultimate Edition)","Year":"2016","imdbID":"tt18689424","Type":"movie",'
        '"Poster":"https://m.media-amazon.com/images/M/MV5BOTRlNWQwM2ItNjkyZC00MGI3LThkYjktZmE5N2FlMzcyNTIyXkEyXkFqcGdeQXVyMTEyNzgwMDUw._V1_SX300.jpg"}],'
        '"totalResults":"583","Response":"True"}', 200));

        expect(myAppState.fetchFilmBySearch(client, 'batman'), isA<Future<FilmsSearch>>());
    });

    test('throw an exception from search call if http is unsuccesful', () async {
      final client = MockClient();

      when(client
              .get(Uri.parse('https://www.omdbapi.com/?apikey=${dotenv.env["API_KEY"]!}&s=batman')))
            .thenAnswer((_) async => http.Response('Not found', 404));

      expect(myAppState.fetchFilmBySearch(client, 'batman'), throwsException);
    });
  });
}