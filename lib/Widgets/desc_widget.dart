import 'package:flutter/material.dart';
import 'package:spacex/Models/flight_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionWidget extends StatelessWidget {
  final FlightModel flightModel;

  DescriptionWidget({this.flightModel});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(_size.width / 24),
      child: Container(
        padding: EdgeInsets.all(_size.width / 12),
        decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(_size.width / 30)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: _size.width / 3.5,
                    height: _size.width / 3.5,
                    child: Image.network(flightModel.links.patch.large)),
                SizedBox(
                  width: _size.width / 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flightModel.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(
                              flightModel.dateUnix * 1000)
                          .toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          "Success: ",
                          style: TextStyle(color: Colors.white),
                        ),
                        flightModel.success
                            ? Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : Icon(Icons.clear_rounded, color: Colors.white),
                      ],
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (await canLaunch(flightModel.links.reddit.launch))
                            await launch(flightModel.links.reddit.launch);
                          else
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Something goes wrong.."),
                            ));
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.circular(_size.width / 30)),
                            child: Text(
                              "View on Reddit",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                )
              ],
            ),
            SizedBox(
              height: _size.height / 50,
            ),
            Text(
              flightModel.details,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
