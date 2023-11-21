import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/constants/theme_constants.dart';
import 'package:mock_machine_test/features/home/view/widgets/top_movies_listview.dart';

import 'widgets/carousel_movies.dart';
import 'widgets/top_series_listview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: SizedBox(
                  height: 20,
                  child: Image.asset(
                    "assets/logo/equal.png",
                    width: MediaQuery.sizeOf(context).height / 10,
                  ),
                ));
          },
        ),
        title: Image.asset(
          "assets/logo/netflix_logo.png",
          width: MediaQuery.sizeOf(context).height / 10,
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MovieCarousel(),
              const SizedBox(height: 50),
              Text(
                "Top Rated Movies",
                style: ThemeConstants.homeSubCategories,
              ),
              const SizedBox(height: 20),
              const TopMoviesListview(),
              const SizedBox(height: 50),
              Text(
                "Top Rated Series",
                style: ThemeConstants.homeSubCategories,
              ),
              const SizedBox(height: 20),
              const TopSeriesListview(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
