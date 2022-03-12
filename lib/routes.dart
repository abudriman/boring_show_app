import 'package:get/route_manager.dart';
import './home_screen.dart';
import 'package:boring_show_app/app_zero/routes.dart';
import 'package:boring_show_app/sliver_list/routes.dart';
import 'package:boring_show_app/hacker_news/routes.dart';
import './tic_tac/routes.dart';

var routes = [
  GetPage(name: '/', page: () => const HomeScreen()),
  ...appZeroRoutes,
  ...sliverListRoutes,
  ...appThreeRoutes,
  ...ticTacRoutes,
];

List<Map> routeMap = [
  {
    'route': '/app_zero',
    'text': 'Quick Pokedex',
  },
  {
    'route': '/sliver_list',
    'text': 'Sliver List',
  },
  {
    'route': '/app_three',
    'text': 'HackerNews Reader',
  },
  {
    'route': '/tic_tac',
    'text': 'Unbeatable Tic Tac Toe',
  },
];
