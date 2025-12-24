import 'package:flutter/material.dart';

class AppNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'title': 'Home', 'route': '/', 'icon': Icons.home, 'color': Colors.purpleAccent},
      {'title': 'Projects', 'route': '/projects', 'icon': Icons.work, 'color': Colors.cyanAccent},
      {'title': 'About', 'route': '/about', 'icon': Icons.person, 'color': Colors.pinkAccent},
      {'title': 'Contact', 'route': '/contact', 'icon': Icons.email, 'color': Colors.orangeAccent},
    ];
    
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E1E2E),
              const Color(0xFF121212),
            ],
          ),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.cyanAccent, Colors.pinkAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.white, Colors.white70],
                ).createShader(bounds),
                child: Text(
                  'Your Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ...menuItems.map((item) => ListTile(
              leading: Icon(
                item['icon'] as IconData,
                color: item['color'] as Color,
              ),
              title: Text(
                item['title'] as String,
                style: TextStyle(
                  color: item['color'] as Color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () => Navigator.pushReplacementNamed(context, item['route'] as String),
            )),
          ],
        ),
      ),
    );
  }
}
