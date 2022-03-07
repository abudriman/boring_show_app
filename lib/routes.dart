import 'package:get/route_manager.dart';
import './home_screen.dart';
import 'package:boring_show_app/app_zero/routes.dart';

var routes = [
  GetPage(name: '/', page: () => const HomeScreen()),
  ...appZeroRoutes,
];
