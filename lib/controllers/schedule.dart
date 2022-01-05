import 'package:flutterdemonstration/controllers/schedulerwidget.dart';
import 'package:flutterdemonstration/data/model/schedules.dart';
import 'package:flutterdemonstration/helpers/constants.dart';
import 'package:flutterdemonstration/helpers/utils.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ScheduleScreen extends StatefulWidget {
  List<MainScheduler> mainSchedules = [];

  ScheduleScreen({Key? key, required this.mainSchedules}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors().primary,
        appBar: AppBar(
          title: const Text('Scheduler'),
          backgroundColor: AppColors().primary,
          titleTextStyle: AppTheme().appTitle,
        ),
        body: GroupedListView<MainScheduler, String>(
          stickyHeaderBackgroundColor: AppColors().primary,
          elements: widget.mainSchedules,
          groupBy: (element) => element.scheduler.date,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1.scheduler.date.compareTo(item2.scheduler.date),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.pX14, Dimensions.pX24,
                Dimensions.pX14, Dimensions.pX14),
            child: Text(Utils.dateFormatterWithString(value),
                style: AppTheme().titleDate),
          ),
          itemBuilder: (context, element) {
            return SchedulerWidget(item: element);
          },
        ));
  }
}

class MainScheduler {
  bool isExpand;
  Scheduler scheduler;
  MainScheduler(this.isExpand, this.scheduler);
}
