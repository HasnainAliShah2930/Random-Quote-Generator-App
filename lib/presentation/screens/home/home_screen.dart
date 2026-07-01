import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/repositories/quote_repository.dart';
import '../../bloc/quote/quote_bloc.dart';
import '../../bloc/favorites/favorites_bloc.dart';
import '../../widgets/home_quote_card.dart';

/// Home screen — wires up its own scoped [QuoteBloc] (MVVM: this is the
/// "View", the bloc is the "ViewModel", [QuoteRepository] is the "Model").
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QuoteBloc(repository: context.read<QuoteRepository>())
            ..add(const LoadRandomQuoteRequested()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        title: const Text('Random Quote'),
        centerTitle: true,
        actions: [
          BlocBuilder<QuoteBloc, QuoteState>(
            builder: (context, state) {
              final isFav = state is QuoteLoaded && state.quote.isFavorite;
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? AppColors.heartRed : Colors.white,
                ),
                onPressed: state is QuoteLoaded
                    ? () {
                        context
                            .read<QuoteBloc>()
                            .add(FavoriteToggleRequested(state.quote.id));
                        context
                            .read<FavoritesBloc>()
                            .add(const FavoritesLoadRequested());
                      }
                    : null,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if (state is QuoteLoading || state is QuoteInitial) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            if (state is QuoteError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            final quote = (state as QuoteLoaded).quote;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Expanded(child: Center(child: HomeQuoteCard(quote: quote))),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => context
                          .read<QuoteBloc>()
                          .add(const NewQuoteRequested()),
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        'New Quote',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
