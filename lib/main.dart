import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/constants/theme_constants.dart';
import 'package:mock_machine_test/features/home/controller/home_screen_controller.dart';
import 'package:mock_machine_test/features/home/view/home_screen.dart';
import 'package:provider/provider.dart';

import 'features/movie_details/controller/movie_detail_controller.dart';
import 'features/series_details/controller/series_detail_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HomeScreenController(),
    ),
    ChangeNotifierProvider(
      create: (context) => MovieDetailController(),
    ),
    ChangeNotifierProvider(
      create: (context) => SeriesDetailsController(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeConstants.appTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
