import 'package:flutter/material.dart';
import 'package:places/data/repository/favorites_repository/favorites_repository_memory.dart';
import 'package:places/data/repository/location_repository/location_repository_mock.dart';
import 'package:places/data/repository/place_repository/place_repository_memory.dart';
import 'package:places/data/repository/visited_repository/visited_repository_memory.dart';
import 'package:places/domain/interactor/settings_interactor/settings_interactor.dart';
import 'package:places/domain/interactor/sight_interactor.dart';
import 'package:places/domain/model/filter.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/search_history_state.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/select_category_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

// Хранилище для истории поиска.
// Тут, пока не внедряли других решений
final searchHistoryState = SearchHistoryState();

// Временное место для интерактора Мест
final SightInteractor sightInteractor = SightInteractor(
  placeRepository: PlaceRepositoryMemory(),
  favoritesRepository: FavoritesRepositoryMemory(),
  visitedRepository: VisitedRepositoryMemory(),
  locationRepository: LocationRepositoryMock(),
);

// Временное место для интерактора Настроек
final SettingsInteractor settingsInteractor = SettingsInteractor();

Future<void> main() async {
  await uploadMocks(sightInteractor.placeRepository);
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    settingsInteractor.themeState.addListener(_onThemeChange);
  }

  @override
  void dispose() {
    settingsInteractor.themeState.removeListener(_onThemeChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: settingsInteractor.themeState.isDark ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        SightListScreen.routeName: (context) => SightListScreen(),
        AddSightScreen.routeName: (context) => AddSightScreen(),
        SelectCategoryScreen.routeName: (context) => SelectCategoryScreen(),
        VisitingScreen.routeName: (context) => VisitingScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
      },

      // Аргументы на этих страницах передаются через конструктор,
      // т.к. в FiltersScreen они используются в initState,
      // остальные страницы так сделано для однородности и на будущее
      onGenerateRoute: (settings) {
        if (settings.name == SightDetailsScreen.routeName) {
          final sight = settings.arguments as Sight;
          return MaterialPageRoute(
            builder: (context) => SightDetailsScreen(sight: sight),
          );
        } else if (settings.name == FiltersScreen.routeName) {
          final filter = settings.arguments as Filter;
          return MaterialPageRoute(
            builder: (context) => FiltersScreen(filter: filter),
          );
        } else if (settings.name == SightSearchScreen.routeName) {
          final filter = settings.arguments as Filter;
          return MaterialPageRoute(
            builder: (context) => SightSearchScreen(filter: filter),
          );
        }
        return null;
      },
    );
  }

  void _onThemeChange() => setState(() {});
}
