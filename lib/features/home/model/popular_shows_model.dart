// To parse this JSON data, do
//
//     final popularShowsModel = popularShowsModelFromJson(jsonString);

import 'dart:convert';

PopularShowsModel popularShowsModelFromJson(String str) =>
    PopularShowsModel.fromJson(json.decode(str));

String popularShowsModelToJson(PopularShowsModel data) =>
    json.encode(data.toJson());

class PopularShowsModel {
  int? page;
  List<ShowResult>? results;
  int? totalPages;
  int? totalResults;

  PopularShowsModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory PopularShowsModel.fromJson(Map<String, dynamic> json) =>
      PopularShowsModel(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<ShowResult>.from(
                json["results"]!.map((x) => ShowResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class ShowResult {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  List<String>? originCountry;
  String? originalLanguage;
  String? title;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  ShowResult({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.title,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.name,
    this.voteAverage,
    this.voteCount,
  });

  factory ShowResult.fromJson(Map<String, dynamic> json) => ShowResult(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"],
        title: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        name: json["name"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": title,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
