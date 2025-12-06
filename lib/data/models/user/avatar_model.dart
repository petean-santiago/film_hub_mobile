import 'package:film_hub/data/models/user/tmbd_avatar_model.dart';

import 'gravatar_model.dart';

class AvatarModel {
  final GravatarModel gravatar;
  final TmdbAvatarModel tmdb;

  AvatarModel({required this.gravatar, required this.tmdb});

  factory AvatarModel.fromJson(Map<String, dynamic> json) {
    return AvatarModel(
      gravatar: GravatarModel.fromJson(json['gravatar']),
      tmdb: TmdbAvatarModel.fromJson(json['tmdb']),
    );
  }
}
