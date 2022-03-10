import 'package:hive/hive.dart';
part 'movies.g.dart';
@HiveType(typeId: 0)
class movies extends HiveObject{

  @HiveField(0)
  late String moviename;

  @HiveField(1)
  late String director;

  @HiveField(2)
  late String image;
}
