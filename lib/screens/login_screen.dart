import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'calender.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/homebg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          // Back button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // 'Welcome' text
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            left: 16.0,
            child: Text(
              'WELCOME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // 'Sign in to continue' text
          Positioned(
            top: MediaQuery.of(context).size.height * 0.30,
            left: 16.0,
            child: Text(
              'Log in to continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // White box with email and password fields
          Positioned(
            top: MediaQuery.of(context).size.height * 0.60,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(24, 54, 65, 1),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        color: Color.fromRGBO(24, 54, 65, 1),
                      ),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(24, 54, 65, 1),
                        ),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          onPressed: () {
                            // Implement toggle password visibility
                          },
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(
                        color: Color.fromRGBO(24, 54, 65, 1),
                      ),
                    ),
                    SizedBox(height: 34),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarScreen()),
                        );
                      },
                      child: Text('Log in'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromRGBO(24, 54, 65, 1),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 10,
                        shadowColor: Colors.black,
                        textStyle: TextStyle(
                          color: Color.fromRGBO(24, 54, 65, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          // Implement your forgot password logic here
                        },
                        child: Text(
                          'Forgot password',
                          style: TextStyle(
                            color: Color.fromARGB(184, 0, 92, 3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
