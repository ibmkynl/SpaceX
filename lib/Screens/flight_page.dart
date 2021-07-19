import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/Bloc/bloc.dart';
import 'package:spacex/Models/flight_model.dart';
import 'package:spacex/Widgets/desc_widget.dart';
import 'package:spacex/Widgets/photo_widget.dart';
import 'package:spacex/Widgets/video_widget.dart';

class FlightPage extends StatefulWidget {
  @override
  _FlightPageState createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> {
  FlightBloc _flightBloc;

  @override
  void initState() {
    _flightBloc = FlightBloc();
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
        body: BlocBuilder(
          bloc: _flightBloc,
          builder: (context, state) {
            if (state is FlightInitialState) {
              _flightBloc.add(InitializeFlight());
            }
            if (state is FlightLoadingState) {
              return LinearProgressIndicator();
            } else if (state is FlightLoadedState) {
              FlightModel _flightModel = state.flightModel;
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
            } else if (state is FlightErrorState) {
              return Center(
                child: TextButton(
                  onPressed: () async {
                    _flightBloc.add(RetryEvent());
                  },
                  child: Text(state.errorMsg),
                ),
              );
            }
            return Container();
          },
        ));
  }
}
