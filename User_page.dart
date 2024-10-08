import 'package:flutter/material.dart';

void main() => runApp(UserPage());

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFDCCFBF),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Color(0xFF614A3F),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.home, size: 40.0, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'user',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.account_circle,
                        size: 60.0,
                        color: Color(0xFF2E2A28),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF2E2A28),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      child: Text('LOGOUT'),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xFF2E2A28),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.dashboard, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
