import 'package:get/get.dart';
import './screens/screens.dart';

var animationsAppRoute = [
  GetPage(name: '/animations_app', page: () => const HomeAnimation()),
  GetPage(name: '/implicit', page: () => const Implicit()),
  GetPage(name: '/explicit', page: () => const Explicit()),
  GetPage(name: '/custom_implicit', page: () => const CustomImplicit()),
  GetPage(name: '/custom_explicit', page: () => const CustomExplicit()),
  GetPage(name: '/flip_animation', page: () => const FlipAnimation()),
];
