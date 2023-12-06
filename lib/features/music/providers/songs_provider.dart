// songs_provider.dart
import 'package:bardbeatsdash/core/models/songs_model.dart';
import 'package:bardbeatsdash/features/music/state/song_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final songsProvider = StateNotifierProvider<SongsNotifier, SongState>((ref) {
  return SongsNotifier();
});

// songs_provider.dart

class SongsNotifier extends StateNotifier<SongState> {
  final int _songsPerPage = 100;
  DocumentSnapshot? _lastDocument;
  bool hasMoreSongs = true;
  bool _isLoadingMore = false;

  SongsNotifier() : super(const SongState.initial());

  bool get isLoadingMore => _isLoadingMore;

  Future<void> fetchSongs({bool isInitialFetch = false}) async {
    if (_isLoadingMore || (!hasMoreSongs && !isInitialFetch)) {
      return; // Prevents multiple fetches at the same time
    }

    _isLoadingMore = true;
    state = const SongState.loading();

    try {
      // Query query = FirebaseFirestore.instance.collection('songs').limit(_songsPerPage);
      Query query = FirebaseFirestore.instance.collection('songs').limit(_songsPerPage);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        hasMoreSongs = false;
        state = isInitialFetch ? const SongState.loaded([]) : state;
      } else {
        _lastDocument = snapshot.docs.last;
        final newSongs = snapshot.docs.map((doc) => Song.fromFirestore(doc)).toList().cast<Song>();

        List<Song> allSongs;
        if (isInitialFetch ) {
          allSongs = newSongs;
        } else {
          final currentState = state as Loaded;
          allSongs = List<Song>.from(currentState.songs)..addAll(newSongs);
        }

        state = SongState.loaded(allSongs);
      }
    } catch (e) {
      state = SongState.error(e.toString());
    } finally {
      _isLoadingMore = false; // Reset the flag after operation is complete
    }
  }
}



