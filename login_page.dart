import 'package:flutter/material.dart';
import 'register_page.dart'; // Import halaman Register
import 'dashboard.dart'; // Import halaman Dashboard

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true; // Variabel untuk menyimpan status visibility password
  bool _isHovered = false; // Variabel untuk menyimpan status hover tombol
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Cek apakah input username dan password terisi
  bool get _isInputFilled => _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF58403B), // Warna latar belakang sesuai dengan gambar
      body: Stack(
        children: [
          // Hiasan di pojok atas kanan
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 187,
              height: 47,
              decoration: BoxDecoration(
                color: Color(0xFFE5C6B6), // Warna hiasan
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50), // Radius untuk pojok bawah kiri
                ),
              ),
            ),
          ),
          // Hiasan di pojok bawah kiri
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 187,
              height: 47,
              decoration: BoxDecoration(
                color: Color(0xFFE5C6B6), // Warna hiasan
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50), // Radius untuk pojok atas kanan
                ),
              ),
            ),
          ),
          // Konten utama
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding di sekitar form
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Smart Home
                  Image.asset(
                    'assets/images/logo_rumah.png',
                    height: 150, // Atur ukuran logo
                  ),
                  SizedBox(height: 20), // Jarak antara logo dan teks
                  Text(
                    'SMART HOME',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40), // Jarak antara teks dan form
                  // Card untuk input dan tombol
                  Card(
                    color: Color(0xFFFAE7D7), // Warna latar belakang card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0), // Sudut card
                    ),
                    elevation: 4, // Bayangan card
                    child: Padding(
                      padding: const EdgeInsets.all(24.0), // Padding di dalam card
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Input Username dengan garis stroke
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54), // Garis stroke
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _usernameController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'username',
                                hintStyle: TextStyle(color: Colors.black54), // Warna hint text
                                border: InputBorder.none, // Tanpa garis tepi
                                contentPadding: EdgeInsets.all(12), // Padding di dalam input
                              ),
                              onChanged: (value) {
                                setState(() {}); // Update tampilan saat isi berubah
                              },
                            ),
                          ),
                          SizedBox(height: 20), // Jarak antara input username dan password
                          // Input Password dengan garis stroke
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54), // Garis stroke
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'password',
                                hintStyle: TextStyle(color: Colors.black54), // Warna hint text
                                border: InputBorder.none, // Tanpa garis tepi
                                contentPadding: EdgeInsets.all(12), // Padding di dalam input
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText; // Toggle visibility
                                    });
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {}); // Update tampilan saat isi berubah
                              },
                            ),
                          ),
                          SizedBox(height: 30), // Jarak antara input password dan tombol sign in
                          // Tombol Sign In dengan hover
                          GestureDetector(
                            onTap: _isInputFilled ? () {
                              // Here you can implement your login logic.
                              // For now, we directly navigate to Dashboard.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardPage(), // Navigasi ke halaman Dashboard
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
                                  border: Border.all(color: Colors.black54), // Garis stroke
                                  borderRadius: BorderRadius.circular(8),
                                  color: _isHovered && _isInputFilled ? Color(0xFF4E3B31) : Color(0xFFFAE7D7), // Warna latar belakang
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                                  child: Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                      color: _isHovered && _isInputFilled ? Colors.white : Colors.black, // Warna teks tombol
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20), // Jarak antara tombol sign in dan teks pendaftaran
                          // Teks untuk pendaftaran
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(), // Navigasi ke halaman Register
                                ),
                              );
                            },
                            child: Text(
                              'belum daftar? daftar',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                decoration: TextDecoration.underline, // Garis bawah pada teks
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
