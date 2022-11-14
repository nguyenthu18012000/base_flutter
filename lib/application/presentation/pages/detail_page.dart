import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'dart:developer' as dev;

import '../../bloc/blocs.dart';
import '../../datasource/models/models.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold<DetailBloc>(
      title: const Text("Detail"),
      onReceiveArguments: (data, bloc) {
        if (data is Employee) {
          dev.log(data.name ?? '');
          dev.log(data.age.toString());
        }
      },
      body: const Center(
        child: Text("Detail page"),
      ),
    );
  }
}
