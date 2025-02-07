import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ybt_user/config/constants/app_functions.dart';
import 'package:ybt_user/config/constants/app_svgs.dart';
import 'package:ybt_user/config/route/route_names.dart';
import 'package:ybt_user/src/views/home/home_page.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.6,
      height: Get.height,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: Column(
            children: [
              ...[
                [AppSvgs.busIcon, "Bus Lines", RouteNames.allBusLinesPage],
                [AppSvgs.busStopIcon, "Bus Stops", RouteNames.allBusStopsPage],
              ].map((each) {
                final icon = each[0];
                final label = each[1];
                final route = each[2];
                return ListTile(
                  onTap: () {
                    Get.toNamed(route);
                  },
                  leading: AppFunctions.getSvgIcon(
                      svgData: icon,
                      color: Theme.of(context).colorScheme.onPrimary),
                  title: Text(
                    label,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                );
              })
            ],
          )),
    );
  }
}
