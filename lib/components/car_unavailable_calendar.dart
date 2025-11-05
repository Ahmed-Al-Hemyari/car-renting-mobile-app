import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CarUnavailableCalendar extends StatefulWidget {
  final List<String> unavailableDates;

  const CarUnavailableCalendar({Key? key, required this.unavailableDates})
    : super(key: key);

  @override
  State<CarUnavailableCalendar> createState() => _CarUnavailableCalendarState();
}

class _CarUnavailableCalendarState extends State<CarUnavailableCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late final Set<DateTime> _unavailableDays;

  @override
  void initState() {
    super.initState();

    // Parse unavailable dates safely
    _unavailableDays = widget.unavailableDates.map((d) {
      final dt = DateTime.parse(d);
      return DateTime(dt.year, dt.month, dt.day); // strip time
    }).toSet();
  }

  bool _isUnavailable(DateTime day) {
    final date = DateTime(day.year, day.month, day.day);
    return _unavailableDays.contains(date);
  }

  Widget _buildUnavailableDay(DateTime day) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.red.shade400.withOpacity(0.95),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildToday(DateTime day) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedDay(DateTime day) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.green.shade400,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          if (_isUnavailable(selectedDay)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('This date is unavailable'),
                duration: Duration(seconds: 1),
              ),
            );
          } else {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            if (_isUnavailable(day)) return _buildUnavailableDay(day);
            return null;
          },
          todayBuilder: (context, day, focusedDay) {
            if (_isUnavailable(day)) return _buildUnavailableDay(day);
            return _buildToday(day);
          },
          selectedBuilder: (context, day, focusedDay) {
            if (_isUnavailable(day)) return _buildUnavailableDay(day);
            return _buildSelectedDay(day);
          },
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }
}
