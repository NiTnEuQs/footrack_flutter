import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/pages/home/components/home_page_view.dart";

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var _pageIndex = 0;
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          season.getName(defaultValue: "Saison ${season?.id}"),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: HomePageView(
        pageController: _pageController,
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
            _pageController.animateToPage(index, duration: Durations.long1, curve: Curves.ease);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Calendrier",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Équipe",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: "Adversaires",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: "Stats",
          ),
        ],
      ),
    );
  }
}
