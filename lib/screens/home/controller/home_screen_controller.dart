import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/screens/home/model/popular_shows_model.dart';
import 'package:mock_machine_test/screens/home/model/top_movies_model.dart';
import 'package:mock_machine_test/screens/home/model/top_series_model.dart';
import 'package:mock_machine_test/screens/home/model/trending_movies_model.dart';
import 'package:mock_machine_test/screens/home/model/trending_series_model.dart';

import '../model/search_model.dart';

class HomeScreenController extends ChangeNotifier {
  final Dio dio = Dio();
  List searchResults = [];
  ScrollController trendingScrollController = ScrollController();
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> headers = {
    "accept": 'application/json',
    "Authorization": 'Bearer $apiTocken'
  };
  ScrollController? pageNumberScrollController;
  int moviePageNo = 1;
  int seriesPageNo = 1;

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
          queryParameters: {"language": "en-US", "page": moviePageNo});
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
      response = await dio.get(topSeries,
          options: Options(headers: headers),
          queryParameters: {"language": "en-US", "page": seriesPageNo});
      log(response.statusCode.toString());
      TopRatedSeriesModel trending =
          TopRatedSeriesModel.fromJson(response.data);
      return trending;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  changeMoviePage(int newNo) {
    moviePageNo = newNo;
    notifyListeners();
  }

  nextMoviePage(total) {
    if (moviePageNo < total) {
      moviePageNo++;
      notifyListeners();
    }
  }

  prevMoviePage() {
    if (moviePageNo > 1) {
      moviePageNo--;
      notifyListeners();
    }
  }

  changeSeriesPage(int newNo) {
    seriesPageNo = newNo;
    notifyListeners();
  }

  nextSeriesPage(total) {
    if (seriesPageNo < total) {
      seriesPageNo++;
      notifyListeners();
    }
  }

  prevSeriesPage() {
    if (seriesPageNo > 1) {
      seriesPageNo--;
      notifyListeners();
    }
  }

  ScrollController? scrollToCurrentPage(int currPage, double cardWidth) {
    double initialOffset = (currPage - 1) * cardWidth;
    pageNumberScrollController =
        ScrollController(initialScrollOffset: initialOffset);
    return pageNumberScrollController;
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

  Future<SearchModel?> getSearchResult(searchQuery) async {
    searchResults.clear();
    if (searchQuery.toString().isEmpty) {
      log("message");
      return null;
    }
    try {
      final url = '$baseUrl/search/multi?&query=$searchQuery';
      Response response =
          await dio.get(url, options: Options(headers: headers));
      SearchModel result = SearchModel.fromJson(response.data);

      return result;
    } catch (error) {
      return null;
    }
  }
}
