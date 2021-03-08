import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/config.dart';
import 'package:places/data/favorites_repository/favorites_repository_memory.dart';
import 'package:places/data/location_repository/location_repository_mock.dart';
import 'package:places/data/network_client/network_client.dart';
import 'package:places/data/network_client/network_client_dio.dart';
import 'package:places/data/search_history_repository/search_history_repository.dart';
import 'package:places/data/sight_repository/sight_repository_network.dart';
import 'package:places/data/visited_repository/visited_repository_memory.dart';
import 'package:places/domain/filter.dart';
import 'package:places/interactor/repository/favorites_repository.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/interactor/repository/visited_repository.dart';
import 'package:places/interactor/sight_interactor.dart';
import 'package:places/interactor/theme_interactor.dart';
import 'package:places/ui/error/default_error_handler.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen_route.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/filters_screen/fliters_screen_route.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/select_category_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen_route.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen_route.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // await uploadMocks(sightRepository);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SightRepository>(
          create: (context) {
            final NetworkClient networkClient = NetworkClientDio(
              baseUrl: Config.baseUrl,
            );
            // final NetworkClient networkClient = NetworkClientNoInternet();
            final SightRepository repo = SightRepositoryNetwork(networkClient);
            // final NetworkClient networkClient = NetworkClientNoInternet();
            // final SightRepository sightRepository = SightRepositoryMemory();
            return repo;
          },
        ),
        Provider<LocationRepository>(
          create: (_) => LocationRepositoryMock(),
        ),
        Provider<FavoritesRepository>(
          create: (_) => FavoritesRepositoryMemory(),
        ),
        Provider<VisitedRepository>(
          create: (_) => VisitedRepositoryMemory(),
        ),
        Provider<SightInteractor>(
          create: (context) => SightInteractor(
            sightRepository: context.read<SightRepository>(),
            visitedRepository: context.read<VisitedRepository>(),
            locationRepository: context.read<LocationRepository>(),
          ),
          dispose: (context, interactor) {
            interactor.dispose();
          },
        ),
        Provider<SearchHistoryRepository>(
          create: (context) => SearchHistoryRepository(),
        ),
        // Провайдим ErrorHandler для mwwm
        Provider<WidgetModelDependencies>(
          create: (context) => WidgetModelDependencies(
            errorHandler: DefaultErrorHandler(),
          ),
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
              SelectCategoryScreen.routeName: (context) =>
                  SelectCategoryScreen(),
              SettingsScreen.routeName: (context) => SettingsScreen(),
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case AddSightScreen.routeName:
                  return AddSightScreenRoute();
                case FiltersScreen.routeName:
                  final filter = settings.arguments as Filter;
                  return FiltersScreenRoute(filter: filter);
                case SightSearchScreen.routeName:
                  final filter = settings.arguments as Filter;
                  return SightSearchScreenRoute(filter: filter);
                case SightListScreen.routeName:
                  return SightListScreenRoute();
                case VisitingScreen.routeName:
                  return VisitingScreenRoute();
                default:
                  return null;
              }
            },
          );
        },
      ),
    );
  }
}
