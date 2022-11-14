import 'package:base_bloc_flutter/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../bloc/blocs.dart';
import '../widgets/widgets.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold<EmployeeBloc>(
      title: const Text('Employee List'),
      onLoadData: (bloc) => bloc?.add(GetEmployeesEvent()),
      body: const EmployeeListener(),
    );
  }
}

class EmployeeListener extends StatelessWidget {
  const EmployeeListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeBloc, EmployeeState>(
      listenWhen: (previous, current) {
        return current.errMessage != null ||
            previous.isLoading != current.isLoading;
      },
      listener: (context, state) {
        if (state.isLoading) {
          UIHelper.showLoading();
        } else {
          UIHelper.hideLoading();
        }
        if (state.errMessage != null) {
          UIHelper.showSnackBar(context, msg: state.errMessage);
        }
      },
      child: const EmployeeListWidget(),
    );
  }
}

class EmployeeListWidget extends StatelessWidget {
  const EmployeeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      buildWhen: (previous, current) {
        return previous.employees != current.employees;
      },
      builder: (context, state) {
        final employees = state.employees;
        return ListView.builder(
          itemCount: employees?.length ?? 0,
          itemBuilder: (context, index) {
            final item = employees?[index];
            return InkWell(
                onTap: (() {
                  Navigator.of(context)
                      .pushNamed(RouteConstants.detail, arguments: item);
                }),
                child: EmployeeItem(item: item));
          },
        );
      },
    );
  }
}
