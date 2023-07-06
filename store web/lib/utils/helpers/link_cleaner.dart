class Cleaner {
  static String clean(String clean) {
    var str = clean;
    List<String> s = str.contains(' ')
        ? str.split(' ')
        : (str.contains('\n') ? str.split('\n') : []);
    for (var element in s) {
      if (element.contains('http') || element.contains('geo')) {
        str = element;
      }
    }
    return str;
  }
}
