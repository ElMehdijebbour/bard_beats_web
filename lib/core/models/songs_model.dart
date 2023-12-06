import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'songs_model.freezed.dart';
//part 'song.g.dart'; // Required for JSON serialization if you need it

@freezed
class Song with _$Song {
  const factory Song({
    required String id,
    required String artistName,
    required String release,
    required String title,
    required int year,
  }) = _Song;

  factory Song.fromFirestore(DocumentSnapshot doc) => Song(
    id: doc.id,
    artistName: doc.get('artist_name') as String? ?? '',
    release: doc.get('release') as String? ?? '',
    title: doc.get('title') as String? ?? '',
    year: doc.get('year') as int? ?? 0,
  );
}
