import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'Flutter', 'color': Colors.cyanAccent},
      {'name': 'Dart', 'color': Colors.purpleAccent},
      {'name': 'Firebase', 'color': Colors.orangeAccent},
      {'name': 'Django', 'color': Colors.pinkAccent},
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.purpleAccent, Colors.cyanAccent],
              ).createShader(bounds),
              child: Text(
                'About Me',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.purpleAccent.withOpacity(0.1),
                      Colors.cyanAccent.withOpacity(0.1),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Text(
                  'I am a Flutter developer who loves building performant cross-platform apps. I have worked on e-commerce, chat, and IoT apps.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Skills & Technologies',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: skills.map((skill) {
                final color = skill['color'] as Color;
                return Chip(
                  label: Text(skill['name']! as String),
                  backgroundColor: color.withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
