import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController checkInDateController = TextEditingController();
  final TextEditingController checkOutDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 45,
            color: Color.fromRGBO(24, 54, 65, 0.858),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Room number entry box
                TextField(
                  controller: roomNumberController,
                  decoration: InputDecoration(
                    labelText: 'Room Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // Check-in and Check-out date entry boxes in a single row
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: checkInDateController,
                        readOnly: true,
                        onTap: () =>
                            _selectDate(context, checkInDateController),
                        decoration: InputDecoration(
                          labelText: 'Check-in Date',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: checkOutDateController,
                        readOnly: true,
                        onTap: () =>
                            _selectDate(context, checkOutDateController),
                        decoration: InputDecoration(
                          labelText: 'Check-out Date',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                // Booked button
                ElevatedButton(
                  onPressed: () {
                    // Implement your booking logic here
                  },
                  child: Text('Booked'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(24, 54, 65, 1),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
