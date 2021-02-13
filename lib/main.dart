import 'package:flutter/material.dart';
import 'package:places/config.dart';
import 'package:places/data/favorites_repository/favorites_repository_memory.dart';
import 'package:places/data/location_repository/location_repository_mock.dart';
import 'package:places/data/network_client/network_client.dart';
import 'package:places/data/network_client/network_client_dio.dart';
import 'package:places/data/sight_repository/sight_repository_network.dart';
import 'package:places/data/visited_repository/visited_repository_memory.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/favorites_interactor.dart';
import 'package:places/interactor/repository/favorites_repository.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/interactor/repository/visited_repository.dart';
import 'package:places/interactor/search_history_interactor.dart';
import 'package:places/interactor/sight_interactor.dart';
import 'package:places/interactor/theme_interactor.dart';
import 'package:places/interactor/visiting_interactor.dart';
import 'package:places/ui/res/app_strings.dart';
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
import 'package:provider/provider.dart';

Future<void> main() async {
  // await uploadMocks(sightRepository);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NetworkClient networkClient =
        NetworkClientDio(baseUrl: Config.baseUrl);
    // final NetworkClient networkClient = NetworkClientNoInternet();

    final SightRepository sightRepository =
        SightRepositoryNetwork(networkClient);
    // final SightRepository sightRepository = SightRepositoryMemory();

    final FavoritesRepository favoritesRepository = FavoritesRepositoryMemory();
    final VisitedRepository visitedRepository = VisitedRepositoryMemory();
    final LocationRepository locationRepository = LocationRepositoryMock();

    return MultiProvider(
      providers: [
        Provider<SightInteractor>(
          create: (context) => SightInteractor(
            sightRepository: sightRepository,
            visitedRepository: visitedRepository,
            locationRepository: locationRepository,
          ),
        ),
        Provider<FavoritesInteractor>(
          create: (context) => FavoritesInteractor(
            sightRepository: sightRepository,
            favoritesRepository: favoritesRepository,
            locationRepository: locationRepository,
          ),
        ),
        Provider<VisitedInteractor>(
          create: (context) => VisitedInteractor(
            sightRepository: sightRepository,
            visitedRepository: visitedRepository,
          ),
        ),
        Provider<SearchHistoryInteractor>(
          create: (context) => SearchHistoryInteractor(),
        ),
        ChangeNotifierProvider<ThemeInteractor>(
          create: (context) => ThemeInteractor(),
        ),
      ],
      child: Consumer<ThemeInteractor>(
        builder: (context, themeInteractor, _) {
          return MaterialApp(
            title: AppStrings.appTitle,
            theme: themeInteractor.theme,
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              OnboardingScreen.routeName: (context) => OnboardingScreen(),
              SightListScreen.routeName: (context) => SightListScreen(),
              AddSightScreen.routeName: (context) => AddSightScreen(),
              SelectCategoryScreen.routeName: (context) =>
                  SelectCategoryScreen(),
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
        },
      ),
    );
  }
}
