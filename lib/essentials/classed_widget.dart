import 'package:flutter/material.dart';
import 'package:digi_logsec/main.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class VisitSearch extends OngoingVisits {
  @override
  _VisitSearchState createState() => _VisitSearchState();
}

class _VisitSearchState extends OngoingVisitsState {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingSearchBar(
        controller: visitSearchController,
        hint: 'Search',
        onSubmitted: (query) {
          setState(() {
            selectedTerm = query;
          });
          visitSearchController.close();
        },
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
                color: Colors.white,
                elevation: 4.0,
                child: Builder(builder: (context) {
                  return Column(mainAxisSize: MainAxisSize.min, children: []);
                })),
          );
        },
      ),
    );
  }
}
