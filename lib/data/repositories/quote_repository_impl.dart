import 'dart:math';
import '../../domain/entities/quote.dart';
import '../../domain/entities/quote_category.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/quote_local_data_source.dart';

/// Concrete implementation of [QuoteRepository], backed by
/// [QuoteLocalDataSource]. This is the only class that knows where data
/// actually comes from — everything above it talks in domain entities.
class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteLocalDataSource localDataSource;
  final Random _random;

  QuoteRepositoryImpl({required this.localDataSource, Random? random})
      : _random = random ?? Random();

  @override
  List<Quote> getAllQuotes() => localDataSource.getAllQuotes();

  @override
  Quote getRandomQuote({String? categoryId, String? excludeId}) {
    var pool = categoryId == null
        ? getAllQuotes()
        : getQuotesByCategory(categoryId);
    if (pool.isEmpty) pool = getAllQuotes();

    if (pool.length > 1 && excludeId != null) {
      final withoutCurrent = pool.where((q) => q.id != excludeId).toList();
      if (withoutCurrent.isNotEmpty) pool = withoutCurrent;
    }

    return pool[_random.nextInt(pool.length)];
  }

  @override
  List<Quote> getQuotesByCategory(String categoryId) =>
      getAllQuotes().where((q) => q.categoryId == categoryId).toList();

  @override
  List<Quote> getFavoriteQuotes() =>
      getAllQuotes().where((q) => q.isFavorite).toList();

  @override
  List<QuoteCategory> getCategories() => localDataSource.getCategories();

  @override
  QuoteCategory getCategoryById(String categoryId) =>
      localDataSource.getCategoryById(categoryId);

  @override
  bool toggleFavorite(String quoteId) =>
      localDataSource.toggleFavorite(quoteId);
}
