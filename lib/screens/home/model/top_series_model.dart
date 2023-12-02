// To parse this JSON data, do
//
//     final topRatedSeriesModel = topRatedSeriesModelFromJson(jsonString);

import 'dart:convert';

TopRatedSeriesModel topRatedSeriesModelFromJson(String str) => TopRatedSeriesModel.fromJson(json.decode(str));

String topRatedSeriesModelToJson(TopRatedSeriesModel data) => json.encode(data.toJson());

class TopRatedSeriesModel {
    int? page;
    List<TopSeriesResult>? results;
    int? totalPages;
    int? totalResults;

    TopRatedSeriesModel({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    factory TopRatedSeriesModel.fromJson(Map<String, dynamic> json) => TopRatedSeriesModel(
        page: json["page"],
        results: json["results"] == null ? [] : List<TopSeriesResult>.from(json["results"]!.map((x) => TopSeriesResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class TopSeriesResult {
    bool? adult;
    String? backdropPath;
    List<int>? genreIds;
    int? id;
    List<String>? originCountry;
    String? originalLanguage;
    String? originalName;
    String? overview;
    double? popularity;
    String? posterPath;
    DateTime? firstAirDate;
    String? name;
    double? voteAverage;
    int? voteCount;

    TopSeriesResult({
        this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originCountry,
        this.originalLanguage,
        this.originalName,
        this.overview,
        this.popularity,
        this.posterPath,
        this.firstAirDate,
        this.name,
        this.voteAverage,
        this.voteCount,
    });

    factory TopSeriesResult.fromJson(Map<String, dynamic> json) => TopSeriesResult(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
        name: json["name"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
