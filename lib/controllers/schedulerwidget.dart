import 'package:flutterdemonstration/controllers/schedule.dart';
import 'package:flutterdemonstration/data/model/medicines.dart';
import 'package:flutterdemonstration/data/model/schedules.dart';
import 'package:flutterdemonstration/helpers/constants.dart';
import 'package:flutter/material.dart';

class SchedulerWidget extends StatefulWidget {
  final MainScheduler item;

  const SchedulerWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _SchedulerWidgetState createState() => _SchedulerWidgetState();
}

class _SchedulerWidgetState extends State<SchedulerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors().primary,
      child: Padding(
        padding: const EdgeInsets.only(
            left: Dimensions.pX10, right: Dimensions.pX10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              color: _isMedicineTaken(widget.item.scheduler.medicines)
                  ? AppColors().accent
                  : AppColors().unSelect,
              child: ListTile(
                contentPadding: const EdgeInsets.only(
                    left: Dimensions.pX4, right: Dimensions.pX14),
                onTap: () {
                  setState(() {
                    bool isValid = false;
                    (widget.item.isExpand) ? isValid = false : isValid = true;
                    widget.item.isExpand = isValid;
                  });
                },
                title: _setCellTitleContent(),
                subtitle: _setCellSubTitleContent(),
                trailing: _setCellTrailingImageContent(),
                leading: _setCellLeadingImageContent(),
              ),
            ),
            (widget.item.isExpand)
                ? Column(
                    children: _buildExpandableContent(widget.item.scheduler))
                : Column(
                    children: const <Widget>[],
                  )
          ],
        ),
      ),
    );
  }

  _buildExpandableContent(Scheduler medicines) {
    List<Widget> columnContent = [];
    for (Medicines content in medicines.medicines) {
      columnContent.add(_setExpandableContent(content));
    }
    return columnContent;
  }

  Widget _setCellTitleContent() {
    return Text(
      '${widget.item.scheduler.title} (${widget.item.scheduler.medicines.length} medicine)',
      style: _isMedicineTaken(widget.item.scheduler.medicines)
          ? AppTheme().titleWhite
          : AppTheme().titleBlack,
    );
  }

  bool _isMedicineTaken(List<Medicines> medicines) {
    bool isTaken = false;
    for (Medicines medicine in medicines) {
      (medicine.isTaken) ? isTaken = true : isTaken = false;
    }
    return isTaken;
  }

  Widget _setCellSubTitleContent() {
    return Text(
      widget.item.scheduler.title,
      style: _isMedicineTaken(widget.item.scheduler.medicines)
          ? AppTheme().subTitleWhite
          : AppTheme().subTitleBlack,
    );
  }

  Widget _setCellTrailingImageContent() {
    return _isMedicineTaken(widget.item.scheduler.medicines)
        ? Image.asset(CheckBoxTypes.displayText(2),
            height: Dimensions.pX20, width: Dimensions.pX20, fit: BoxFit.fill)
        : Image.asset(CheckBoxTypes.displayText(1),
            height: Dimensions.pX20, width: Dimensions.pX20, fit: BoxFit.fill);
  }

  Widget _setCellLeadingImageContent() {
    return Container(
      padding: const EdgeInsets.only(
          left: Dimensions.pX10, top: Dimensions.pX10, bottom: Dimensions.pX10),
      child: Image.asset(IconTypes.displayText(widget.item.scheduler.icon),
          fit: BoxFit.fill),
    );
  }
}

Widget _setExpandableContent(Medicines medicines) {
  return Card(
    child: ListTile(
        title: Text(
          medicines.name,
          style: AppTheme().titleBlack,
        ),
        subtitle: Text(
          medicines.dose,
          style: AppTheme().subTitleBlack,
        ),
        trailing: medicines.isTaken
            ? Image.asset(CheckBoxTypes.displayText(3),
                height: Dimensions.pX20,
                width: Dimensions.pX20,
                fit: BoxFit.fill)
            : Image.asset(CheckBoxTypes.displayText(1),
                height: Dimensions.pX20,
                width: Dimensions.pX20,
                fit: BoxFit.fill)),
  );
}
