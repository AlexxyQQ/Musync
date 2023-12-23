import 'dart:convert';

import 'package:musync/core/failure/error_handler.dart';

class LibraryState {
  final bool isLoading;
  final bool isSuccess;
  final AppErrorHandler? error;
  final String? category;
  final List<String> categories;
  LibraryState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.category,
    required this.categories,
  });

  factory LibraryState.initial() {
    return LibraryState(
      isLoading: false,
      isSuccess: false,
      error: null,
      category: "Songs",
      categories: const [
        "Songs",
        "Artists",
        "Albums",
        "For You",
      ],
    );
  }

  LibraryState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AppErrorHandler? error,
    String? category,
    List<String>? categories,
  }) {
    return LibraryState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      category: category ?? this.category,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
      'isSuccess': isSuccess,
      'error': error?.toMap(),
      'category': category,
      'categories': categories,
    };
  }

  factory LibraryState.fromMap(Map<String, dynamic> map) {
    return LibraryState(
      isLoading: map['isLoading'] as bool,
      isSuccess: map['isSuccess'] as bool,
      error: map['error'] != null
          ? AppErrorHandler.fromMap(map['error'] as Map<String, dynamic>)
          : null,
      category: map['category'] != null ? map['category'] as String : null,
      categories: List<String>.from(
        (map['categories'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LibraryState.fromJson(String source) =>
      LibraryState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LibraryState(isLoading: $isLoading, isSuccess: $isSuccess, error: $error, category: $category, categories: $categories)';
  }
}
