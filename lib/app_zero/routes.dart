import 'screens/screens.dart';
import 'package:get/get.dart';

var appZeroRoutes = [
  GetPage(name: '/app_zero', page: () => const AppZero()),
  GetPage(name: '/pokemon', page: () => const PokemonScreen()),
];
