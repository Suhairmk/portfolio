import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final Function(String) onNavItemTap;
  
  NavBar({required this.onNavItemTap});
  
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  bool _isMenuOpen = false;
  
  final List<NavItem> _navItems = [
    NavItem( label: 'Home', sectionKey: 'home'),
    NavItem( label: 'Projects', sectionKey: 'projects'),
    NavItem( label: 'About', sectionKey: 'about'),
    NavItem( label: 'Contact', sectionKey: 'contact'),
  ];
  
  void _handleTap(int index) {
    setState(() {
      _selectedIndex = index;
      _isMenuOpen = false; // Close menu when item is tapped
    });
    widget.onNavItemTap(_navItems[index].sectionKey);
  }
  
  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A1929),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? _buildMobileNav()
          : _buildDesktopNav(isTablet),
    );
  }
  
  Widget _buildMobileNav() {
    return Stack(
      children: [
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Muhammed Suhair Mk',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  _isMenuOpen ? Icons.close : Icons.menu,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: _toggleMenu,
              ),
            ],
          ),
        ),
        if (_isMenuOpen)
          Positioned.fill(
            top: 60,
            child: GestureDetector(
              onTap: () => setState(() => _isMenuOpen = false),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(maxHeight: 300),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A1929),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _navItems.map((item) {
                        final index = _navItems.indexOf(item);
                        final isSelected = _selectedIndex == index;
                        return InkWell(
                          onTap: () => _handleTap(index),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                               
                                SizedBox(width: 16),
                                Text(
                                  item.label,
                                  style: TextStyle(
                                    color: isSelected ? Colors.blueAccent : Colors.white70,
                                    fontSize: 16,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildDesktopNav(bool isTablet) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 24),
      child: Row(
        children: [
          Flexible(
            child: Text(
              'Muhammed Suhair Mk',
              style: TextStyle(
                color: Colors.white,
                fontSize: isTablet ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: _navItems.map((item) {
              final index = _navItems.indexOf(item);
              final isSelected = _selectedIndex == index;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 4 : 8),
                child: InkWell(
                  onTap: () => _handleTap(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 12 : 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 1)
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       
                        SizedBox(width: isTablet ? 6 : 8),
                        Text(
                          item.label,
                          style: TextStyle(
                            color: isSelected ? Colors.blueAccent : Colors.white70,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: isTablet ? 14 : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class NavItem {

  final String label;
  final String sectionKey;
  
  NavItem({
    
    required this.label,
    required this.sectionKey,
  });
}

