import 'package:digi_logsec/json_models/get_visitor.dart';
import 'package:digi_logsec/services/visits_service.dart';
import 'package:flutter/material.dart';
import 'package:digi_logsec/main.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class DiscoverBody extends StatefulWidget {
  @override
  DiscoverBodyState createState() {
    return DiscoverBodyState();
  }
}

class DiscoverBodyState extends State<DiscoverBody> {
//NEED TO REFRESH
  Future<EntryInfo> futureData;

  var visitData = Map();

  @override
  void initState() {
    super.initState();
    futureData = getEntry();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<EntryInfo>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                visitData['id'] = snapshot.data.id;
                visitData['name'] = snapshot.data.name;

                return Column(
                  children: [
                    /*TitleBox(defaultTitle: visitData['id']),
                    DiscoverEntry(
                      visitData: visitData,
                    ),*/ // should be one entry only (refer to container made before)
                    SizedBox(height: 10.0),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.data == null) {
                return Center(
                    child: Text('No entry available to display yet.'));
              }

              return Center(child: CircularProgressIndicator());
            }));
  } // build

}

class VisitSearch extends OngoingVisits {
  @override
  _VisitSearchState createState() => _VisitSearchState();
}

class _VisitSearchState extends OngoingVisitsState {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: EdgeInsets.only(top: 15),
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
