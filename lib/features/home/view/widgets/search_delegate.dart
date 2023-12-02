import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mock_machine_test/features/home/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

import '../../model/search_model.dart';

class CustomSearchDelegate extends SearchDelegate<SearchModel> {
  CustomSearchDelegate();
  Dio dio = Dio();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    HomeScreenController homeScreenController = Provider.of(context);
    return FutureBuilder<SearchModel?>(
      future: homeScreenController.getSearchResult(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.results!.isEmpty) {
          log(query);
          return const Center(
              child: Text(
            "No results found",
            // style: TextStyle(color: Colors.white),
          ));
        } else {
          final suggestionList = snapshot.data!.results!;
          return ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              String title = suggestionList[index].mediaType == MediaType.MOVIE
                  ? suggestionList[index].title!
                  : suggestionList[index].name!;
              return ListTile(
                title: Text(title),
                subtitle: Text(suggestionList[index].mediaType.toString()),
                onTap: () {
                  // Navigator.pop(context);
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
