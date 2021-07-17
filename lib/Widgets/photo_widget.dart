import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spacex/Models/flight_model.dart';

class PhotoWidget extends StatelessWidget {
  final FlightModel flightModel;

  PhotoWidget({this.flightModel});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(_size.width / 24),
      child: CarouselSlider(
        items: flightModel.links.flickr.original
            .map((e) => Image.network(e))
            .toList(),
        options: CarouselOptions(
          height: _size.height / 3,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          // autoPlay: false,
        ),
      ),
    );
  }
}
