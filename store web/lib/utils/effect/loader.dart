import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool loading;
  final Widget child;
  final Widget loadingWidget;

  const Loader(
      {super.key, required this.loading,
      required this.child,
      required this.loadingWidget});

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return loadingWidget;
    } else {
      return child;
    }
  }
}
