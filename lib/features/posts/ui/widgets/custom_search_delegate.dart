import 'package:flutter/material.dart';

import '../../data/models/post_model.dart';

class CustomSearchDelegate extends SearchDelegate<PostModel?> {
  final List<PostModel> searchList;

  CustomSearchDelegate({required this.searchList});

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? searchList
        : searchList
            .where((s) => s.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(suggestions[i].title),
        onTap: () {
          query = suggestions[i].title;
          showResults(context);
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = searchList
        .where((s) => s.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(results[i].title),
        subtitle: Text(results[i].body),
        onTap: () => close(context, results[i]),
      ),
    );
  }
}
