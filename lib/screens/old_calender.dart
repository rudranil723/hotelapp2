// import 'package:flutter/material.dart';

// class CalendarScreen extends StatefulWidget {
//   @override
//   _CalendarScreenState createState() => _CalendarScreenState();
// }

// class _CalendarScreenState extends State<CalendarScreen> {
//   final TextEditingController roomNumberController = TextEditingController();
//   final TextEditingController checkInDateController = TextEditingController();
//   final TextEditingController checkOutDateController = TextEditingController();

//   Future<void> _selectDate(
//       BuildContext context, TextEditingController controller) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (selectedDate != null) {
//       setState(() {
//         controller.text = "${selectedDate.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image covering 60% of the screen with rounded bottom
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//               child: Image.asset(
//                 'assets/images/recep.jpg',
//                 fit: BoxFit.cover,
//                 height: MediaQuery.of(context).size.height * 0.7,
//               ),
//             ),
//           ),
//           // Back button
//           Positioned(
//             top: 16,
//             left: 16,
//             child: IconButton(
//               icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//           // Content below the image
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               margin: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.50,
//                 left: MediaQuery.of(context).size.width * 0.05,
//                 right: MediaQuery.of(context).size.width * 0.05,
//                 bottom: MediaQuery.of(context).size.height * 0.07,
//               ),
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10.0,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Room number entry box
//                   TextField(
//                     controller: roomNumberController,
//                     decoration: InputDecoration(
//                       labelText: 'Room Number',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Check-in and Check-out date entry boxes in a single row
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: checkInDateController,
//                           readOnly: true,
//                           onTap: () =>
//                               _selectDate(context, checkInDateController),
//                           decoration: InputDecoration(
//                             labelText: 'Check-in Date',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: TextField(
//                           controller: checkOutDateController,
//                           readOnly: true,
//                           onTap: () =>
//                               _selectDate(context, checkOutDateController),
//                           decoration: InputDecoration(
//                             labelText: 'Check-out Date',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 32),
//                   // Booked button with updated styles
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Implement your booking logic here
//                       },
//                       child:
//                           Text('check', style: TextStyle(color: Colors.white)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromRGBO(24, 54, 65, 1),
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         textStyle: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         elevation: 10,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
