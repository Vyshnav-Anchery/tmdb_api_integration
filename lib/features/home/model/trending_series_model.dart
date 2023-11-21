// To parse this JSON data, do
//
//     final trendingSeriesModel = trendingSeriesModelFromJson(jsonString);

import 'dart:convert';

TrendingSeriesModel trendingSeriesModelFromJson(String str) => TrendingSeriesModel.fromJson(json.decode(str));

String trendingSeriesModelToJson(TrendingSeriesModel data) => json.encode(data.toJson());

class TrendingSeriesModel {
    int? page;
    List<TrendingSeriesResult>? results;
    int? totalPages;
    int? totalResults;

    TrendingSeriesModel({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    factory TrendingSeriesModel.fromJson(Map<String, dynamic> json) => TrendingSeriesModel(
        page: json["page"],
        results: json["results"] == null ? [] : List<TrendingSeriesResult>.from(json["results"]!.map((x) => TrendingSeriesResult.fromJson(x))),
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

class TrendingSeriesResult {
    bool? adult;
    String? backdropPath;
    int? id;
    String? name;
    OriginalLanguage? originalLanguage;
    String? originalName;
    String? overview;
    String? posterPath;
    MediaType? mediaType;
    List<int>? genreIds;
    double? popularity;
    DateTime? firstAirDate;
    double? voteAverage;
    int? voteCount;
    List<String>? originCountry;

    TrendingSeriesResult({
        this.adult,
        this.backdropPath,
        this.id,
        this.name,
        this.originalLanguage,
        this.originalName,
        this.overview,
        this.posterPath,
        this.mediaType,
        this.genreIds,
        this.popularity,
        this.firstAirDate,
        this.voteAverage,
        this.voteCount,
        this.originCountry,
    });

    factory TrendingSeriesResult.fromJson(Map<String, dynamic> json) => TrendingSeriesResult(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        originalLanguage: originalLanguageValues.map[json["original_language"]]!,
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaTypeValues.reverse[mediaType],
        "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "first_air_date": "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
    };
}

enum MediaType {
    TV
}

final mediaTypeValues = EnumValues({
    "tv": MediaType.TV
});

enum OriginalLanguage {
    EN,
    HI,
    JA,
    PT
}

final originalLanguageValues = EnumValues({
    "en": OriginalLanguage.EN,
    "hi": OriginalLanguage.HI,
    "ja": OriginalLanguage.JA,
    "pt": OriginalLanguage.PT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
