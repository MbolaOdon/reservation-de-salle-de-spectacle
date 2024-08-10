import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePicker extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Color primaryColor;
  final Color accentColor;
  final void Function(DateTimeRange) onDateRangeChanged;

  DateRangePicker({
    required this.initialStartDate,
    required this.initialEndDate,
    required this.primaryColor,
    required this.accentColor,
    required this.onDateRangeChanged,
  });

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: _DatePicker(
                initialDate: _startDate,
                label: 'Start Date',
                primaryColor: widget.primaryColor,
                accentColor: widget.accentColor,
                onDateChanged: (date) {
                  setState(() {
                    _startDate = date;
                    widget.onDateRangeChanged(
                      DateTimeRange(start: _startDate!, end: _endDate!),
                    );
                  });
                },
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: _DatePicker(
                initialDate: _endDate,
                label: 'End Date',
                primaryColor: widget.primaryColor,
                accentColor: widget.accentColor,
                onDateChanged: (date) {
                  setState(() {
                    _endDate = date;
                    widget.onDateRangeChanged(
                      DateTimeRange(start: _startDate!, end: _endDate!),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final String label;
  final Color primaryColor;
  final Color accentColor;
  final void Function(DateTime) onDateChanged;

  _DatePicker({
    required this.initialDate,
    required this.label,
    required this.primaryColor,
    required this.accentColor,
    required this.onDateChanged,
  });

  @override
  __DatePickerState createState() => __DatePickerState();
}

class __DatePickerState extends State<_DatePicker> {
  DateTime? _date;

  @override
  void initState() {
    super.initState();
    _date = widget.initialDate;
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.primaryColor,
              onPrimary: Colors.white,
              onSurface: widget.accentColor,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
        widget.onDateChanged(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16.0,
              ),
            ),
            if (_date != null)
              Text(
                DateFormat('yyyy-MM-dd').format(_date!),
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}