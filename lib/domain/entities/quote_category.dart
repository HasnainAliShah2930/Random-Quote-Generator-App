import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// Domain entity representing a quote category (Motivation, Success, ...).
class QuoteCategory extends Equatable {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final int quoteCount;

  const QuoteCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.quoteCount,
  });

  @override
  List<Object?> get props => [id, name, icon, color, quoteCount];
}
