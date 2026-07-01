import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/quote.dart';
import '../../../domain/repositories/quote_repository.dart';

// ───────────────────────── Events ─────────────────────────

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

class FavoritesLoadRequested extends FavoritesEvent {
  const FavoritesLoadRequested();
}

class FavoritesRemoveRequested extends FavoritesEvent {
  final String quoteId;
  const FavoritesRemoveRequested(this.quoteId);
  @override
  List<Object?> get props => [quoteId];
}

// ───────────────────────── States ─────────────────────────

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object?> get props => [];
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<Quote> quotes;
  const FavoritesLoaded(this.quotes);
  @override
  List<Object?> get props => [quotes];
}

// ───────────────────────── Bloc ─────────────────────────

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final QuoteRepository repository;

  FavoritesBloc({required this.repository}) : super(const FavoritesLoading()) {
    on<FavoritesLoadRequested>((event, emit) {
      emit(FavoritesLoaded(repository.getFavoriteQuotes()));
    });

    on<FavoritesRemoveRequested>((event, emit) {
      repository.toggleFavorite(event.quoteId);
      emit(FavoritesLoaded(repository.getFavoriteQuotes()));
    });
  }
}
