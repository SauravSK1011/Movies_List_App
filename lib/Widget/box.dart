import 'package:hive/hive.dart';
import 'package:movies_list_app/Model/movies.dart';


class Boxes{
  
static Box<movies>getmovie()=>Hive.box<movies>('movies');
}