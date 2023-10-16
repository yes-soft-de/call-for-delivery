enum LocationParsingStateEnum {
  startParsing,
  urlDoNotContainAData,
  weFoundData,
  tryParsingUsingRegXMaskAndFirebaseDynamicLink,
  startUsingWebViewToRetrieveLocationData,
  webViewFinishedParsing,
}
