import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutHiveHelper {
  var box = Hive.box('Init');

  void setWelcome() {
    box.put('welcomed', true);
  }

  bool getWelcome() {
    // TODO: there is no need to welcome screen any more delete it (:
    // return box.get('welcomed') ?? false;
    return true;
  }
}
