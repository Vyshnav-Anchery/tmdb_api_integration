import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/constants/theme_constants.dart';
import 'package:mock_machine_test/features/home/controller/home_screen_controller.dart';
import 'package:mock_machine_test/features/home/view/home_screen.dart';
import 'package:provider/provider.dart';

import 'features/movie_details/controller/show_detail_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => TrendingShowsController(),
    ),
    ChangeNotifierProvider(
      create: (context) => ShowDetailController(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeConstants.appTheme,
      home: const HomeScreen(),
    );
  }
}
