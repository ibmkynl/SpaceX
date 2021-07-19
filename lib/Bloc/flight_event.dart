import 'package:equatable/equatable.dart';

abstract class FlightEvent extends Equatable {
  const FlightEvent();

  List<Object> get props => [];
}

class InitializeFlight extends FlightEvent {
  const InitializeFlight();
  List<Object> get props => [];
}

class RetryEvent extends FlightEvent {
  const RetryEvent();
  List<Object> get props => [];
}
