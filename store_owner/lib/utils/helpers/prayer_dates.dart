import 'dart:developer';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PrayerDate {
  static Future<String?> getWarningMessage() async {
    var response = await getIt<ApiClient>().get(
      'http://www.islamicfinder.us/index.php/api/prayer_times?timezone=Asia/Riyadh&latitude=24.4713203&longitude=39.7576433&method=4',
    );
    if (response != null) {
      List<String> prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
      var data = response['results'];
      for (var element in prayers) {
        int hour = int.tryParse(
                data[element].toString().split(' ')[0].split(':')[0]) ??
            0;
        int min = int.tryParse(
                data[element].toString().split(' ')[0].split(':')[1]) ??
            0;
        int extra = data[element].toString().contains('%am%') ? 0 : 12;
        if (data[element].toString().contains('%pm%') && hour == 12) {
          extra = 0;
        }
        if (data[element].toString().contains('%am%') && hour == 12) {
          extra = 12;
        }
        var time = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, hour + extra, min);
        log(time.difference(DateTime.now()).inMinutes.abs().toString());

        if (time.difference(DateTime.now()).inMinutes.abs() <= 15) {
          return PrayerHelper.getMessage(element);
        }
      }
    }
    return null;
  }
}

class PrayerHelper {
  static String getMessage(String status) {
    if (status == 'Fajr') {
      return S.current.fajrMessage;
    } else if (status == 'Dhuhr') {
      return S.current.dhahrMessage;
    } else if (status == 'Asr') {
      return S.current.asrMessage;
    } else if (status == 'Maghrib') {
      return S.current.maghribMessage;
    } else if (status == 'Isha') {
      return S.current.ishaMessage;
    }
    return '';
  }
}
