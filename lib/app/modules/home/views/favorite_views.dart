import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../../../data/model/anime.dart';

class FavoriteView extends GetView<HomeController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Anime'),
        centerTitle: true,
      ),
      body: Obx(() {
        final favorites = controller.favoriteList;

        if (favorites.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada anime favorit ❤️',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final Anime anime = favorites[index];
            return _favoriteCard(anime);
          },
        );
      }),
    );
  }

  Widget _favoriteCard(Anime anime) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      child: Row(
        children: [
          _image(anime.imageUrl),
          _info(anime),
          _deleteButton(anime),
        ],
      ),
    );
  }

  Widget _image(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 90,
          height: 130,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 60),
        ),
      ),
    );
  }

  Widget _info(Anime anime) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
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
          ],
        ),
      ),
    );
  }

  Widget _deleteButton(Anime anime) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () {
        controller.toggleFavorite(anime);
        Get.snackbar(
          'Favorit',
          'Anime dihapus dari favorit',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}