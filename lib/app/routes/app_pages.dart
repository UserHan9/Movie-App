import 'package:get/get.dart';
import '../modules/home/binding/home_binding.dart';
import '../modules/home/views/home_views.dart';
import '../modules/home/views/favorite_views.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.FAVORITE,
      page: () => const FavoriteView(),
      )
  ];
}
