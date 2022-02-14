import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
@injectable
class AboutHiveHelper {
  var box = Hive.box('Init');
  
  void setWelcome(){
    box.put('welcomed', true);
  }
  bool getWelcome(){
    return box.get('welcomed') ?? false;
  }
}