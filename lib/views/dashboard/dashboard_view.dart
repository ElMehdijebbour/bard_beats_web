import 'package:bardbeatsdash/core/middlewares/middleware.dart';
import 'package:bardbeatsdash/core/models/songs_model.dart';
import 'package:bardbeatsdash/features/auth/providers/authentication_provider.dart';
import 'package:bardbeatsdash/features/music/providers/songs_provider.dart';
import 'package:bardbeatsdash/generated/assets.dart';
import 'package:bardbeatsdash/router/routes.dart';
import 'package:bardbeatsdash/views/dashboard/widgets/top_songs.widget.dart';
import 'package:bardbeatsdash/views/home/widgets/menu.widget.dart';
import 'package:bardbeatsdash/views/home/widgets/music_card.widget.dart';
import 'package:bardbeatsdash/views/home/widgets/search_bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
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
      backgroundColor: const Color(0xFF1D2123),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100.0,horizontal: 10.0),
              child: Container(
                width: 50.w,
                height: 40.h  ,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2123),
                  borderRadius: BorderRadius.circular(15), // Circular borders of 15
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage(Assets.imagesBardSplash1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  // Widget buildSongList(List<Song> songs) {
  //   return ListView.builder(
  //     controller: _scrollController,
  //     itemCount: songs.length + 1,
  //     itemBuilder: (context, index) {
  //
  //       if (index == 0) {
  //         return const SearchBarApp();
  //       } else if (index < songs.length-1) {
  //         return MusicCard( song: songs[index],);
  //       }
  //       else {
  //         return const Center(child: Text("Loading more"));
  //       }
  //     },
  //   );
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
