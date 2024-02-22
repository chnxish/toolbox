import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/constant/custom_colors.dart';
import 'package:toolbox/src/constant/service_url.dart';
import 'package:toolbox/src/models/color_state.dart';
import 'package:toolbox/src/provider/user_provider.dart';
import 'package:toolbox/src/routers/application.dart';
import 'package:toolbox/src/routers/routes.dart';
import 'package:toolbox/src/services/dio_service.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/utils/validate.dart';
import 'package:toolbox/src/widgets/button/window_text_button.dart';
import 'package:toolbox/src/widgets/popup/alert.dart';
import 'package:toolbox/src/widgets/popup/confirmation.dart';
import 'package:toolbox/src/widgets/text/checkbox_with_text.dart';
import 'package:toolbox/src/widgets/text/clickable_text.dart';
import 'package:toolbox/src/widgets/text_field/common_text_field.dart';
import 'package:toolbox/src/widgets/text_field/secure_text_field.dart';
import 'package:toolbox/src/widgets/window_appbar/auth_page_appbar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.setSize(Constant.windowSize);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AuthPageAppbar(
        leftSideBackground: CustomColors.accent02,
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: LeftSide(),
          ),
          Expanded(
            flex: 1,
            child: RightSide(),
          ),
        ],
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color: CustomColors.accent02,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 40.0,
            top: 12.0,
            child: SvgPicture.asset(
              '${Constant.imagePath}logo-dark.svg',
              width: 128.0,
              semanticsLabel: 'Logo Light',
            ),
          ),
          Positioned(
            left: 45.0,
            top: 78.0,
            child: LimitedBox(
              maxWidth: 300.0,
              child: SelectableText(
                'Your Toolkit for Effortless Productivity',
                style: theme.textTheme.displaySmall!
                    .copyWith(color: CustomColors.textWhite),
              ),
            ),
          ),
          Positioned(
            left: 80.0,
            bottom: 2.0,
            child: SvgPicture.asset(
              '${Constant.imagePath}people2.svg',
              width: 510.0,
              semanticsLabel: 'People2',
            ),
          ),
        ],
      ),
    );
  }
}

class RightSide extends StatefulWidget {
  const RightSide({super.key});

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool _isAgree = false;
  bool _isShowAlert = false;
  String _alertText = '';

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void _toggleAgree() {
    setState(() {
      _isAgree = !_isAgree;
    });
  }

  void _showAlert(String alertText) {
    setState(() {
      _alertText = alertText;
      _isShowAlert = true;
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isShowAlert = false;
      });
    });
  }

  void _showConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Confirmation(
          title: 'Success',
          text: 'Your account has been created successfully! '
              'Please check your email to confirm your email address in order to activate your account.',
          onPressed: () {
            Application.router.navigateTo(context, Routes.login);
          },
        );
      },
    );
  }

  void _signup() {
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (_isAgree) {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          confirmPassword.isNotEmpty) {
        if (password == confirmPassword) {
          Provider.of<UserProvider>(context, listen: false).token = '';
          FormData params = FormData.fromMap({
            'username': username,
            'email': email,
            'password': password,
            'confirm_password': confirmPassword,
          });

          DioService.post(ServiceUrl.signup, params: params,
              successCallBack: (dataMap) {
            _showConfirmation(context);
          }, errorCallBack: (error) {
            _showAlert(error);
          });
        } else {
          _showAlert('The password and confirmation password must match.');
        }
      } else {
        _showAlert('All details must not be empty.');
      }
    } else {
      _showAlert('You must agree to the terms of use.');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: 8.0,
            child: Alert(
              text: _alertText,
              isVisible: _isShowAlert,
            ),
          ),
          Positioned(
            top: 62.0,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SelectableText(
                    'Create account',
                    style: theme.textTheme.displaySmall,
                  ),
                  SelectableText(
                    'Enter details for create an account',
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.extension<ExtensionColors>()!.textGrey),
                  ),
                  const SizedBox(height: 14.0),
                  CommonTextField(
                    controller: _usernameController,
                    hintText: 'Username',
                    onEditingComplete: _signup,
                    validator: validateUsername,
                  ),
                  CommonTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    onEditingComplete: _signup,
                    validator: validateEmail,
                  ),
                  SecureTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    onEditingComplete: _signup,
                    validator: validatePassword,
                  ),
                  SecureTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    onEditingComplete: _signup,
                    validator: validatePassword,
                  ),
                  SizedBox(
                    width: 312.0,
                    child: CheckboxWithText(
                      isChecked: _isAgree,
                      onChanged: _toggleAgree,
                      text: 'I agree to the terms of use',
                      backgroundColor: theme.colorScheme.primary,
                      sideColor:
                          theme.extension<ExtensionColors>()!.backgroundGrey,
                      textStyle: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.extension<ExtensionColors>()!.textGrey),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 45.0),
                    child: WindowTextButton(
                      backgroundColors: ColorState(
                        normal: CustomColors.primary,
                        mouseOver: CustomColors.primary.withBlue(225),
                        mouseDown: CustomColors.primary,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      text: 'Sign up',
                      textStyle: theme.textTheme.labelLarge!
                          .copyWith(color: CustomColors.textWhite),
                      onPressed: _signup,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 41.0,
            child: SizedBox(
              width: 254.0,
              child: Row(
                children: <Widget>[
                  SelectableText(
                    'Already have an account?',
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.extension<ExtensionColors>()!.textGrey),
                  ),
                  const SizedBox(width: 6.0),
                  ClickableText(
                    text: 'Login',
                    textStyle: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.primary),
                    path: Routes.login,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
