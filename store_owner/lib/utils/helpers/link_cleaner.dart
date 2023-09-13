class Cleaner {
  static String clean(String clean) {
    var str = clean;
    List<String> s = str.split(' ');
    for (var element in s) {
      if (element.contains('http') || element.contains('geo')) {
        str = element;
      }
    }
    List<String> ss = str.split('\n');
    for (var element in ss) {
      if (element.contains('http') || element.contains('geo')) {
        str = element;
      }
    }
    return str;
  }
}
