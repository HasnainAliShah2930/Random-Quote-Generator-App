import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/repositories/quote_repository.dart';
import '../../bloc/category_detail/category_detail_bloc.dart';
import '../../bloc/favorites/favorites_bloc.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryId;
  const CategoryDetailScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryDetailBloc(repository: context.read<QuoteRepository>())
            ..add(CategoryDetailLoadRequested(categoryId)),
      child: const _CategoryDetailView(),
    );
  }
}

class _CategoryDetailView extends StatelessWidget {
  const _CategoryDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
        builder: (context, state) {
          if (state is CategoryDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final loaded = state as CategoryDetailLoaded;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                title: Text(loaded.category.name),
                centerTitle: true,
              ),
              if (loaded.quotes.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text('No quotes in this category yet.')),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final quote = loaded.quotes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        quote.text,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          height: 1.3,
                                          color: Theme.of(context).textTheme.bodyLarge?.color,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        quote.author,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    quote.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: quote.isFavorite
                                        ? AppColors.heartRed
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    context.read<CategoryDetailBloc>().add(
                                        CategoryDetailFavoriteToggled(
                                            quote.id));
                                    context
                                        .read<FavoritesBloc>()
                                        .add(const FavoritesLoadRequested());
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: loaded.quotes.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
