import 'package:e_book_app/modules/explore/presentation/explore_page.dart';
import 'package:e_book_app/modules/home/presentation/home_page.dart';
import 'package:e_book_app/modules/setting/presentation/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static String routeName = 'main';
  static const String routePath = '/main';

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => const MainPage(),
  );

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _selectedIndex = 0;
  bool _isBacktoTop = false;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  bool get isBacktoTop => _isBacktoTop;

  static final List<Widget> _pages = [
    const HomePage(),
    const ExplorePage(),
    const SettingsPage(),
  ];

  void _scrollListener() {
    if (_selectedIndex == 1 && _scrollController.offset > 300) {
      _isBacktoTop = true;
    } else {
      _isBacktoTop = false;
    }
  }

  void onChange(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: BottomNavigationBar(
          onTap: onChange,
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          currentIndex: _selectedIndex,
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              activeIcon: FaIcon(FontAwesomeIcons.houseChimneyWindow),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.compass),
              activeIcon: FaIcon(FontAwesomeIcons.solidCompass),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.gear),
              activeIcon: FaIcon(FontAwesomeIcons.gears),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
