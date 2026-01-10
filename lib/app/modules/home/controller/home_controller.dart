import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../../data/model/anime.dart';
import '../../../service/api_service.dart';

class HomeController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoading = false.obs;
  var animeList = <Anime>[].obs;

  late Box<Anime> favoriteBox;

  
  var favoriteList = <Anime>[].obs;

  @override
  void onInit() {
    super.onInit();
    favoriteBox = Hive.box<Anime>('favorites');
    favoriteList.assignAll(favoriteBox.values);
    fetchTopAnime();
  }

  Future<void> fetchTopAnime() async {
    try {
      isLoading.value = true;
      final result = await apiService.getTopAnime();
      animeList.assignAll(result.data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  
  bool isFavorite(int malId) {
    return favoriteBox.containsKey(malId);
  }

  void toggleFavorite(Anime anime) {
    if (isFavorite(anime.malId)) {
      favoriteBox.delete(anime.malId);
    } else {
      favoriteBox.put(anime.malId, anime);
    }
    favoriteList.assignAll(favoriteBox.values);
  }
}
