import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange? _selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: _selectedDateRange,
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _selectDateRange(context),
          child: Row(
            children: [
              Icon(Icons.arrow_downward),
              SizedBox(width: 8),
              Text(
                _selectedDateRange == null
                    ? 'Select Date Range'
                    : '${_selectedDateRange!.start.toLocal()} - ${_selectedDateRange!.end.toLocal()}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        // You can display the selected date range in any format you prefer
      ],
    );
  }
}
