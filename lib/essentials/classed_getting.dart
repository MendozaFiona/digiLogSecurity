import 'package:digi_logsec/essentials/small_widgets.dart';
import 'package:digi_logsec/json_models/get_visitor.dart';
import 'package:digi_logsec/services/visits_service.dart';
import 'package:flutter/material.dart';
import 'package:digi_logsec/main.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class RetrieveVisit extends StatefulWidget {
  @override
  RetrieveVisitState createState() {
    return RetrieveVisitState();
  }
}

class RetrieveVisitState extends State<RetrieveVisit> {
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
    var smallWidgets = SmallWidgets(context);

    return Center(
        child: FutureBuilder<EntryInfo>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                visitData['id'] = snapshot.data.id;
                visitData['name'] = snapshot.data.name;

                print(snapshot.data);

                return Column(
                  children: [
                    smallWidgets.visitTile(visitData['name'], visitData['id']),
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
