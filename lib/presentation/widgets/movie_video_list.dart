import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../application/providers/shared/movie_detail_provider.dart';

class MovieVideoListWidget extends ConsumerWidget {
  final int id;

  const MovieVideoListWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieVideosAsyncValue = ref.watch(movieVideosProvider(id));

    return movieVideosAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(error.toString())),
      data: (videos) {
        final youtubeVideos = videos.results
            .where((video) => video.site.toLowerCase() == "youtube")
            .toList();

        if (youtubeVideos.isEmpty) {
          return const Center(child: Text("No videos available"));
        }

        return SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: youtubeVideos.length,
            itemBuilder: (context, index) {
              final video = youtubeVideos[index];
              final thumbnailUrl =
                  "https://img.youtube.com/vi/${video.key}/hqdefault.jpg";

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          YoutubePlayerFullscreen(videoKey: video.key),
                    ),
                  );
                },
                child: Container(
                  width: 250,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(thumbnailUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class YoutubePlayerFullscreen extends StatefulWidget {
  final String videoKey;

  const YoutubePlayerFullscreen({super.key, required this.videoKey});

  @override
  State<YoutubePlayerFullscreen> createState() =>
      _YoutubePlayerFullscreenState();
}

class _YoutubePlayerFullscreenState extends State<YoutubePlayerFullscreen> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: YoutubePlayer(controller: controller)),
    );
  }
}
