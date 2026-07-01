import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/quote_category.dart';
import '../../../domain/repositories/quote_repository.dart';

// ───────────────────────── Events ─────────────────────────

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
  @override
  List<Object?> get props => [];
}

class CategoriesLoadRequested extends CategoriesEvent {
  const CategoriesLoadRequested();
}

// ───────────────────────── States ─────────────────────────

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object?> get props => [];
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesLoaded extends CategoriesState {
  final List<QuoteCategory> categories;
  const CategoriesLoaded(this.categories);
  @override
  List<Object?> get props => [categories];
}

// ───────────────────────── Bloc ─────────────────────────

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final QuoteRepository repository;

  CategoriesBloc({required this.repository})
      : super(const CategoriesLoading()) {
    on<CategoriesLoadRequested>((event, emit) {
      emit(CategoriesLoaded(repository.getCategories()));
    });
  }
}
