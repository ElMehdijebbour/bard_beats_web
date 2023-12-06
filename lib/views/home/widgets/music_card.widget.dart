import 'dart:math';

import 'package:bardbeatsdash/features/auth/providers/authentication_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bardbeatsdash/core/models/songs_model.dart'; // Update with actual path
import 'package:bardbeatsdash/core/providers/firebase_providers.dart'; // Update with actual path
import 'package:bardbeatsdash/features/auth/providers/state/authentication_state.dart'; // Update with actual path
import 'package:bardbeatsdash/generated/assets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final songFavoriteProvider =
    FutureProvider.family<bool, String>((ref, songId) async {
  final authNotifier = ref.watch(authNotifierProvider.notifier);
  if (authNotifier.isAuthenticated) {
    final FirebaseFirestore firestore = ref.watch(firebaseFirestoreProvider);
    final String userId = authNotifier.userId;
    if (userId.isNotEmpty) {
      final DocumentSnapshot snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('playlist')
          .doc(songId)
          .get();
      return snapshot.exists;
    }
  }
  return false;
});

class MusicCard extends ConsumerWidget {
  final Song song;
  final int imageIndex;
  const MusicCard({Key? key, required this.song,required this.imageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final authState = ref.watch(authNotifierProvider);
    final FirebaseFirestore firestore = ref.watch(firebaseFirestoreProvider);
    final isFavoritedAsyncValue = ref.watch(songFavoriteProvider(song.id));


    return Container(
      width: MediaQuery.of(context).size.width * 0.8, // 80% width of the page
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0x5E33373B), // Set the background color of the card
        borderRadius: BorderRadius.circular(10), // Rounded corners for the card
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Image and Favorite Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15), // Circular borders of 15
              image: DecorationImage(
                image: AssetImage("assets/icons_music/${imageIndex}.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 40.0),
          GestureDetector(
            onTap: () async {
              final authNotifier = ref.read(authNotifierProvider.notifier);
              if (authNotifier.isAuthenticated && authNotifier.userId.isNotEmpty) {
                final String userId = authNotifier.userId;
                final isFavorited = ref.read(songFavoriteProvider(song.id)).asData?.value ?? false;

                bool success;
                if (isFavorited) {
                  success = await removeFromPlaylist(ref.read(firebaseFirestoreProvider), userId, song.id);
                } else {
                  success = await addToPlaylist(ref.read(firebaseFirestoreProvider), userId, song.id);
                }

                if (success) {
                  // Refresh the songFavoriteProvider for the current song
                  ref.refresh(songFavoriteProvider(song.id));
                }
              } else {
                // Handle unauthenticated user scenario
              }
            },
            child: isFavoritedAsyncValue.when(
              data: (isFavorited) => Icon(
                isFavorited
                    ? FontAwesomeIcons.heartCircleMinus
                    : FontAwesomeIcons.heartCirclePlus,
                color: isFavorited
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).secondaryHeaderColor,
              ),
              loading: () =>
                  const SizedBox(height: 30.0,width: 30.0,child: CircularProgressIndicator()),
              error: (_, __) => Icon(FontAwesomeIcons.heartCirclePlus,
                  color: Theme.of(context).secondaryHeaderColor),
            ),
          ),

          const SizedBox(width: 20.0),
          // Song Title and Artist Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  song.title,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  song.artistName,
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          // Year and More Options Icon
          Text(
            song.year.toString(),
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(width: 20.0),
          const Icon(
            Icons.more_vert,
            color: Colors.white, // Adjust as needed
          ),
        ],
      ),
    );
  }
  Future<bool> addToPlaylist(
      FirebaseFirestore firestore, String userId, String songId) async {
    final CollectionReference playlistRef =
    firestore.collection('users').doc(userId).collection('playlist');

    try {
      await playlistRef.doc(songId).set({'count': 1}); // Setting count as 1 for the song
      print("Song added to playlist");
      return true;
    } catch (error) {
      print("Failed to add song: $error");
      return false;
    }
  }

  Future<bool> removeFromPlaylist(
      FirebaseFirestore firestore, String userId, String songId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('playlist')
          .doc(songId)
          .delete();
      print("Song removed from playlist");
      return true;
    } catch (error) {
      print("Failed to remove song: $error");
      return false;
    }
  }

}
