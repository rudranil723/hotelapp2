// import 'package:flutter/material.dart';
// import 'login_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Blurred background image
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/homebg.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned.fill(
//             child: Container(
//               color: Colors.black.withOpacity(0.7),
//             ),
//           ),
//           // Content on top of the background
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.15),
//                 const Text(
//                   'WELCOME',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 45,
//                     fontWeight: FontWeight.w900,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'ALL YOUR HOTEL NEEDS END HERE',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: GestureDetector(
//                     onTapDown: (_) {
//                       setState(() {
//                         _isPressed = true;
//                       });
//                     },
//                     onTapUp: (_) {
//                       setState(() {
//                         _isPressed = false;
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => LoginScreen(),
//                           ),
//                         );
//                       });
//                     },
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       curve: Curves.easeInOut,
//                       margin: EdgeInsets.only(
//                           bottom: MediaQuery.of(context).size.height * 0.20),
//                       width: _isPressed
//                           ? MediaQuery.of(context).size.width * 0.75
//                           : MediaQuery.of(context).size.width * 0.80,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8.0),
//                         boxShadow: [
//                           if (_isPressed)
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.5),
//                               offset: const Offset(0, 8),
//                               blurRadius: 15,
//                             ),
//                         ],
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'Log in',
//                           style: TextStyle(
//                             color: Color.fromRGBO(24, 54, 65, 1),
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
