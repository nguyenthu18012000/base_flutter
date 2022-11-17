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
All the infomation about 3 layers in app Architecture, I did show you in the previous section **Architecture**,
You have to make sure that every code for each layer will be in right layer.
- **configs**: Containts application configs like: Enviroment config, UI config, Dependencies configs...
  
- **constants**: Containts many files to save constants in project. I think you should declare more and more constants, because that make your code and your resouce reusable and easy to read.
- **dependencies**: As I told before. We use GetIt to manage dependencies. Every codes for managing instances will put inside this folder.



## Start your first feature
## Code conventions

## flutter_core
## CICD
