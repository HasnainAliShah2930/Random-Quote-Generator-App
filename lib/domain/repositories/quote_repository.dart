import '../entities/quote.dart';
import '../entities/quote_category.dart';

/// Defines the contract the domain layer relies on. The presentation layer
/// (BLoCs) only ever depends on this abstraction — never on the concrete
/// data-layer implementation — which keeps the architecture testable and
/// swappable (e.g. local mock data today, a REST/Firebase source later).
abstract class QuoteRepository {
  List<Quote> getAllQuotes();

  /// Returns a random quote, optionally scoped to [categoryId] and
  /// optionally avoiding [excludeId] (so "New Quote" doesn't repeat).
  Quote getRandomQuote({String? categoryId, String? excludeId});

  List<Quote> getQuotesByCategory(String categoryId);

  List<Quote> getFavoriteQuotes();

  List<QuoteCategory> getCategories();

  QuoteCategory getCategoryById(String categoryId);

  /// Toggles favorite status for [quoteId] and returns the new value.
  bool toggleFavorite(String quoteId);
}
