import 'package:flutter/material.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example static projects. Replace with JSON or CMS later.
    final projects = [
      {
        'title': 'Shopping App',
        'description': 'Van sales and mobile ordering app.',
        'tags': ['Flutter', 'Django', 'Firebase'],
        'demoUrl': 'https://example.com/shopping-demo' // if you host demos separately
      },
      {
        'title': 'Chat App',
        'description': 'Realtime translation + E2E encryption.',
        'tags': ['Flutter', 'Socket', 'ML'],
        'demoUrl': ''
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.purpleAccent, Colors.cyanAccent],
          ).createShader(bounds),
          child: Text(
            'Projects',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 1000 ? 3 : 1,
          childAspectRatio: 1.3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: projects.map((p) => ProjectCard(project: p)).toList(),
        ),
      ),
    );
  }
}
