extension NullableStringExtensions on String? {
  bool notNullOrEmpty() {
    if (this != null && (this?.isNotEmpty ?? false)) return true;
    return false;
  }

  bool nullOrEmpty() {
    if (!this.notNullOrEmpty()) return true;
    return false;
  }
}
