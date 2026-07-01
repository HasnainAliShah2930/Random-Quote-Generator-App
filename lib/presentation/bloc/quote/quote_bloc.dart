import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/quote.dart';
import '../../../domain/repositories/quote_repository.dart';

// ───────────────────────── Events ─────────────────────────

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();
  @override
  List<Object?> get props => [];
}

/// Fired once when the Home screen first mounts.
class LoadRandomQuoteRequested extends QuoteEvent {
  const LoadRandomQuoteRequested();
}

/// Fired when the user taps "New Quote".
class NewQuoteRequested extends QuoteEvent {
  const NewQuoteRequested();
}

/// Fired when the user taps the heart icon in the app bar.
class FavoriteToggleRequested extends QuoteEvent {
  final String quoteId;
  const FavoriteToggleRequested(this.quoteId);
  @override
  List<Object?> get props => [quoteId];
}

// ───────────────────────── States ─────────────────────────

abstract class QuoteState extends Equatable {
  const QuoteState();
  @override
  List<Object?> get props => [];
}

class QuoteInitial extends QuoteState {
  const QuoteInitial();
}

class QuoteLoading extends QuoteState {
  const QuoteLoading();
}

class QuoteLoaded extends QuoteState {
  final Quote quote;
  const QuoteLoaded(this.quote);
  @override
  List<Object?> get props => [quote];
}

class QuoteError extends QuoteState {
  final String message;
  const QuoteError(this.message);
  @override
  List<Object?> get props => [message];
}

// ───────────────────────── Bloc ─────────────────────────

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository repository;

  QuoteBloc({required this.repository}) : super(const QuoteInitial()) {
    on<LoadRandomQuoteRequested>(_onLoadRandomQuote);
    on<NewQuoteRequested>(_onNewQuote);
    on<FavoriteToggleRequested>(_onFavoriteToggle);
  }

  void _onLoadRandomQuote(
    LoadRandomQuoteRequested event,
    Emitter<QuoteState> emit,
  ) {
    emit(const QuoteLoading());
    try {
      emit(QuoteLoaded(repository.getRandomQuote()));
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }

  void _onNewQuote(NewQuoteRequested event, Emitter<QuoteState> emit) {
    final current = state;
    final excludeId = current is QuoteLoaded ? current.quote.id : null;
    try {
      emit(QuoteLoaded(repository.getRandomQuote(excludeId: excludeId)));
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }

  void _onFavoriteToggle(
    FavoriteToggleRequested event,
    Emitter<QuoteState> emit,
  ) {
    final isFav = repository.toggleFavorite(event.quoteId);
    final current = state;
    if (current is QuoteLoaded && current.quote.id == event.quoteId) {
      emit(QuoteLoaded(current.quote.copyWith(isFavorite: isFav)));
    }
  }
}
