import 'dart:math';

import 'package:bardbeatsdash/core/middlewares/middleware.dart';
import 'package:bardbeatsdash/core/models/songs_model.dart';
import 'package:bardbeatsdash/features/auth/providers/authentication_provider.dart';
import 'package:bardbeatsdash/features/music/providers/songs_provider.dart';
import 'package:bardbeatsdash/generated/assets.dart';
import 'package:bardbeatsdash/router/routes.dart';
import 'package:bardbeatsdash/views/home/widgets/menu.widget.dart';
import 'package:bardbeatsdash/views/home/widgets/music_card.widget.dart';
import 'package:bardbeatsdash/views/home/widgets/search_bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // Fetch initial songs
    Future.microtask(() =>
        ref.read(songsProvider.notifier).fetchSongs(isInitialFetch: true));
    // Check the authentication state
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   checkAuthentication();
    // });

  }// Define a threshold value for when to start loading more items
  final double _scrollThreshold = 200.0;

  // Future<void> fetchMoreSongs() async {
  //   final songsNotifier = ref.read(songsProvider.notifier);
  //   if (!songsNotifier.isLoadingMore && songsNotifier.hasMoreSongs) {
  //     await songsNotifier.fetchSongs();
  //   }
  // }

  // void checkAuthentication() {
  //   final authState = ref.read(authProvider);
  //   if (!authState.isAuthenticated) {
  //     // Redirect to login page if not authenticated
  //     Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final songState = ref.watch(songsProvider);
    // _scrollController.addListener(() {
    //   // Check if the current scroll position is close to the bottom
    //   if (_scrollController.position.pixels >=
    //       _scrollController.position.maxScrollExtent - _scrollThreshold) {
    //     // Trigger the loading of more items
    //     fetchMoreSongs();
    //   }
    // });
    return Scaffold(
      body: Stack(
        children: <Widget>[

          // Full background image with some opacity
          Opacity(
            opacity: 1, // Adjust the opacity level as needed
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesBardSplash1), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Linear gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC1D2123), // 80% opacity
                  Color(0xFF1D2123), // 100% opacity
                ],
              ),
            ),
          ),
          // ListView to display songs
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 30.0),
            child: Row(
              children: [
                MenuWidget(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 100.0),
                    child: songState.maybeWhen(
                      initial: () => const Center(child: Text("Loading more")),
                      loading: () => const Center(child: Text("Loading more")),
                      loaded: (songs) => buildSongList(songs),
                      error: (message) {
                        debugPrint(
                          message
                        );
                        return Text('Error: $message');
                      },
                      orElse:  () => const Center(child: Text("Loading more")),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSongList(List<Song> songs) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: songs.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SearchBarApp();
        } else if (index < songs.length-1) {
          final Random _random = Random();
          int imageIndex = 1 + _random.nextInt(20);
          return MusicCard( song: songs[index], imageIndex: imageIndex,);
        }
        else {
          return const Center(child: Text("Loading more"));
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
