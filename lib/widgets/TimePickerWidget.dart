import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class DateTimePickerWidget extends StatelessWidget {
  const DateTimePickerWidget(
      {Key? key,
      required this.focusDay,
      required this.format,
      required this.currentDay,
      required this.onFormatChanged,
      required this.onDaySelected,
      this.photodetails})
      : super(key: key);

  final DateTime focusDay;
  final CalendarFormat format;
  final DateTime currentDay;
  final void Function(CalendarFormat format) onFormatChanged;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final photodetails;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2030, 12, 31),
      calendarFormat: format,
      currentDay: currentDay,
      rowHeight: 30,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: GlobalColors.yellow,
          shape: BoxShape.rectangle,
        ),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: onFormatChanged,
      onDaySelected: onDaySelected,
    );
  }
}
