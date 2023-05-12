class Movie {
  final String poster;
  final String title;
  final String genre;
  final List<dynamic> director;
  final List<dynamic> stars;
  final int voting;
  final String language;
  final String date;
  final int pageViews;
  final int totalVoted;

  Movie({
    required this.poster,
    required this.title,
    required this.genre,
    required this.director,
    required this.stars,
    required this.voting,
    required this.language,
    required this.date,
    required this.pageViews,
    required this.totalVoted,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      poster: json['poster'],
      title: json['title'],
      genre: json['genre'],
      director: json['director'],
      stars: json['stars'],
      voting: json['voting'],
      language: json['language'],
      date: json['date'],
      pageViews: json['pageViews'],
      totalVoted: json['totalVoted'],
    );
  }
}
