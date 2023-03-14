import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../constants/constants.dart';
import '../../../utils/utils.dart';
import '../../bloc/blocs.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const core.AppScaffold<LoginBloc>(
        body: LoginListener()
    );
  }
}

class LoginListener extends StatelessWidget {
  const LoginListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) {
          return current.errMessage != null ||
          previous.isLoading != current.isLoading ||
          current.isSuccess;
      },
      listener: (context, state) {
        if (state.isLoading) {
          core.UIHelper.showLoading();
        } else {
          core.UIHelper.hideLoading();
        }
        if (state.errMessage != null) {
          DialogService.errorDialog(
            context,
            title: 'error'.tr(),
            message: state.errMessage,
          );
        }
        if (state.isSuccess) {
          core.UIHelper.showSnackBar(context, msg: 'success'.tr());
        }
      },
      child: const LoginView(),
    );
  }
}


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formLoginKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LogoWidget(),
          UIConstants.verticalSpace24,
          const Center(
            child: Text(
                "Login to your account",
                style: ThemeConstants.textTitleStyle
            ),
          ),
          UIConstants.verticalSpace24,
          LoginInputForm(
            formLoginKey: formLoginKey,
            email: email,
            password: password,
          ),
          UIConstants.verticalSpace10,
          const RememberCheckboxWidget(),
          UIConstants.verticalSpace10,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              padding: const EdgeInsets.symmetric(vertical: 15)
            ),
            onPressed: () {
              formLoginKey.currentState!.validate();
              context.read<LoginBloc>().add(
                LoginButtonPressed(
                  email: email.text,
                  password: password.text
                )
              );
            },
            child: const Text(
              "Sign in",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18
              ),
            )
          ),
          UIConstants.verticalSpace16,
          const ForgotPasswordWidget(),
          UIConstants.verticalSpace24,
          const OtherLoginTitleWidget(),
          UIConstants.verticalSpace24,
          const OtherLoginMethodWidget(),
          UIConstants.verticalSpace10,
          const SignUpWidget()
        ],
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Image.asset(
        ImageHelper.getImage("logo"),
      ),
    );
  }
}

class LoginInputForm extends StatefulWidget {
  final GlobalKey<FormState> formLoginKey;
  final TextEditingController email;
  final TextEditingController password;

  const LoginInputForm({
    super.key,
    required this.formLoginKey,
    required this.email,
    required this.password
  });

  @override
  State<LoginInputForm> createState() => _LoginInputFormState();
}

class _LoginInputFormState extends State<LoginInputForm> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formLoginKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: widget.email,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(
                Icons.email_rounded,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: ColorConstants.inputColor,
              focusColor: Colors.black,
              enabledBorder: ThemeConstants.inputBorder,
              focusedBorder: ThemeConstants.inputBorder,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)){
                return 'Email error';
              }
              return null;
            },
          ),
          UIConstants.verticalSpace16,
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: widget.password,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: const Icon(
                Icons.lock_rounded,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  icon: _hidePassword
                    ? const Icon(
                        Icons.visibility_off_rounded,
                        color: Colors.grey,
                    )
                    : const Icon(
                      Icons.remove_red_eye_rounded,
                      color: Colors.grey,
                    )
              ),
              filled: true,
              fillColor: ColorConstants.inputColor,
              focusColor: Colors.black,
              enabledBorder: ThemeConstants.inputBorder,
              focusedBorder: ThemeConstants.inputBorder,
            ),
            obscureText: _hidePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          )
        ],
      )
    );
  }
}

class RememberCheckboxWidget extends StatefulWidget {
  const RememberCheckboxWidget({super.key});

  @override
  State<RememberCheckboxWidget> createState() => _RememberCheckboxWidgetState();
}

class _RememberCheckboxWidgetState extends State<RememberCheckboxWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            side: const BorderSide(
              width: 3,
              color: Colors.red,
            ),
            value: _isChecked,
            onChanged: (value) {
              print(value);
              setState(() {
                _isChecked = !_isChecked;
              });
            }
          ),
          const Text(
            "Remember me",
            style: TextStyle(
              fontWeight: FontWeight.w700
            ),
          )
        ],
      ),
    );
  }
}

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Center(
        child: Text(
          "Forgot the password?",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}

class OtherLoginTitleWidget extends StatelessWidget {
  const OtherLoginTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: ColorConstants.inputColor,
          ),
        ),
        const Text(
            "or continue with",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black54
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: ColorConstants.inputColor,
          ),
        ),
      ],
    );
  }
}

class OtherLoginMethodWidget extends StatelessWidget {
  const OtherLoginMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        SizedBox(width: 20),
        OtherLoginMethodButton(nameMethod: "facebook"),
        OtherLoginMethodButton(nameMethod: "google"),
        OtherLoginMethodButton(nameMethod: "apple"),
        SizedBox(width: 20)
      ],
    );
  }
}

class OtherLoginMethodButton extends StatelessWidget {
  final String nameMethod;
  const OtherLoginMethodButton({super.key, required this.nameMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.inputColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        ImageHelper.getImage("${nameMethod}_logo"),
        height: 25,
      ),
    );
  }
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            "Sign up",
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ],
    );
  }
}




// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const core.AppScaffold<LoginBloc>(
//       body: LoginListener(),
//     );
//   }
// }

// class LoginListener extends StatelessWidget {
//   const LoginListener({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return core.BlocListener<LoginBloc, LoginState>(
//       listenWhen: (previous, current) {
//         return current.errMessage != null ||
//             previous.isLoading != current.isLoading;
//       },
//       listener: (context, state) {
//         if (state.isLoading) {
//           core.UIHelper.showLoading();
//         } else {
//           core.UIHelper.hideLoading();
//         }
//         if (state.errMessage != null) {
//          // core.UIHelper.showSnackBar(context, msg: state.errMessage);
//           DialogService.errorDialog(context,
//               title: 'Error',
//               message: state.errMessage
//           );
//         }
//         if (state.isSuccess == true) {
//           final bloc = context.read<LoginBloc>();
//           Navigator.of(context).pushNamed(
//             RouteConstants.userProfile,
//             arguments: bloc.userId,
//           );
//           core.UIHelper.showSnackBar(context, msg: 'success');
//         }
//       },
//       child: const LoginView(),
//     );
//   }
// }
//
// class LoginView extends StatelessWidget {
//   const LoginView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: const [
//           UIConstants.verticalSpace44,
//           LogoWidget(),
//           UIConstants.verticalSpace44,
//           Text('Login', style: StyleConstants.overSizeText),
//           UIConstants.verticalSpace24,
//           LoginInputForm(),
//           UIConstants.verticalSpace6,
//           ForgotPassButton(),
//           UIConstants.verticalSpace32,
//           LoginButton(),
//           UIConstants.verticalSpace32,
//           RegisterWidget()
//         ],
//       ),
//     );
//   }
// }
//
// class RegisterWidget extends StatelessWidget {
//   const RegisterWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           'Not have an account yet?',
//           style: StyleConstants.largeText,
//         ),
//         TextButton(
//             onPressed: () {
//               Navigator.of(context).pushNamed(
//                 RouteConstants.register,
//               );
//             },
//             child: const Text('Register')),
//       ],
//     );
//   }
// }
//
// class LoginButton extends StatelessWidget {
//   const LoginButton({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GradientButton(
//         onPressed: () {
//           // DialogService.confirmDialog(context,
//           //     title: 'ggggg',
//           //     actionTitle: 'sss',
//           //     subTitle: 'abcccc ccccccc ccccccccccc ccccccrgrgrgregrgr'
//           // );
//           final bloc = context.read<LoginBloc>();
//           if (bloc.formLoginKey.currentState!.validate()) {
//             bloc.add(LoginButtonPressed(
//                 username: bloc.username.text, password: bloc.password.text));
//           }
//         },
//         child: const Text('Login'));
//   }
// }
//
// class ForgotPassButton extends StatelessWidget {
//   const ForgotPassButton({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Expanded(child: SizedBox()),
//         TextButton(
//             onPressed: () {
//               Navigator.of(context).pushNamed(
//                 RouteConstants.forgotPassword,
//               );
//             },
//             child: const Text('Forgot Password?')),
//       ],
//     );
//   }
// }
//

// class LoginInputForm extends StatefulWidget {
//   const LoginInputForm({super.key});
//
//   @override
//   State<LoginInputForm> createState() => _LoginInputFormState();
// }
//
// class _LoginInputFormState extends State<LoginInputForm> {
//   bool _hideText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<LoginBloc>();
//     return Form(
//       key: bloc.formLoginKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             enableSuggestions: false,
//             controller: bloc.username,
//             autocorrect: false,
//             keyboardType: TextInputType.phone,
//             decoration: const InputDecoration(
//               hintText: 'Enter your phone number',
//               prefixIcon: Icon(Icons.phone_iphone_outlined),
//             ),
//             // The validator receives the text that the user has entered.
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               if(!RegExp(r'^((0[0-9]))\d{8}$').hasMatch(value)){
//                 return 'Phone error';
//               }
//               return null;
//             },
//           ),
//           UIConstants.verticalSpace16,
//           TextFormField(
//             controller: bloc.password,
//             obscureText: _hideText,
//             enableSuggestions: false,
//             autocorrect: false,
//             decoration: InputDecoration(
//               hintText: 'Enter your password',
//               prefixIcon: const Icon(
//                 Icons.password_outlined,
//               ),
//               suffixIcon: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _hideText = !_hideText;
//                     });
//                   },
//                   icon: _hideText
//                       ? Icon(Icons.remove_red_eye_outlined)
//                       : Icon(Icons.visibility_off_sharp)),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class LogoWidget extends StatelessWidget {
//   const LogoWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 343,
//       height: 160,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               ImageHelper.getImage('logo_bg_demo'),
//             ),
//           ),
//           Positioned.fill(
//             child: Center(
//               child: Image.asset(
//                 ImageHelper.getImage('logo_text_demo'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
