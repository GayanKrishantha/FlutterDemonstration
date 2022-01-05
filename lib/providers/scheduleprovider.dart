import 'package:flutterdemonstration/data/model/schedules.dart';
import 'package:flutterdemonstration/controllers/schedule.dart';
import 'package:flutterdemonstration/helpers/extentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:core';

class ScheduleProvider {
  List<MainScheduler> mainSchedules = [];
  late Future<Map<String, List<MainScheduler>>> value;
  late Map<String, List<MainScheduler>> schedulers;
  int responseDelayDuration = 3;

  Future<Map<String, List<MainScheduler>>> retrieveValue() async {
    await Future.delayed(Duration(seconds: responseDelayDuration));
    return readJson();
  }

  Future<Map<String, List<MainScheduler>>> readJson() async {
    List<Scheduler> list = [];
    try {
      final String response =
          await rootBundle.loadString('assets/locale/schedules.json');
      final Map<String, dynamic> extractedData = json.decode(response);
      final List<dynamic> data = extractedData['schedules'];
      list = data.map((e) => Scheduler.fromJson(e)).toList();
      schedulers =
          processResponse(list).groupBy((schedule) => schedule.scheduler.date);
      return schedulers;
    } catch (error) {
      debugPrint('$error');
    }
    return schedulers;
  }

  List<MainScheduler> processResponse(List<Scheduler> scheduler) {
    for (Scheduler content in scheduler) {
      mainSchedules.add(MainScheduler(false, content));
    }
    return mainSchedules;
  }
}
