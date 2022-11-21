# Mobile Flutter Base

## Before you start
Before your start, you need to know about some basics technologies and skills:
- [Dart programing language](https://dart.dev/)
- [Flutter](https://docs.flutter.dev/get-started/install)
- [Bloc](https://bloclibrary.dev/#/gettingstarted)

## Configs
#### Config Enviroments
All enviroment configs will declare in 3 files: `assets/cfg/env_dev.json`, `assets/cfg/env_uat.json`, `assets/cfg/env_prod.json` .

If your project split in to more than or less than 3 Enviroments, you can remove or add new enviroment like `staging`, `sit`...

**assets/cfg/env_dev.json**
```json
{
  "api_url": "https://62fb900babd610251c0beb30.mockapi.io"
}
```

You should add some parameters for dev in json files.
Then get the value in runtime by some lines of code in `lib/configs/env_config.dart` like:

**lib/configs/env_config.dart**
```dart
String get apiUrl => GlobalConfigs().get('api_url');
```

Finally, If you want to switch to other enviroment for building a new build. Let's change code in `main()` function in `main.dart` file:

**lib/main.dart**
```dart
await AppConfig.instance.configApp(env: Env.dev);
```
#### AppTheme
Notice that almost every Default Flutter Widgets could be customized in ThemeData.
To change style for your common components like `primaryColor`, `TextField`, `Button`, `Checkbox`, `appBar`, `card`, `scaford`..., you can open theme_constants.dart and add more code into ThemeConstants Class.

For more infomation about How to style your app. 
- [https://docs.flutter.dev/cookbook/design/themes](https://docs.flutter.dev/cookbook/design/themes)
- [https://api.flutter.dev/flutter/material/ThemeData-class.html](https://api.flutter.dev/flutter/material/ThemeData-class.html)

## Application Architecture
In this project, we use the basic Architecture to emplement ***BloC***. We also use bloc for state management in our project.

![Bloc Architecture](https://i.ibb.co/B6NWxhj/Group-330.png)

**UI**
- Show UI for User and get Event from users.
- Rebuild UI when state changed.
- Sent Event to Bloc.
- Subscribe state changes from Bloc. If state change, UI will be rebuilded.

**Bloc**
- **Receive Events** from UI, **convert Events to new States**, then **emit** . If bloc emit new state, UI will be rebuilded.
- Includes Logic codes.
- Call to Data layer for getting data. Then convert data from data layer to State or use them for business logic.

**Data**
- Get remote data from API and local data from Local data base.
- Convert Raw data to Data Object, that can use for business logic at Bloc layer.

> Each layer have it own role in the Architecture. You shouldn't put some UI code in Bloc or putting logic code in UI layer. 
> Try to split codes for layers separately.
> More information for BloC. You can read more here: [https://bloclibrary.dev/#/gettingstarted](https://bloclibrary.dev/#/gettingstarted)

## GetIt and how to manage app instances
**What is GetIt?**
> This is a simple Service Locator for Dart and Flutter projects with some additional goodies highly.

For more infomation about GetIt. [https://pub.dev/packages/get_it](https://pub.dev/packages/get_it)

**Why we use GetIt in our project?**

Well, I simply use GetIt in project base for managing all instances in my project, such as: `external`, `datasource`, `bloc`, `page`...
GetIt will control all of instances in our project, allocate and release the memories when the instance was not used.
Beside that, We can easily call and use all instance everywhere by `Getit.Intance.get<ObjectType>()`

You should read some code in `lib/dependencies`
## Project Structure
When you open the project, you could see many folders and files. But, i think you should just focus on 2 folders when you start: `lib` and `packages/flutter_core`. Espectialy `lib` folders.

**lib**
Lib is default folder for your application codes. Almost every codes you need to code is inside lib folder.

**Lib folder includes:**
- **application**: Containts app Architecture. `presentation` layer, `bloc` layer, `datasource` layer.
All the infomation about 3 layers in app Architecture, I did show you in the previous section **Architecture**,You have to make sure that every code for each layer will be in right layer.
- **configs**: Containts application configs like: Enviroment config, UI config, Dependencies configs...
- **constants**: Containts many files to save constants in project. I think you should declare more and more constants, because that make your code and your resouce reusable and easy to read.
- **dependencies**: As I told before. We use GetIt to manage dependencies. Every codes for managing instances will put inside this folder.

**packages/flutter_core**
- This is a folder that i created in a package format.
- flutter_core containts all code that not relate to application logic and bussiness.
- If you are a member, i think you just read flutter_core for understanding more code and learn more about how to write some common code.
- If you are a tech lead, You will maintain the flutter_core package and sync code with company flutter_core package.

## Start your first feature
#### Datasource
1. **Add model class:**
- Add `employee.dart` in `lib/datasource/models` folder.
```dart
import 'package:flutter_core/flutter_core.dart';

class Employee extends Equatable {
  final String? name;
  final int? age;

  const Employee({this.name, this.age});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      age: json['age'],
    );
  }

  @override
  List<Object?> get props => [name, age];
}
```
2. **Add remote class:**
- Add `employee_remote.dart` in `lib/datasource/remotes` folder.
```dart
import 'package:flutter_core/flutter_core.dart';
import '../../../constants/constants.dart';
import '../models/models.dart';

class EmployeeRemote {
  final AppClient _appClient;

  EmployeeRemote(this._appClient);

  @override
  Future<Either<Failure, List<Employee>?>> getEmployees() async {
    final result = await _appClient.call(ApiConstants.getEmployees,
        method: RestfulMethod.get);

    return result.fold(
      (l) => Left(l),
      (r) {
        if (r is List) {
          return Right(r.map((e) => Employee.fromJson(e)).toList());
        }
        return const Right(null);
      },
    );
  }
}
```
- Add line of code inside `remotes/remotes.dart`:
```dart
export 'employee_remote.dart';
```
- Then add code inside `config` funcion in `data_remote_dependencies.dart`
```dart
injector.registerLazySingleton<EmployeeRemote>(
      () => EmployeeRemote(injector()),
    );
```

#### BloC
1. Create `employee` folder inside `lib/application/bloc` folder.
2. Create 3 files `employee_bloc.dart`, `employee_event.dart`, `employee_state.dart` into `employee` folder.
3. Add codes for each files like bellow:

**employee_bloc.dart**
```dart
import 'dart:async';
import 'package:flutter_core/flutter_core.dart';

import '../../datasource/datasources.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc(this._employeeRemote) : super(const EmployeeState()) {
    on<GetEmployeesEvent>(_onGetEmployees);
  }

  final EmployeeRemote _employeeRemote;

  Future<void> _onGetEmployees(
      GetEmployeesEvent event, Emitter<EmployeeState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _employeeRemote.getEmployees();

    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message),
      (r) => state.copyWith(employees: r),
    );
    emit(newState);
  }
}
```

**employee_event.dart**
```dart
part of 'employee_bloc.dart';

abstract class EmployeeEvent {}

class GetEmployeesEvent extends EmployeeEvent {}
```

**employee_state.dart**
```dart
part of 'employee_bloc.dart';

class EmployeeState extends Equatable {
  final List<Employee>? employees;
  final bool isLoading;
  final String? errMessage;

  const EmployeeState({
    this.employees,
    this.isLoading = false,
    this.errMessage,
  });

  EmployeeState copyWith({
    List<Employee>? employees,
    bool isLoading = false,
    String? errMessage,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      isLoading: isLoading,
      errMessage: errMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, employees, errMessage];
}
```
- Add line of code inside `bloc/blocs.dart`:
```dart
export 'employee/employee_bloc.dart';
```
4. Then add code inside `config` funcion in `bloc_dependencies.dart`
```dart
 injector.registerFactory<EmployeeBloc>(() => EmployeeBloc(injector()));
```

### Presentation
1. **Add pages**
- Add `employee_page.dart` inside `lib/application/presentation/pages` folder.
```dart

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../constants/constants.dart';
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
```
- Add line of code inside `pages/pages.dart`:
```dart
export 'employee_page.dart';
```
- Then add code inside `config` funcion in `page_dependencies.dart`
```dart
 injector.registerFactory<Widget>(
      () => const EmployeePage(),
      instanceName: RouteConstants.employee,
    );
```
2. **Widgets**
All common widgets will put into `presentation/widgets` folders.

## Code conventions
We use flutter_lints for checking conventions in combine time.
But i need you read more to make sure that your code is clear and in a same rules with others.
You can read some guides or rules about Dart - Flutter conventions here:
- [Dart conventions 1](https://dart.dev/guides/language/effective-dart/style)
- [Dart conventions 2](https://dart.dev/guides/language/effective-dart/design)
- [Flutter conventions 1](https://docs.flutter.dev/development/tools/formatting)
- [Lint rules](https://dart.dev/tools/linter-rules)
## CICD
#### Local CD
#### CICD with gitlab
