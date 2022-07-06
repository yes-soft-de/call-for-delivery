import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class TermsOfUse extends StatelessWidget {
  Future<String> getText(String lang) async {
    return await rootBundle.loadString('assets/text/terms.txt');
  }

  @override
  Widget build(BuildContext context) {
    String local = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          S.of(context).termsOfService,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: getText(local),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return Linkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        Fluttertoast.showToast(msg: 'Invalid link');
                      }
                    },
                    text: snapshot.data.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ),
    );
  }
}
