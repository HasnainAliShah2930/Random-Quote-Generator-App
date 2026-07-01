import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/quote_local_data_source.dart';
import 'data/repositories/quote_repository_impl.dart';
import 'domain/repositories/quote_repository.dart';
import 'presentation/bloc/settings/settings_bloc.dart';
import 'presentation/bloc/favorites/favorites_bloc.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  runApp(const QuoteApp());
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<QuoteRepository>(
      // Single Model instance shared by every feature's Bloc.
      create: (_) => QuoteRepositoryImpl(localDataSource: QuoteLocalDataSource()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SettingsBloc()),
          BlocProvider(
            create: (context) => FavoritesBloc(
              repository: context.read<QuoteRepository>(),
            )..add(const FavoritesLoadRequested()),
          ),
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            double textScale;
            switch (settingsState.fontSize) {
              case AppFontSize.small:
                textScale = 0.85;
                break;
              case AppFontSize.medium:
                textScale = 1.0;
                break;
              case AppFontSize.large:
                textScale = 1.25;
                break;
            }

            return MaterialApp(
              title: 'Random Quote Generator',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme(settingsState.fontSize),
              darkTheme: AppTheme.darkTheme(settingsState.fontSize),
              themeMode: settingsState.themeMode,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(textScale),
                  ),
                  child: child!,
                );
              },
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
