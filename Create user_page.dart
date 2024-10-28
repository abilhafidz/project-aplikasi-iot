import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'weather.dart';
import 'about_us.dart'; 
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _selectedIndex = 2; 
  User? currentUser; 

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  
  void _getCurrentUser() async {
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      setState(() {
        currentUser = null; 
      });
    }
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => DashboardPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      } else if (index == 1) {
        
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => WeatherPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      }
    }
  }

  
  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut(); 
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  
  Future<void> _showDeleteAccountDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah anda yakin untuk menghapus akun?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); 
                await _deleteAccount(); 
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }


  
  Future<void> _deleteAccount() async {
    try {
      await currentUser?.delete(); 
      Navigator.pushReplacementNamed(context, '/login'); 
    } catch (e) {
      print("Error deleting account: $e");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: const Color(0xFFFAEBD7),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'User Profile',
          style: TextStyle(
            color: Color(0xFF66544D),
            fontFamily: 'Unica One',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFF5B4741),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              _buildUserCard(),

            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  
  Widget _buildUserCard() {
    return Card(
      color: const Color(0xFFFAEBD7),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(
              Icons.person_pin,
              size: 120,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            _buildBeautifiedText('Email: ${currentUser?.email ?? 'Not available'}'),
            const SizedBox(height: 20),
            _buildAboutUsButton(), 
            const SizedBox(height: 20),
            _buildDeleteAccountButton(), 
            const SizedBox(height: 20),
            _buildLogoutButton(),

          ],
        ),
      ),
    );
  }


  Widget _buildBeautifiedText(String text) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300), 
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE3DAC9), Color(0xFFF5DEB3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Color(0xFF66544D), width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(3, 3),
            blurRadius: 6,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.email, 
            color: Colors.black87,
            size: 24,
          ),
          const SizedBox(width: 8), 
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18, 
                fontFamily: 'Unica One',
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis, 
              maxLines: 1, 
              softWrap: false, 
            ),
          ),
        ],
      ),
    );
  }


  
  Widget _buildAboutUsButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutUsPage()), 
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE3DAC9), Color(0xFFF5DEB3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Color(0xFF66544D), width: 2),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info, 
              color: Colors.black87,
              size: 24,
            ),
            const SizedBox(width: 8), 
            const Text(
              'About Us',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontFamily: 'Unica One',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildDeleteAccountButton() {
    return GestureDetector(
      onTap: _showDeleteAccountDialog, 
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE3DAC9), Color(0xFFF5DEB3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Color(0xFF66544D), width: 2),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.delete, 
              color: Colors.black87,
              size: 24,
            ),
            const SizedBox(width: 8), 
            const Text(
              'Hapus Akun',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Unica One',
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: _handleLogout,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE3DAC9), Color(0xFFF5DEB3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Color(0xFF66544D), width: 2),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.logout, 
              color: Colors.black87,
              size: 24,
            ),
            const SizedBox(width: 8), 
            const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontFamily: 'Unica One',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFFAEBD7),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wb_sunny),
          label: 'Weather',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'User',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Unica One', 

      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Unica One', 

      ),
      onTap: _onItemTapped,
    );
  }
}
