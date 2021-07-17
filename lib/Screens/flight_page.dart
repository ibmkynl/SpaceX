import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacex/Models/flight_model.dart';
import 'package:spacex/Repo/flight_repo.dart';
import 'package:spacex/Widgets/desc_widget.dart';
import 'package:spacex/Widgets/photo_widget.dart';
import 'package:spacex/Widgets/video_widget.dart';

class FlightPage extends StatefulWidget {
  @override
  _FlightPageState createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> {
  FlightRepo _flightRepo = FlightRepo();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Space X"),
        centerTitle: true,
      ),
      body: Container(
          child: FutureBuilder(
        future: _flightRepo.getFlightData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.done) {
            return LinearProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: TextButton(
                child: Text("Something goes wrong.. Retry"),
                onPressed: () {
                  setState(() {});
                },
              ),
            );
          } else if (snapshot.data.runtimeType == bool) {
            //if snapshot.data return true than error text will shown.
            return Center(
              child: TextButton(
                child: Text("Something goes wrong.. Retry"),
                onPressed: () {
                  setState(() {});
                },
              ),
            );
          }
          FlightModel _flightModel = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              color: Colors.black45,
              child: Column(
                children: [
                  DescriptionWidget(flightModel: _flightModel),
                  _flightModel.links.youtubeId != null
                      ? VideoWidget(flightModel: _flightModel)
                      : Container(),
                  _flightModel.links.flickr.original.isNotEmpty
                      ? PhotoWidget(flightModel: _flightModel)
                      : Container()
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
