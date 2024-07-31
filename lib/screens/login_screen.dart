import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'calender.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://localhost:3000/login'), // Use your actual API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        String authKey = responseData['auth_key'];
        int employeeId = responseData['employee_id'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CalendarScreen(authKey: authKey, employeeId: employeeId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${response.reasonPhrase}')),
      );
    }
  }

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
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // 'Welcome' text
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            left: 16.0,
            child: const Text(
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
            child: const Text(
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
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(24, 54, 65, 1),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        color: Color.fromRGBO(24, 54, 65, 1),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(24, 54, 65, 1),
                        ),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility_off),
                          onPressed: () {
                            // Implement toggle password visibility
                          },
                        ),
                      ),
                      obscureText: true,
                      style: const TextStyle(
                        color: Color.fromRGBO(24, 54, 65, 1),
                      ),
                    ),
                    const SizedBox(height: 34),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(24, 54, 65, 1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 10,
                        shadowColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromRGBO(24, 54, 65, 1)),
                            )
                          : const Text('Log in'),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          // Implement your forgot password logic here
                        },
                        child: const Text(
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
