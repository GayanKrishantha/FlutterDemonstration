import 'package:flutterdemonstration/controllers/schedulesummary.dart';
import 'package:flutterdemonstration/providers/scheduleprovider.dart';
import 'package:flutterdemonstration/controllers/schedule.dart';
import 'package:flutterdemonstration/helpers/extentions.dart';
import 'package:flutterdemonstration/helpers/constants.dart';
import 'package:flutterdemonstration/widget/progress.dart';
import 'package:flutterdemonstration/helpers/utils.dart';
import 'package:flutter/material.dart';

class ScheduleTabScreen extends StatefulWidget {
  const ScheduleTabScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleTabScreen> createState() => _ScheduleTabScreenStatus();
}

class _ScheduleTabScreenStatus extends State<ScheduleTabScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final ScheduleProvider _provider = ScheduleProvider();
  late Map<String, List<MainScheduler>> array;

  @override
  initState() {
    super.initState();
    _provider.value = _provider.retrieveValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#E6E6E6"),
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
              return IndexedStack(
                index: _selectedIndex,
                children: [
                  ScheduleScreen(mainSchedules: _provider.mainSchedules),
                  ScheduleSummary(
                      medicines:
                          Utils.filterByDateRange(_provider.mainSchedules))
                ],
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: 'Summary',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors().accent,
        onTap: _onItemTapped,
      ),
    );
  }

  bool get wantKeepAlive => true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
