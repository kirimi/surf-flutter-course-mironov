import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/network_client/network_client.dart';
import 'package:places/model/photo/preformers.dart';
import 'package:places/model/repository/sight_repository.dart';
import 'package:places/model/sights/performers.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_wm.dart';
import 'package:provider/provider.dart';

class AddSightScreenRoute extends MaterialPageRoute {
  AddSightScreenRoute()
      : super(
          builder: (context) => const AddSightScreen(wmBuilder: _wmBuilder),
        );
}

// Билдер для WidgetModel
WidgetModel _wmBuilder(BuildContext context) {
  return AddScreenWm(
    context.read<WidgetModelDependencies>(),
    Model([
      AddNewSightPerformer(context.read<SightRepository>()),
      UploadPhotosPerformer(context.read<NetworkClient>()),
    ]),
    navigator: Navigator.of(context),
  );
}
