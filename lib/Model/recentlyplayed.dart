
import 'package:hive_flutter/adapters.dart';
part 'recentlyplayed.g.dart';

@HiveType(typeId: 2)
class RecentlyPlayed {
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
  @HiveField(5)
  int? index;

  RecentlyPlayed(
      {this.songname,
      this.artist,
      this.duration,
      this.songurl,
      required this.id,
      required this.index});
}
String boxnameRecently = 'RecentlyPlayed';

class RecentlyPlayedBox {
  static Box<RecentlyPlayed>? _box;
  static Box<RecentlyPlayed> getInstance(){
    return _box ??= Hive.box(boxnameRecently);
  }
}
