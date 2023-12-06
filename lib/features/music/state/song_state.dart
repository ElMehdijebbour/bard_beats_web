// song_state.dart
import 'package:bardbeatsdash/core/models/songs_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'song_state.freezed.dart';

@freezed
class SongState with _$SongState {
  const factory SongState.initial() = Initial;
  const factory SongState.loading() = Loading;
  const factory SongState.loaded(List<Song> songs) = Loaded;
  const factory SongState.error(String message) = Error;
}
