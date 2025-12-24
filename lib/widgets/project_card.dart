import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final Map project;
  ProjectCard({required this.project});
  
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tags = (widget.project['tags'] as List).cast<String>();
    final accentColor = Colors.blueAccent;
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return MouseRegion(
      onEnter: (_) {
        _controller.forward();
      },
      onExit: (_) {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFF0A1929),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withOpacity(0.3),
            width: 1,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              accentColor.withOpacity(0.1),
              Colors.transparent,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: isMobile ? 24 : 28,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: isMobile ? 8 : 12),
                  Expanded(
                    child: Text(
                      widget.project['title'] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 18 : 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 8 : 12),
              Text(
                widget.project['description'] ?? '',
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.5,
                  fontSize: isMobile ? 14 : null,
                ),
              ),
              SizedBox(height: isMobile ? 8 : 12),
              Wrap(
                spacing: isMobile ? 6 : 8,
                runSpacing: isMobile ? 6 : 8,
                children: tags.map((t) => Chip(
                  label: Text(
                    t,
                    style: TextStyle(fontSize: isMobile ? 12 : null),
                  ),
                  backgroundColor: accentColor.withOpacity(0.1),
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 12,
                    vertical: isMobile ? 4 : 6,
                  ),
                )).toList(),
              ),
              Spacer(),
              isMobile
                  ? Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final url = widget.project['demoUrl'] ?? '';
                              if (url != null && url.isNotEmpty) {
                                await launchUrl(Uri.parse(url));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'Open Demo',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              launchUrl(Uri.parse('https://github.com/yourname/yourrepo'));
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blueAccent,
                              side: BorderSide(color: Colors.blueAccent),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'Source',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final url = widget.project['demoUrl'] ?? '';
                              if (url != null && url.isNotEmpty) {
                                await launchUrl(Uri.parse(url));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Open Demo'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              launchUrl(Uri.parse('https://github.com/yourname/yourrepo'));
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blueAccent,
                              side: BorderSide(color: Colors.blueAccent),
                            ),
                            child: Text('Source'),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
        ),
      ),
    );
  }
}
