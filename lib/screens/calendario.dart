import 'package:flutter/material.dart';
import 'package:app_3/theme/app_theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:lottie/lottie.dart';

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({Key? key}) : super(key: key);

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'eventos');
            },
          )
        ],
        title: Text('Eventos deportivos'),
        backgroundColor: AppTheme.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              height: 150,
              color: Colors.white,
              child: Row(
                children: [
                  Lottie.asset('assets/calendar.json', height: 200),
                  SizedBox(width: 10),
                  const Center(
                      child:
                          Text("Calendario del Patinaje: \nModalidad Velocidad",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Arial",
                                fontSize: 20,
                              ))),
                ],
              )),
          SfCalendar(
            view: CalendarView.week,
            firstDayOfWeek: 1,
            //initialDisplayDate: DateTime.now(),
            //initialSelectedDate: DateTime(2022, 09, 20, 16, 00),
            dataSource: EventDataSource(getAppointments()),
          ),
        ],
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 16, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: "Gimnasio",
      color: Colors.blue,
      recurrenceRule: 'FREQ=DAILY;COUNT=10'));

  meetings.add(Appointment(
      startTime: DateTime(2022, 09, 19, 18, 0, 0),
      endTime: DateTime(2022, 09, 19, 20, 0, 0),
      subject: "Patines",
      color: Colors.green,
      recurrenceRule: 'FREQ=DAILY;COUNT=10'));

  return meetings;
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> source) {
    appointments = source;
  }
}
