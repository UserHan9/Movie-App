import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../data/model/anime.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Top Anime'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            Get.toNamed(Routes.FAVORITE);
          },
        ),
      ],
    );
  }

  
  Widget _buildBody() {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildLoading();
      }

      if (controller.animeList.isEmpty) {
        return _buildEmpty();
      }

      return _buildAnimeList();
    });
  }

  
  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  
  Widget _buildEmpty() {
    return const Center(
      child: Text('Data tidak tersedia'),
    );
  }

  
  Widget _buildAnimeList() {
    return ListView.builder(
      itemCount: controller.animeList.length,
      itemBuilder: (context, index) {
        final Anime anime = controller.animeList[index];
        return _buildAnimeCard(anime);
      },
    );
  }

  
  Widget _buildAnimeCard(Anime anime) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimeImage(anime.imageUrl),
          _buildAnimeInfo(anime),
          _buildFavoriteButton(anime),
        ],
      ),
    );
  }

  
  Widget _buildAnimeImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                width: 100,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 60),
              )
            : const Icon(
                Icons.image_not_supported,
                size: 60,
              ),
      ),
    );
  }

  
  Widget _buildAnimeInfo(Anime anime) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              anime.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text('Type: ${anime.type}'),
            Text('Episodes: ${anime.episodes ?? '-'}'),
            Text('Score: ${anime.score ?? '-'}'),
            Text('Rank: #${anime.rank}'),
          ],
        ),
      ),
    );
  }

  
  Widget _buildFavoriteButton(Anime anime) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final bool isFavorite = controller.isFavorite(anime.malId);

        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            controller.toggleFavorite(anime);

            Get.snackbar(
              'Favorit',
              isFavorite
                  ? 'Dihapus dari favorit'
                  : 'Ditambahkan ke favorit',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 1),
            );
          },
        );
      },
    );
  }
}
