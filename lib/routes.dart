import 'package:get/route_manager.dart';
import './home_screen.dart';
import 'package:boring_show_app/app_zero/routes.dart';
import 'package:boring_show_app/sliver_list/routes.dart';
import 'package:boring_show_app/app_three/routes.dart';
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
    'text': 'Episode #0',
  },
  {
    'route': '/sliver_list',
    'text': 'Sliver List',
  },
  {
    'route': '/app_three',
    'text': 'Episode #3',
  },
  {
    'route': '/tic_tac',
    'text': 'Unbeatable Tic Tac Toe',
  },
];
