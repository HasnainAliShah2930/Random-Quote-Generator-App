import 'package:equatable/equatable.dart';

/// Core domain entity representing a single quote.
/// Immutable by design — state changes always go through [copyWith].
class Quote extends Equatable {
  final String id;
  final String text;
  final String author;
  final String categoryId;
  final bool isFavorite;

  const Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.categoryId,
    this.isFavorite = false,
  });

  Quote copyWith({
    String? id,
    String? text,
    String? author,
    String? categoryId,
    bool? isFavorite,
  }) {
    return Quote(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      categoryId: categoryId ?? this.categoryId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, text, author, categoryId, isFavorite];
}
