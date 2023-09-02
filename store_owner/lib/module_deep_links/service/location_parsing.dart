import 'package:c4d/enum/location_parsing_state_enum.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/utils/helpers/link_cleaner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';

WebViewController? webViewController;

class LocationParsing {

  Future<void> tryParsing(BuildContext context, String url,
      {required Function(LatLng) locationCallBack,
        required Function(LocationParsingStateEnum) parsingState,
        required Function() refresh}) async {
    webViewController = WebViewController();
    String finalUrl = url;
    parsingState(LocationParsingStateEnum.startParsing);

    /// checks if url empty .
    if (finalUrl.isEmpty || finalUrl == '') {
      parsingState(LocationParsingStateEnum.urlDoNotContainAData);
      return;
    }

    /// check if url clean
    if (_weNeedToCleanUrl(finalUrl)) {
      finalUrl = Cleaner.clean(finalUrl);
      finalUrl.trim();
    }
    var convertedUrlToUri = Uri.tryParse(finalUrl);
    int waysTried = 0;
    bool weFoundLocationData = false;
    while (waysTried <= 1) {
      if (_checkForAnyLocationData(convertedUrlToUri)) {
        weFoundLocationData = true;
        parsingState(LocationParsingStateEnum.weFoundData);
        break;
      }
      if (waysTried == 1) {
        /// try to match uri with mask .
        parsingState(LocationParsingStateEnum.tryParsingUsingRegXMaskAndFirebaseDynamicLink);
        finalUrl = await DeepLinksService.extractCoordinatesFromUrl(finalUrl);
      }
      waysTried++;
    }
    if (weFoundLocationData) {
      String? queryData;
      if (convertedUrlToUri.toString().contains('geo:')) {
        queryData = convertedUrlToUri?.path;
      } else {
        queryData = convertedUrlToUri?.queryParameters['q'];
        if (queryData?.startsWith('@') == true) {
          queryData = queryData?.substring(1);
        }
      }
      locationCallBack(LatLng(
        double.parse(queryData!.split(',')[0]),
        double.parse(queryData.split(',')[1]),
      ));
      return;
    }
    /// we will start
    parsingState(LocationParsingStateEnum.startUsingWebViewToRetrieveLocationData);
    webViewController!
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            print('finished ---------------------------> $url');
            var locationData = await DeepLinksService
                .getCustomerLocationFromRedirectedUrlAsync(url);
            if (locationData != null && weFoundLocationData == false) {
              locationCallBack(locationData);
              weFoundLocationData = true;
              parsingState(LocationParsingStateEnum.webViewFinishedParsing);
              refresh();
            }
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(finalUrl));
  }

  bool _weNeedToCleanUrl(String url) {
    return url.contains(' ') || url.contains('\n');
  }

  bool _checkForAnyLocationData(Uri? uri) {
    try {
      String? queryData;
      if (uri.toString().contains('geo:')) {
        return true;
      }
      queryData = uri?.queryParameters['q'];
      if (queryData == null) {
        return false;
      }
      if (queryData.startsWith('@')) {
        queryData = queryData.substring(1);
      }
      return
          double.tryParse(queryData.split(',')[0].toString()) !=
              null && double.tryParse(queryData.split(',')[1].toString()) != null;
    } catch (e) {
      /// then q not contains double values .
    }
    return false;
  }
}
