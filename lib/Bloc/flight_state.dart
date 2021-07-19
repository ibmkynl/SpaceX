import 'package:equatable/equatable.dart';
import 'package:spacex/Models/flight_model.dart';

abstract class FlightState extends Equatable {
  const FlightState();
  List<Object> get props => [];
}

class FlightInitialState extends FlightState {
  List<Object> get props => [];
}

class FlightLoadingState extends FlightState {
  List<Object> get props => [];
}

class FlightLoadedState extends FlightState {
  final FlightModel flightModel;

  FlightLoadedState({this.flightModel});

  List<Object> get props => [flightModel];
}

class FlightErrorState extends FlightState {
  final String errorMsg;

  FlightErrorState({this.errorMsg});

  List<Object> get props => [errorMsg];
}
