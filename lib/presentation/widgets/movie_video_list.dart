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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          height: screenHeight * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: youtubeVideos.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final video = youtubeVideos[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: YoutubeVideoItem(
                  videoKey: video.key,
                  width: screenWidth * 0.6,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class YoutubeVideoItem extends StatefulWidget {
  final String videoKey;
  final double width;

  const YoutubeVideoItem({
    super.key,
    required this.videoKey,
    required this.width,
  });

  @override
  State<YoutubeVideoItem> createState() => _YoutubeVideoItemState();
}

class _YoutubeVideoItemState extends State<YoutubeVideoItem>
    with AutomaticKeepAliveClientMixin {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: widget.width,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
