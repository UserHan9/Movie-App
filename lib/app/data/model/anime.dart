import 'package:hive/hive.dart';

part 'anime.g.dart';

class TopAnimeResponse {
  final List<Anime> data;

  TopAnimeResponse({required this.data});

  factory TopAnimeResponse.fromJson(Map<String, dynamic> json) {
    return TopAnimeResponse(
      data: (json['data'] as List)
          .map((e) => Anime.fromJson(e))
          .toList(),
    );
  }
}

@HiveType(typeId: 0)
class Anime extends HiveObject {
  @HiveField(0)
  final int malId; // ID unik anime

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final int? episodes;

  @HiveField(4)
  final double? score;

  @HiveField(5)
  final int rank;

  @HiveField(6)
  final String imageUrl;

  Anime({
    required this.malId,
    required this.title,
    required this.type,
    this.episodes,
    this.score,
    required this.rank,
    required this.imageUrl,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malId: json['mal_id'], // ⭐ PENTING
      title: json['title']?.toString() ?? 'No Title',
      type: json['type']?.toString() ?? '-',
      episodes: json['episodes'],
      score: (json['score'] as num?)?.toDouble(),
      rank: json['rank'] ?? 0,
      imageUrl:
          json['images']?['jpg']?['image_url']?.toString() ?? '',
    );
  }
}
