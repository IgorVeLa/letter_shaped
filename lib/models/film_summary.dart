// Class representing the entire search response from OMDB

class FilmSummary {
  final String title;
  final String year;
  final String type;
  String poster;

  FilmSummary({
    required this.title,
    required this.year,
    required this.type,
    required this.poster,
  });

  factory FilmSummary.fromJson(Map<String, dynamic> json) {
    var filmSummary = FilmSummary(
      title: json['Title'] ?? 'Unknown Title',
      year: json['Year'] ?? 'Unknown Year',
      type: json['Type'] ?? 'movie',
      poster: json['Poster'] ?? '',
    );

    if (Uri.tryParse(filmSummary.poster)?.hasAbsolutePath != true) {
      filmSummary.poster = 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';
    }

    return filmSummary;
  }
}
