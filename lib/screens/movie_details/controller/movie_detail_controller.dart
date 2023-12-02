import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mock_machine_test/screens/movie_details/model/movie_detail_model.dart';

import '../../../core/api_consts/api_links.dart';

class MovieDetailController extends ChangeNotifier {
  final Dio dio = Dio();
  Map<String, dynamic> headers = {
    "accept": 'application/json',
    "Authorization": 'Bearer $apiTocken'
  };
  Future<MoviesDetailsModel?> getMoviesDetails(int intId) async {
    try {
      String id = intId.toString();
      Response response;
      String queryURL = movieDetails + id;
      response = await dio.get(
        queryURL,
        options: Options(headers: headers),
      );
      MoviesDetailsModel details = MoviesDetailsModel.fromJson(response.data);
      return details;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
