import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/model/deep_links_model.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

@injectable
class CopyMapLinkScreen extends StatefulWidget {
  @override
  State<CopyMapLinkScreen> createState() => _CopyMapLinkScreenState();
}

class _CopyMapLinkScreenState extends State<CopyMapLinkScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var argument =
          ModalRoute.of(context)?.settings.arguments as DeepLinksModel?;
      Clipboard.setData(ClipboardData(text: argument?.link.toString()));
      Fluttertoast.showToast(msg: S.current.copyFinished);
      SystemNavigator.pop();
      Fluttertoast.showToast(msg: S.current.copyFinished);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var argument =
        ModalRoute.of(context)?.settings.arguments as DeepLinksModel?;
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.locationOfCustomer, canGoBack: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    argument?.link.toString() ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: argument?.link.toString()));
                  },
                  child: Text(S.current.copy)),
              SizedBox(
                width: 16,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(S.current.close)),
            ],
          )
        ],
      ),
    );
  }
}
