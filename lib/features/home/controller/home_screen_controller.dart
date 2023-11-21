import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/features/home/model/top_movies_model.dart';
import 'package:mock_machine_test/features/home/model/top_series_model.dart';
import 'package:mock_machine_test/features/home/model/trending_shows_model.dart';

class TrendingShowsController extends ChangeNotifier {
  final Dio dio = Dio();
  ScrollController trendingScrollController = ScrollController();
  Map<String, dynamic> headers = {
    "accept": 'application/json',
    "Authorization": 'Bearer $apiTocken'
  };

  Future<TrendingModel?> requestAllTrending() async {
    try {
      Response response;
      response = await dio.get(trendingShows,
          options: Options(headers: headers),
          queryParameters: {"language": "en-US"});
      TrendingModel trending = TrendingModel.fromJson(response.data);
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
}
