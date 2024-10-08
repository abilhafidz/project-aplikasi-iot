import 'package:flutter/material.dart';
import 'register_page.dart'; 
import 'dashboard.dart'; 

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true; 
  bool _isHovered = false; 
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  bool get _isInputFilled => _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF58403B), 
      body: Stack(
        children: [
         
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 187,
              height: 47,
              decoration: BoxDecoration(
                color: Color(0xFFE5C6B6), 
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50), 
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 187,
              height: 47,
              decoration: BoxDecoration(
                color: Color(0xFFE5C6B6), 
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50), 
                ),
              ),
            ),
          ),
          
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Image.asset(
                    'assets/images/logo_rumah.png',
                    height: 150, 
                  ),
                  SizedBox(height: 20), 
                  Text(
                    'SMART HOME',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40), 
                  
                  Card(
                    color: Color(0xFFFAE7D7), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0), 
                    ),
                    elevation: 4, 
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54), 
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _usernameController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'username',
                                hintStyle: TextStyle(color: Colors.black54), 
                                border: InputBorder.none, 
                                contentPadding: EdgeInsets.all(12),
                              ),
                              onChanged: (value) {
                                setState(() {}); 
                              },
                            ),
                          ),
                          SizedBox(height: 20), 
                          
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54), 
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'password',
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none, 
                                contentPadding: EdgeInsets.all(12), 
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText; 
                                    });
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {}); 
                              },
                            ),
                          ),
                          SizedBox(height: 30), 
                          
                          GestureDetector(
                            onTap: _isInputFilled ? () {
                             
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardPage(), 
                                ),
                              );
                            } : null, // Disable button jika input tidak lengkap
                            child: MouseRegion(
                              onEnter: (_) {
                                if (_isInputFilled) {
                                  setState(() => _isHovered = true);
                                }
                              },
                              onExit: (_) {
                                setState(() => _isHovered = false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54), 
                                  borderRadius: BorderRadius.circular(8),
                                  color: _isHovered && _isInputFilled ? Color(0xFF4E3B31) : Color(0xFFFAE7D7), 
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                                  child: Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                      color: _isHovered && _isInputFilled ? Colors.white : Colors.black, 
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20), 
                          // Teks untuk pendaftaran
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(), 
                                ),
                              );
                            },
                            child: Text(
                              'belum daftar? daftar',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                decoration: TextDecoration.underline, 
                              ),
                            ),
                          ),
                        ],
                      ),
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
