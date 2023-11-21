// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
    int? page;
    List<Result>? results;
    int? totalPages;
    int? totalResults;

    SearchModel({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        page: json["page"],
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
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

class Result {
    bool? adult;
    String? backdropPath;
    int? id;
    String? name;
    String? originalLanguage;
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
    String? title;
    String? originalTitle;
    DateTime? releaseDate;
    bool? video;
    int? gender;
    String? knownForDepartment;
    dynamic profilePath;
    List<dynamic>? knownFor;

    Result({
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
        this.title,
        this.originalTitle,
        this.releaseDate,
        this.video,
        this.gender,
        this.knownForDepartment,
        this.profilePath,
        this.knownFor,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        originalLanguage: json["original_language"],
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
        title: json["title"],
        originalTitle: json["original_title"],
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        video: json["video"],
        gender: json["gender"],
        knownForDepartment: json["known_for_department"],
        profilePath: json["profile_path"],
        knownFor: json["known_for"] == null ? [] : List<dynamic>.from(json["known_for"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "original_language": originalLanguage,
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
        "title": title,
        "original_title": originalTitle,
        "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "video": video,
        "gender": gender,
        "known_for_department": knownForDepartment,
        "profile_path": profilePath,
        "known_for": knownFor == null ? [] : List<dynamic>.from(knownFor!.map((x) => x)),
    };
}

enum MediaType {
    MOVIE,
    PERSON,
    TV
}

final mediaTypeValues = EnumValues({
    "movie": MediaType.MOVIE,
    "person": MediaType.PERSON,
    "tv": MediaType.TV
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
