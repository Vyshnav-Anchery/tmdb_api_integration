import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/screens/series_details/model/series_details_model.dart';

class SeriesDetailsController extends ChangeNotifier {
  final Dio dio = Dio();
  Map<String, dynamic> headers = {
    "accept": 'application/json',
    "Authorization": 'Bearer $apiTocken'
  };
  Future<SeriesDetailsModel?> getSeriesDetails(int intId) async {
    try {
      String id = intId.toString();
      Response response;
      String queryURL = seriesDetails + id;
      response = await dio.get(
        queryURL,
        options: Options(headers: headers),
      );
      SeriesDetailsModel details = SeriesDetailsModel.fromJson(response.data);
      return details;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
