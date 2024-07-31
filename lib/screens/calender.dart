import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final String authKey;

  CalendarScreen({required this.authKey});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _selectedDate;
  Map<DateTime, List> _bookedDates = {};

  Future<void> _checkAvailability() async {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date')),
      );
      return;
    }

    final response = await http.get(
      Uri.parse('http://localhost:3000/rooms'), // Use your actual API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${widget.authKey}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> roomData = jsonDecode(response.body);

      bool isAvailable = false;

      for (var room in roomData) {
        if (room['booked'] == 0) {
          isAvailable = true;
          break;
        } else {
          final bookedDatesResponse = await http.get(
            Uri.parse(
                'http://localhost:3000/booked_dates?room_id=${room['id']}'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${widget.authKey}',
            },
          );

          if (bookedDatesResponse.statusCode == 200) {
            final List<dynamic> bookedDatesData =
                jsonDecode(bookedDatesResponse.body);

            _bookedDates.clear();
            for (var date in bookedDatesData) {
              DateTime checkInDate = DateTime.parse(date['check_in_date']);
              DateTime checkOutDate = DateTime.parse(date['check_out_date']);
              for (DateTime d = checkInDate;
                  d.isBefore(checkOutDate) || d.isAtSameMomentAs(checkOutDate);
                  d = d.add(Duration(days: 1))) {
                if (_bookedDates[d] == null) {
                  _bookedDates[d] = ['booked'];
                } else {
                  _bookedDates[d]?.add('booked');
                }
              }
            }
          }
        }
      }

      setState(() {
        // Update the UI
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Room Availability'),
            content: Text(isAvailable ? 'Available' : 'Unavailable'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Failed to load room data: ${response.reasonPhrase}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image covering 60% of the screen with rounded bottom
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                'assets/images/recep.jpg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
          ),
          // Back button
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Content below the image
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.20,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.07,
              ),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Calendar view
                  TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    calendarFormat: CalendarFormat.month,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                      });
                    },
                    eventLoader: (day) {
                      return _bookedDates[day] ?? [];
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Submit button with updated styles
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _checkAvailability,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(24, 54, 65, 1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 10,
                      ),
                      child: const Text('Submit',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
