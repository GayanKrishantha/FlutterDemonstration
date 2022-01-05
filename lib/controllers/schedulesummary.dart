import 'package:flutterdemonstration/data/model/medicines.dart';
import 'package:flutterdemonstration/helpers/constants.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ScheduleSummary extends StatelessWidget {
  List<Medicines> medicines = [];

  ScheduleSummary({Key? key, required this.medicines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors().primary,
        appBar: AppBar(
          backgroundColor: AppColors().primary,
          title: const Text('Summary'),
          titleTextStyle: AppTheme().appTitle,
        ),
        body: ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    _setHeaderValue(),
                  ],
                );
              }
              return _listItem(medicines[index]);
            }));
  }

  Widget _listItem(Medicines arg) {
    return Container(
        padding: const EdgeInsets.only(
            left: Dimensions.pX10, right: Dimensions.pX10),
        child: Card(
          child: ListTile(
            title: Text(arg.name, style: AppTheme().titleBlack),
            subtitle: Text(arg.dose, style: AppTheme().subTitleBlack),
          ),
        ));
  }

  Widget _setHeaderValue() {
    return Container(
        padding: const EdgeInsets.only(
            left: Dimensions.pX20,
            right: Dimensions.pX10,
            top: Dimensions.pX16,
            bottom: Dimensions.pX10),
        color: AppColors().primary,
        child: Text(
            'Amount of medicines taken in the week of 7th of January (${medicines.length}).',
            style: AppTheme().appSubTitle));
  }
}
