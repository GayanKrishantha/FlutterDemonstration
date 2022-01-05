import 'package:flutterdemonstration/controllers/schedulerwidget.dart';
import 'package:flutterdemonstration/providers/scheduleprovider.dart';
import 'package:flutterdemonstration/data/model/schedules.dart';
import 'package:flutterdemonstration/helpers/constants.dart';
import 'package:flutterdemonstration/widget/progress.dart';
import 'package:flutterdemonstration/helpers/utils.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final ScheduleProvider _provider = ScheduleProvider();

  @override
  initState() {
    super.initState();
    _provider.value = _provider.retrieveValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors().primary,
        appBar: AppBar(
          title: const Text('Scheduler'),
          backgroundColor: AppColors().primary,
          titleTextStyle: AppTheme().appTitle,
        ),
        body: FutureBuilder<Map<String, List<MainScheduler>>>(
          future: _provider.value,
          builder: (
            BuildContext context,
            AsyncSnapshot<Map<String, List<MainScheduler>>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProgressWidget();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return GroupedListView<MainScheduler, String>(
                  stickyHeaderBackgroundColor: AppColors().primary,
                  elements: _provider.mainSchedules,
                  groupBy: (element) => element.scheduler.date,
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1.scheduler.date.compareTo(item2.scheduler.date),
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Padding(
                    padding: const EdgeInsets.fromLTRB(Dimensions.pX14,
                        Dimensions.pX24, Dimensions.pX14, Dimensions.pX14),
                    child: Text(Utils.dateFormatterWithString(value),
                        style: AppTheme().titleDate),
                  ),
                  itemBuilder: (context, element) {
                    return SchedulerWidget(item: element);
                  },
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ));
  }
}

class MainScheduler {
  bool isExpand;
  Scheduler scheduler;
  MainScheduler(this.isExpand, this.scheduler);
}
