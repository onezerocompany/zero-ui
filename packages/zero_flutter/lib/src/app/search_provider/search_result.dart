import 'package:flutter/material.dart';

enum OmniSearchObject {
  page,
  action,
  externalLink,
}

@immutable
class SearchResult {
  const SearchResult({
    this.score = 0,
    required this.title,
    this.excerpt,
    this.icon,
    this.url,
    this.inPressed,
  });

  final double score;

  final String title;
  final String? excerpt;
  final IconData? icon;

  final String? url;
  final VoidCallback? inPressed;
}
