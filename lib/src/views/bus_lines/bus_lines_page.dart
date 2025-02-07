import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ybt_user/config/constants/app_constants.dart';
import 'package:ybt_user/src/controllers/app_data_controller.dart';

class BusLinesPage extends StatefulWidget {
  const BusLinesPage({super.key});

  @override
  State<BusLinesPage> createState() => _BusLinesPageState();
}

class _BusLinesPageState extends State<BusLinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Lines"),
        centerTitle: false,
      ),
      body: SizedBox.expand(
        child: GetBuilder<AppDataController>(
          builder: (appDataController) {
            final allBusLines = appDataController.allBusLines;
            if (allBusLines.isEmpty) {
              return const Center(
                child: Text("No Bus Line Yet!"),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.basePadding,
                    vertical: AppConstants.basePadding),
                itemCount: allBusLines.length,
                itemBuilder: (context, index) {
                  final each = allBusLines[index];
                  return ListTile(
                    title: Text(each.name),
                    subtitle: Text("Total Stops - ${each.busStopIds.length}"),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
