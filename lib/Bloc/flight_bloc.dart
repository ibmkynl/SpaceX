import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/Models/flight_model.dart';
import 'package:spacex/Repo/flight_repo.dart';
import 'bloc.dart';

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  FlightRepo _flightRepo = FlightRepo();

  FlightBloc() : super(FlightInitialState());

  Stream<FlightState> mapEventToState(FlightEvent event) async* {
    print(event);
    if (event is InitializeFlight || event is RetryEvent) {
      yield FlightLoadingState();
      try {
        FlightModel flightModel = await _flightRepo.getFlightData();
        if (flightModel != null) {
          yield FlightLoadedState(flightModel: flightModel);
        } else {
          yield FlightErrorState(errorMsg: "Something goes wrong.. Try again");
        }
      } catch (error) {
        print(error);
        yield FlightErrorState(errorMsg: "Something goes wrong.. Try again");
      }
    }
  }
}
