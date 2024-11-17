import 'package:letter_shaped/models/film_summary.dart';

// Class representing the entire search response from OMDB

class FilmsSearch {
  final List<FilmSummary> films;
  final String totalResults;
  final String response;

  FilmsSearch({
    required this.films,
    required this.totalResults,
    required this.response,
  });

  factory FilmsSearch.fromJson(Map<String, dynamic> json) {
    return FilmsSearch(
      films: (json['Search'] as List<dynamic>?)
          ?.map((item) => FilmSummary.fromJson(item as Map<String, dynamic>))
          .toList() 
          ?? [],
      totalResults: json['totalResults'] ?? '0', 
      response: json['Response'] ?? 'False',     
    );
  }
}