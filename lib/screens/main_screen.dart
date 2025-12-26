import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/project_card.dart';
import '../widgets/animated_section.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'projects': GlobalKey(),
    'about': GlobalKey(),
    'contact': GlobalKey(),
  };
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Update current section based on scroll position
    // Simple implementation - can be enhanced with more precise detection
  }

  void _scrollToSection(String key) {
    final context = _sectionKeys[key]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _downloadResume() async {
    final url = 'assets/assets/resume.pdf';
    if (!await launchUrl(Uri.parse(url))) {
      // fallback behavior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(onNavItemTap: _scrollToSection),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _buildHomeSection(),
                  _buildAboutSection(),
                  _buildServicesSection(),
                  _buildProjectsSection(),
                  _buildExperienceSection(),
                  _buildStatsSection(),
                  _buildContactSection(),
                  SizedBox(height: 40), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return OutlinedButton(
      onPressed: () {
        // Handle button press
        launchUrl(Uri.parse(url));
      },
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(), // Makes the button circular
        padding: const EdgeInsets.all(20), // Adjusts the size of the circle
        side: const BorderSide(
          color: Colors.blue,
          width: 2,
        ), // Sets the outline color and width
      ),
      child: FaIcon(icon, color: Colors.blue), // The icon inside the button
    );
  }

  Widget _buildHomeSection() {
    return AnimatedSection(
      delay: Duration(milliseconds: 200),
      child: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isMobile = screenWidth < 600;
          final isTablet = screenWidth >= 600 && screenWidth < 900;
          final isWide = screenWidth >= 900;

          return Container(
            key: _sectionKeys['home'],
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? 16
                  : isTablet
                  ? 24
                  : 32,
              vertical: isMobile ? 40 : 60,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0A1929),
                  const Color(0xFF112240),
                  const Color(0xFF0A1929),
                ],
              ),
            ),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 2, child: _buildHomeContent(isMobile)),
                      SizedBox(width: 32),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.blueAccent.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/photo1.PNG',
                              height: 280,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 32),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.blueAccent.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/photo1.PNG',
                            height: isMobile ? 180 : 200,
                            width: isMobile ? 180 : 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      _buildHomeContent(isMobile),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildHomeContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'Muhammed Suhair Mk',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: isMobile ? 28 : 40,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Text(
            'Fullstack Mobile Application Developer',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.blueAccent,
              fontSize: isMobile ? 16 : null,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: 16),
        Flexible(
          child: Text(
            'A passionate Fullstack Mobile Application Developer with over 2 years of experience in building high-performance, cross-platform mobile applications. Proficient in Dart, state management (Provider, Riverpod, GetX, BLOC), and Firebase, focused on delivering clean, responsive, and user-friendly solutions.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
              height: 1.6,
              fontSize: isMobile ? 14 : null,
            ),
            overflow: TextOverflow.visible,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: isMobile ? 8 : 12,
          runSpacing: isMobile ? 8 : 12,
          alignment: WrapAlignment.start,
          children: [
            // ElevatedButton(
            //   onPressed: () => _scrollToSection('projects'),
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: isMobile ? 20 : 24,
            //       vertical: isMobile ? 12 : 12,
            //     ),
            //   ),
            //   child: Text(
            //     'View Projects',
            //     style: TextStyle(fontSize: isMobile ? 14 : 16),
            //   ),
            // ),
            _buildSocialIcon(FontAwesomeIcons.whatsapp, 'https://wa.me/919995518067'),
            _buildSocialIcon(FontAwesomeIcons.linkedin, 'https://www.linkedin.com/in/suhairmkm/'),
            _buildSocialIcon(FontAwesomeIcons.instagram, 'https://www.instagram.com/suhair._mk/'),
            _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/Suhairmk'),

           

            // IconButton(
            //   icon: Icon(Icons.download),
            //   onPressed: ,
            //   tooltip: ,
            //   color: Colors.blueAccent,
            //   iconSize: isMobile ? 24 : 28,
            // ),
          ],
        ),
        SizedBox(height: 20,),
         OutlinedButton.icon(
              onPressed: _downloadResume,
              label: Text('Download Resume'),
              icon: Icon(Icons.download, color: Colors.blueAccent,size: isMobile ? 24 : 28,),
              
            ),
      ],
    );
  }

  Widget _buildServicesSection() {
    return AnimatedSection(
      delay: Duration(milliseconds: 300),
      child: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isMobile = screenWidth < 600;
          final isWide = screenWidth > 900;

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 32,
              vertical: isMobile ? 40 : 60,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF0A1929), const Color(0xFF112240)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Services & Expertise',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24 : null,
                  ),
                ),
                const SizedBox(height: 32),
                isWide
                    ? Row(
                        children: [
                          Expanded(
                            child: _buildServiceCard(
                              'Mobile App Development',
                              'Building cross-platform mobile applications using Flutter with clean architecture and best practices.',
                              Icons.phone_android,
                              0,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildServiceCard(
                              'Backend Development',
                              'Developing robust RESTful APIs using Python (Django/Flask) with secure authentication and database management.',
                              Icons.storage,
                              200,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildServiceCard(
                              'Full-Stack Solutions',
                              'End-to-end development from mobile apps to backend services, ensuring seamless integration and scalability.',
                              Icons.code,
                              400,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildServiceCard(
                            'Mobile App Development',
                            'Building cross-platform mobile applications using Flutter with clean architecture and best practices.',
                            Icons.phone_android,
                            0,
                          ),
                          SizedBox(height: 16),
                          _buildServiceCard(
                            'Backend Development',
                            'Developing robust RESTful APIs using Python (Django/Flask) with secure authentication and database management.',
                            Icons.storage,
                            200,
                          ),
                          SizedBox(height: 16),
                          _buildServiceCard(
                            'Full-Stack Solutions',
                            'End-to-end development from mobile apps to backend services, ensuring seamless integration and scalability.',
                            Icons.code,
                            400,
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(
    String title,
    String description,
    IconData icon,
    int delay,
  ) {
    return AnimatedSection(
      delay: Duration(milliseconds: delay),
      child: Card(
        elevation: 4,
        color: const Color(0xFF112240),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.blueAccent.withOpacity(0.3),
              width: 1,
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.blueAccent, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(color: Colors.white70, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsSection() {
    final projects = [
      {
        'title': 'INCO Benefit Points',
        'description':
            'Developed a Flutter application for electricians to scan product QR codes, earn points, and redeem them for gifts. Implemented core features including gift redemption tracking, offers, notifications, profile management, and a help center. Integrated PHP APIs for backend data management and reward processing.',
        'tags': ['Flutter', 'PHP', 'Firebase', 'Provider', 'REST APIs'],
        'demoUrl': '',
      },
      {
        'title': 'Restaurant Food Delivery App',
        'description':
            'Built a comprehensive food delivery solution with two separate mobile applications: User App for browsing restaurants, placing orders, payments, and tracking delivery; and Delivery Boy App for accepting orders, viewing deliveries, updating status, and real-time tracking. Developed backend using Django REST Framework with MySQL database.',
        'tags': ['Flutter', 'Django', 'MySQL', 'Firebase', 'REST APIs'],
        'demoUrl': '',
      },
    ];

    return AnimatedSection(
      delay: Duration(milliseconds: 400),
      child: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isMobile = screenWidth < 600;
          final isTablet = screenWidth >= 600 && screenWidth < 1000;
          final isWide = screenWidth >= 1000;

          return Container(
            key: _sectionKeys['projects'],
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? 16
                  : isTablet
                  ? 24
                  : 32,
              vertical: isMobile ? 40 : 60,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF112240), const Color(0xFF0A1929)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Projects',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24 : null,
                  ),
                ),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: isWide ? 2 : 1,
                  childAspectRatio: isMobile ? 1.2 : 1.3,
                  mainAxisSpacing: isMobile ? 12 : 16,
                  crossAxisSpacing: isMobile ? 12 : 16,
                  children: projects
                      .map((p) => ProjectCard(project: p))
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExperienceSection() {
    return AnimatedSection(
      delay: Duration(milliseconds: 500),
      child: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isMobile = screenWidth < 600;

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 32,
              vertical: isMobile ? 40 : 60,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF112240), const Color(0xFF0A1929)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Experience & Journey',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24 : null,
                  ),
                ),
                const SizedBox(height: 32),
                _buildExperienceItem(
                  'Fullstack Mobile Developer',
                  '2+ Years',
                  'Building high-performance cross-platform mobile applications with Flutter, implementing state management solutions, and developing robust backend APIs.',
                  ['Flutter', 'Dart', 'Django', 'Firebase', 'REST APIs'],
                  0,
                ),
                SizedBox(height: 24),
                _buildExperienceItem(
                  'Backend Development',
                  '2+ Years',
                  'Designing and implementing secure RESTful APIs, managing SQL and NoSQL databases, and ensuring scalable backend architecture.',
                  [
                    'Python',
                    'Django',
                    'Flask',
                    'MySQL',
                    'PostgreSQL',
                    'MongoDB',
                  ],
                  200,
                ),
                SizedBox(height: 24),
                _buildExperienceItem(
                  'Mobile UI/UX',
                  '2+ Years',
                  'Creating responsive and intuitive user interfaces following Material Design principles, implementing animations, and ensuring optimal user experience.',
                  [
                    'Material Design',
                    'Responsive UI',
                    'Animations',
                    'Custom Widgets',
                  ],
                  400,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExperienceItem(
    String title,
    String duration,
    String description,
    List<String> skills,
    int delay,
  ) {
    return AnimatedSection(
      delay: Duration(milliseconds: delay),
      child: Card(
        elevation: 4,
        color: const Color(0xFF0A1929),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.blueAccent.withOpacity(0.3),
              width: 1,
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      duration,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(color: Colors.white70, height: 1.6),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills
                    .map(
                      (skill) => Chip(
                        label: Text(skill, style: TextStyle(fontSize: 12)),
                        backgroundColor: Colors.blueAccent.withOpacity(0.1),
                        labelStyle: TextStyle(color: Colors.blueAccent),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return AnimatedSection(
      delay: Duration(milliseconds: 600),
      child: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isMobile = screenWidth < 600;
          final isWide = screenWidth > 900;

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 32,
              vertical: isMobile ? 40 : 60,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF0A1929), const Color(0xFF112240)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Key Achievements',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24 : null,
                  ),
                ),
                const SizedBox(height: 32),
                isWide
                    ? Row(
                        children: [
                          Expanded(
                            child: _buildStatCard('2+', 'Years Experience', 0),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildStatCard(
                              '10+',
                              'Projects Completed',
                              200,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildStatCard(
                              '5+',
                              'Technologies Mastered',
                              400,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildStatCard(
                              '100%',
                              'Client Satisfaction',
                              600,
                            ),
                          ),
                        ],
                      )
                    : GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: [
                          _buildStatCard('2+', 'Years Experience', 0),
                          _buildStatCard('10+', 'Projects Completed', 200),
                          _buildStatCard('5+', 'Technologies Mastered', 400),
                          _buildStatCard('100%', 'Client Satisfaction', 600),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String number, String label, int delay) {
    return AnimatedSection(
      delay: Duration(milliseconds: delay),
      child: Card(
        elevation: 4,
        color: const Color(0xFF112240),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.blueAccent.withOpacity(0.3),
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueAccent.withOpacity(0.1), Colors.transparent],
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return AnimatedSection(
      delay: Duration(milliseconds: 700),
      child: Builder(
        builder: (context) {
          final mobileSkills = [
            'Flutter',
            'Dart',
            'Provider',
            'GetX',
            'BLoC',
            'Riverpod',
            'Firebase',
            'Firestore',
            'Cloud Messaging',
            'Push Notifications',
            'Google Maps',
            'QR Code Scanning',
            'Material Design',
          ];

          final backendSkills = [
            'Python',
            'Django',
            'Flask',
            'RESTful APIs',
            'JWT',
            'OAuth',
            'MySQL',
            'PostgreSQL',
            'SQLite',
            'MongoDB',
            'Firestore',
          ];

          final webSkills = [
            'HTML5',
            'CSS3',
            'JavaScript',
            'Bootstrap',
            'Tailwind CSS',
          ];

          final toolsSkills = [
            'Git',
            'GitHub',
            'GitLab',
            'Postman',
            'Thunder Client',
            'Google Play Store',
            'Firebase Hosting',
          ];

          return Builder(
            builder: (context) {
              final screenWidth = MediaQuery.of(context).size.width;
              final isMobile = screenWidth < 600;

              return Container(
                key: _sectionKeys['about'],
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: isMobile ? 40 : 60,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF0A1929), const Color(0xFF112240)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Me',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 24 : null,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: const Color(0xFF112240),
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 16 : 20),
                        child: Text(
                          'A passionate Fullstack Mobile Application Developer with over 2 years of experience in building high-performance, cross-platform mobile applications. Proficient in Dart, state management (Provider, Riverpod, GetX, BLOC), and Firebase, focused on delivering clean, responsive, and user-friendly solutions. Possesses strong full-stack capabilities, with expertise in backend development using Python (Django and Flask), designing and implementing secure RESTful APIs, and working with SQL (MySQL, PostgreSQL, SQLite) and NoSQL (Firestore, MongoDB) databases for efficient data management. Proven problem-solver committed to delivering scalable, high-quality applications.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.white70,
                                height: 1.6,
                                fontSize: isMobile ? 14 : null,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Technical Skills',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: isMobile ? 18 : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSkillCategory(
                      'Mobile Development',
                      mobileSkills,
                      isMobile,
                    ),
                    const SizedBox(height: 16),
                    _buildSkillCategory(
                      'Backend Development',
                      backendSkills,
                      isMobile,
                    ),
                    const SizedBox(height: 16),
                    _buildSkillCategory('Web Development', webSkills, isMobile),
                    const SizedBox(height: 16),
                    _buildSkillCategory(
                      'Tools & Version Control',
                      toolsSkills,
                      isMobile,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSkillCategory(
    String category,
    List<String> skills,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 15 : 16,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: isMobile ? 8 : 12,
          runSpacing: isMobile ? 8 : 12,
          children: skills.map((skill) {
            return Chip(
              label: Text(
                skill,
                style: TextStyle(fontSize: isMobile ? 12 : 13),
              ),
              backgroundColor: Colors.blueAccent.withOpacity(0.1),
              labelStyle: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 10 : 14,
                vertical: isMobile ? 5 : 7,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return AnimatedSection(
      delay: Duration(milliseconds: 800),
      child: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isMobile = screenWidth < 600;

          return Container(
            key: _sectionKeys['contact'],
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 40 : 60,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF112240), const Color(0xFF0A1929)],
              ),
            ),
            child: ContactForm(isMobile: isMobile),
          );
        },
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  final bool isMobile;

  ContactForm({required this.isMobile});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  String message = '';
  bool sending = false;
  final String formspreeEndpoint = 'https://formspree.io/f/yourFormId';

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => sending = true);
    try {
      final r = await http.post(
        Uri.parse(formspreeEndpoint),
        body: {'name': name, 'email': email, 'message': message},
        headers: {'Accept': 'application/json'},
      );

      if (r.statusCode == 200 || r.statusCode == 201) {
        _showSnack('Message sent — thank you!');
        _formKey.currentState!.reset();
      } else {
        _showSnack('Failed to send. Status: ${r.statusCode}');
      }
    } catch (e) {
      _showSnack('Error sending message: $e');
    } finally {
      setState(() => sending = false);
    }
  }

  void _showSnack(String s) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(s), backgroundColor: const Color(0xFF112240)),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: widget.isMobile ? 24 : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'I\'d love to hear from you!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
            fontSize: widget.isMobile ? 14 : null,
          ),
        ),
        const SizedBox(height: 24),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.blueAccent,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.isMobile ? 12 : 16,
                    vertical: widget.isMobile ? 16 : 20,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.isMobile ? 14 : null,
                ),
                onSaved: (v) => name = v ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.blueAccent,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.isMobile ? 12 : 16,
                    vertical: widget.isMobile ? 16 : 20,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.isMobile ? 14 : null,
                ),
                onSaved: (v) => email = v ?? '',
                validator: (v) =>
                    (v != null && v.contains('@')) ? null : 'Enter valid email',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Message',
                  prefixIcon: Icon(
                    Icons.message_outlined,
                    color: Colors.blueAccent,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.isMobile ? 12 : 16,
                    vertical: widget.isMobile ? 16 : 20,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.isMobile ? 14 : null,
                ),
                onSaved: (v) => message = v ?? '',
                maxLines: widget.isMobile ? 5 : 6,
                validator: (v) => (v != null && v.trim().length >= 5)
                    ? null
                    : 'Message too short',
              ),
              const SizedBox(height: 24),
              sending
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blueAccent,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _send,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: widget.isMobile ? 14 : 16,
                        ),
                      ),
                      child: Text(
                        'Send Message',
                        style: TextStyle(
                          fontSize: widget.isMobile ? 14 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
