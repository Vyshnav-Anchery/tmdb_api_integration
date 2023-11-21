import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/features/home/model/popular_shows_model.dart';
import 'package:mock_machine_test/features/home/model/top_movies_model.dart';
import 'package:mock_machine_test/features/home/model/top_series_model.dart';
import 'package:mock_machine_test/features/home/model/trending_movies_model.dart';
import 'package:mock_machine_test/features/home/model/trending_series_model.dart';

import '../model/search_model.dart';

class HomeScreenController extends ChangeNotifier {
  final Dio dio = Dio();
  List<SearchModel?> searchResults = [];
  ScrollController trendingScrollController = ScrollController();
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> headers = {
    "accept": 'application/json',
    "Authorization": 'Bearer $apiTocken'
  };

  Future<TrendingSeriesModel?> requestTrendingSeries() async {
    try {
      Response response;
      response = await dio.get(trendingSeries,
          options: Options(headers: headers),
          queryParameters: {"language": "en-US"});
      TrendingSeriesModel trending =
          TrendingSeriesModel.fromJson(response.data);
      return trending;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<TrendingMoviesModel?> requestTrendingMovies() async {
    try {
      Response response;
      response = await dio.get(trendingMovies,
          options: Options(headers: headers),
          queryParameters: {"language": "en-US"});
      TrendingMoviesModel trending =
          TrendingMoviesModel.fromJson(response.data);
      return trending;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<TopRatedMoviesModel?> requestTopMovies() async {
    try {
      Response response;
      response = await dio.get(topMovies,
          options: Options(headers: headers),
          queryParameters: {"language": "en-US"});
      TopRatedMoviesModel trending =
          TopRatedMoviesModel.fromJson(response.data);
      return trending;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<TopRatedSeriesModel?> requestTopSeries() async {
    try {
      Response response;
      response = await dio.get(
        topSeries,
        options: Options(headers: headers),
      );
      TopRatedSeriesModel trending =
          TopRatedSeriesModel.fromJson(response.data);
      return trending;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<PopularShowsModel?> requestPopularShows() async {
    try {
      Response response;
      response = await dio.get(
        popularShows,
        options: Options(headers: headers),
      );
      PopularShowsModel trending = PopularShowsModel.fromJson(response.data);
      return trending;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<SearchModel?>> getSearchResult(searchQuery) async {
    print("he");
    searchResults.clear();
    if (searchQuery.toString().isEmpty) {
      print("object");
      return [];
    }
    try {
      print("object1");
      final url = '$baseUrl/search/multi?$apiKey&query=$searchQuery';
      Response response =
          await dio.get(url, options: Options(headers: headers));
      print(response.data);
      var data = jsonDecode(response.data);
      // var shows = response.data['results'];
      for (var i in data) {
        searchResults.add(SearchModel.fromJson(i));
      }
      return searchResults;
    } catch (error) {
      return [];
    }
  }
}
