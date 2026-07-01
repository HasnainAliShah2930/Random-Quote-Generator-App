import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/quote.dart';
import '../../../domain/entities/quote_category.dart';
import '../../../domain/repositories/quote_repository.dart';

// ───────────────────────── Events ─────────────────────────

abstract class CategoryDetailEvent extends Equatable {
  const CategoryDetailEvent();
  @override
  List<Object?> get props => [];
}

class CategoryDetailLoadRequested extends CategoryDetailEvent {
  final String categoryId;
  const CategoryDetailLoadRequested(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}

class CategoryDetailFavoriteToggled extends CategoryDetailEvent {
  final String quoteId;
  const CategoryDetailFavoriteToggled(this.quoteId);
  @override
  List<Object?> get props => [quoteId];
}

// ───────────────────────── States ─────────────────────────

abstract class CategoryDetailState extends Equatable {
  const CategoryDetailState();
  @override
  List<Object?> get props => [];
}

class CategoryDetailLoading extends CategoryDetailState {
  const CategoryDetailLoading();
}

class CategoryDetailLoaded extends CategoryDetailState {
  final QuoteCategory category;
  final List<Quote> quotes;
  const CategoryDetailLoaded({required this.category, required this.quotes});
  @override
  List<Object?> get props => [category, quotes];
}

// ───────────────────────── Bloc ─────────────────────────

class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final QuoteRepository repository;

  CategoryDetailBloc({required this.repository})
      : super(const CategoryDetailLoading()) {
    on<CategoryDetailLoadRequested>(_onLoad);
    on<CategoryDetailFavoriteToggled>(_onToggle);
  }

  void _onLoad(
    CategoryDetailLoadRequested event,
    Emitter<CategoryDetailState> emit,
  ) {
    emit(const CategoryDetailLoading());
    final category = repository.getCategoryById(event.categoryId);
    final quotes = repository.getQuotesByCategory(event.categoryId);
    emit(CategoryDetailLoaded(category: category, quotes: quotes));
  }

  void _onToggle(
    CategoryDetailFavoriteToggled event,
    Emitter<CategoryDetailState> emit,
  ) {
    repository.toggleFavorite(event.quoteId);
    final current = state;
    if (current is CategoryDetailLoaded) {
      emit(CategoryDetailLoaded(
        category: current.category,
        quotes: repository.getQuotesByCategory(current.category.id),
      ));
    }
  }
}
