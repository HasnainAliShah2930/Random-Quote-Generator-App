import 'package:flutter/material.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/quote_category.dart';

/// In-memory data source. Owns the seed data and is the single mutable
/// source of truth for favorite status. Swap this class out for a
/// REST/SQLite/Firebase data source later without touching the domain
/// or presentation layers.
class QuoteLocalDataSource {
  static const List<QuoteCategory> _categories = [
    QuoteCategory(
      id: 'motivation',
      name: 'Motivation',
      icon: Icons.terrain,
      color: Color(0xFF22C55E),
      quoteCount: 4,
    ),
    QuoteCategory(
      id: 'success',
      name: 'Success',
      icon: Icons.emoji_events,
      color: Color(0xFFF59E0B),
      quoteCount: 2,
    ),
    QuoteCategory(
      id: 'life',
      name: 'Life',
      icon: Icons.eco,
      color: Color(0xFF3B82F6),
      quoteCount: 2,
    ),
    QuoteCategory(
      id: 'happiness',
      name: 'Happiness',
      icon: Icons.sentiment_satisfied_alt,
      color: Color(0xFFEC4899),
      quoteCount: 1,
    ),
    QuoteCategory(
      id: 'love',
      name: 'Love',
      icon: Icons.favorite,
      color: Color(0xFFEF4444),
      quoteCount: 2,
    ),
    QuoteCategory(
      id: 'inspiration',
      name: 'Inspiration',
      icon: Icons.auto_awesome,
      color: Color(0xFF8B5CF6),
      quoteCount: 3,
    ),
    QuoteCategory(
      id: 'wisdom',
      name: 'Wisdom',
      icon: Icons.menu_book,
      color: Color(0xFF14B8A6),
      quoteCount: 2,
    ),
  ];

  final List<Quote> _quotes = [
    const Quote(
      id: 'q1',
      text: 'The only way to do great work is to love what you do.',
      author: 'Steve Jobs',
      categoryId: 'motivation',
    ),
    const Quote(
      id: 'q2',
      text: "Your time is limited, don't waste it living someone else's life.",
      author: 'Steve Jobs',
      categoryId: 'motivation',
    ),
    const Quote(
      id: 'q3',
      text: "Believe you can and you're halfway there.",
      author: 'Theodore Roosevelt',
      categoryId: 'motivation',
      isFavorite: true,
    ),
    const Quote(
      id: 'q4',
      text: 'The future belongs to those who believe in the beauty of their dreams.',
      author: 'Eleanor Roosevelt',
      categoryId: 'motivation',
      isFavorite: true,
    ),
    const Quote(
      id: 'q5',
      text: "It always seems impossible until it's done.",
      author: 'Nelson Mandela',
      categoryId: 'success',
      isFavorite: true,
    ),
    const Quote(
      id: 'q6',
      text: 'Success is not final, failure is not fatal: It is the courage to continue that counts.',
      author: 'Winston Churchill',
      categoryId: 'success',
      isFavorite: true,
    ),
    const Quote(
      id: 'q7',
      text: "Life is what happens when you're busy making other plans.",
      author: 'John Lennon',
      categoryId: 'life',
    ),
    const Quote(
      id: 'q8',
      text: "In the end, it's not the years in your life that count. It's the life in your years.",
      author: 'Abraham Lincoln',
      categoryId: 'life',
    ),
    const Quote(
      id: 'q9',
      text: 'Happiness is not something ready made. It comes from your own actions.',
      author: 'Dalai Lama',
      categoryId: 'happiness',
    ),
    const Quote(
      id: 'q10',
      text: 'The most important thing in life is to learn how to give out love, and let it come in.',
      author: 'Morrie Schwartz',
      categoryId: 'love',
    ),
    const Quote(
      id: 'q11',
      text: 'Where there is love there is life.',
      author: 'Mahatma Gandhi',
      categoryId: 'love',
    ),
    const Quote(
      id: 'q12',
      text: 'Wisdom begins in wonder.',
      author: 'Socrates',
      categoryId: 'wisdom',
    ),
    const Quote(
      id: 'q13',
      text: 'The only true wisdom is in knowing you know nothing.',
      author: 'Socrates',
      categoryId: 'wisdom',
    ),
    const Quote(
      id: 'q14',
      text: 'Act as if what you do makes a difference. It does.',
      author: 'William James',
      categoryId: 'inspiration',
    ),
    const Quote(
      id: 'q15',
      text: 'Dream big and dare to fail.',
      author: 'Norman Vaughan',
      categoryId: 'inspiration',
    ),
  ];

  List<Quote> getAllQuotes() => List.unmodifiable(_quotes);

  List<QuoteCategory> getCategories() => List.unmodifiable(_categories);

  QuoteCategory getCategoryById(String id) => _categories.firstWhere(
        (c) => c.id == id,
        orElse: () => _categories.first,
      );

  /// Mutates the seed list in place and returns the new favorite value.
  bool toggleFavorite(String quoteId) {
    final index = _quotes.indexWhere((q) => q.id == quoteId);
    if (index == -1) return false;
    final updated = _quotes[index].copyWith(
      isFavorite: !_quotes[index].isFavorite,
    );
    _quotes[index] = updated;
    return updated.isFavorite;
  }
}
