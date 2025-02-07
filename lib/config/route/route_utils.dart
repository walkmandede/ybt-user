import 'package:flutter/material.dart';
import 'package:ybt_user/src/views/bus_lines/bus_lines_page.dart';
import 'package:ybt_user/src/views/bus_stops/bus_stops_page.dart';
import 'package:ybt_user/src/views/home/home_page.dart';
import 'route_names.dart';

class RouteUtils {
  final routes = {
    RouteNames.homePage: (context) {
      return const HomePage();
    },
    RouteNames.allBusLinesPage: (context) {
      return const BusLinesPage();
    },
    RouteNames.allBusStopsPage: (context) {
      return const BusStopsPage();
    },
  };
}
