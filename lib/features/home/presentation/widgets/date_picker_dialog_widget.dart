import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';

class DatePickerDialogWidget extends StatefulWidget {
  const DatePickerDialogWidget({super.key});

  @override
  State<DatePickerDialogWidget> createState() => _DatePickerDialogWidgetState();
}

class _DatePickerDialogWidgetState extends State<DatePickerDialogWidget> {
  List<DateTime?> _selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: AppConstants.padding16, // margin around the dialog
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.95, // wider
          maxHeight: 500,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: AppConstants.spacing16,
            ),
            Text(
              'Select Due Date',
              style: context.textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                firstDate: DateTime.now(),
                lastDate: DateTime(2050),
                selectedDayHighlightColor: AppColors.primaryPurple,
                selectedDayTextStyle: const TextStyle(color: AppColors.white),
                daySplashColor: AppColors.transparent,
              ),
              value: _selectedDates,
              onValueChanged: (dates) {
                setState(() {
                  _selectedDates = dates;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (_selectedDates.isEmpty) {
                      _selectedDates = [DateTime.now()];
                    }
                    Navigator.of(context).pop(_selectedDates);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
