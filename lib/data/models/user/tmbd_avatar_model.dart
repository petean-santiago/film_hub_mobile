class TmdbAvatarModel {
  final String? avatarPath;

  TmdbAvatarModel({this.avatarPath});

  factory TmdbAvatarModel.fromJson(Map<String, dynamic> json) {
    return TmdbAvatarModel(avatarPath: json["avatar_path"]);
  }

  String? get fullAvatarUrl {
    if (avatarPath == null) return null;
    return "https://image.tmdb.org/t/p/w200$avatarPath";
  }
}
