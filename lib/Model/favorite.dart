import 'package:hive/hive.dart';
part 'favorite.g.dart';

@HiveType(typeId: 3)
class favorites {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;

  favorites({
    required this.songname,
    required this.artist,
    required this.duration,
    required this.songurl,
    required this.id,
  });
}

String boxname3 = 'favorites';

class favoritesbox {
  static Box<favorites>? _box;
  static Box<favorites> getInstance() {
    return _box ??= Hive.box(boxname3);
  }
}
