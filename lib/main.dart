import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/config.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/favorites_repository/favorites_repository_memory.dart';
import 'package:places/data/location_repository/location_repository_mock.dart';
import 'package:places/data/network_client/network_client.dart';
import 'package:places/data/network_client/network_client_dio.dart';
import 'package:places/data/search_history_repository/search_history_db_repository.dart';
import 'package:places/data/search_history_repository/search_history_memory_repository.dart';
import 'package:places/data/shared_prefs_storage_repository/shared_prefs_storage_repository.dart';
import 'package:places/data/sight_repository/sight_repository_network.dart';
import 'package:places/data/visited_repository/visited_repository_memory.dart';
import 'package:places/domain/filter.dart';
import 'package:places/interactor/theme_interactor.dart';
import 'package:places/model/favorites/performers.dart';
import 'package:places/model/repository/favorites_repository.dart';
import 'package:places/model/repository/location_repository.dart';
import 'package:places/model/repository/search_history_repository.dart';
import 'package:places/model/repository/sight_repository.dart';
import 'package:places/model/repository/storage_repository.dart';
import 'package:places/model/repository/visited_repository.dart';
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
import 'package:places/ui/screen/splash_screen/splash_screen.dart';
import 'package:places/ui/screen/splash_screen/splash_screen_route.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // await uploadMocks(sightRepository);
  WidgetsFlutterBinding.ensureInitialized();
  final _storageRepository = await SharedPrefsStorageRepository.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider<StorageRepository>(
          create: (_) => _storageRepository,
        ),
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
        ),
      ],
      child: App(),
    ),
  );
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
        Provider<SearchHistoryRepository>(
          create: (context) => SearchHistoryDbRepository(
            context.read<AppDatabase>(),
          ),
        ),
        // Провайдим ErrorHandler для mwwm
        Provider<WidgetModelDependencies>(
          create: (context) => WidgetModelDependencies(
            errorHandler: DefaultErrorHandler(),
          ),
        ),
        Provider<ToggleFavoritePerformer>(
          create: (context) => ToggleFavoritePerformer(
            context.read<FavoritesRepository>(),
          ),
        ),
        ChangeNotifierProvider<ThemeInteractor>(
          create: (context) => ThemeInteractor(
            context.read<StorageRepository>(),
          ),
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
              OnboardingScreen.routeName: (context) => OnboardingScreen(),
              SelectCategoryScreen.routeName: (context) => SelectCategoryScreen(),
              SettingsScreen.routeName: (context) => SettingsScreen(),
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case SplashScreen.routeName:
                  return SplashScreenRoute();
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
