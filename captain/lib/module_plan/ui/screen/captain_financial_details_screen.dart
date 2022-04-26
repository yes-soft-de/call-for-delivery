import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainFinancialDuesDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      CaptainFinancialDuesDetailsScreenState();
}

class CaptainFinancialDuesDetailsScreenState
    extends State<CaptainFinancialDuesDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
