import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/constant/custom_colors.dart';
import 'package:toolbox/src/constant/service_url.dart';
import 'package:toolbox/src/models/color_state.dart';
import 'package:toolbox/src/models/user.dart';
import 'package:toolbox/src/routers/routes.dart';
import 'package:toolbox/src/services/dio_service.dart';
import 'package:toolbox/src/provider/user_provider.dart';
import 'package:toolbox/src/routers/application.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/utils/validate.dart';
import 'package:toolbox/src/widgets/popup/alert.dart';
import 'package:toolbox/src/widgets/button/window_text_button.dart';
import 'package:toolbox/src/widgets/text/checkbox_with_text.dart';
import 'package:toolbox/src/widgets/text/clickable_text.dart';
import 'package:toolbox/src/widgets/text_field/common_text_field.dart';
import 'package:toolbox/src/widgets/text_field/secure_text_field.dart';
import 'package:toolbox/src/widgets/window_appbar/auth_page_appbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.setSize(Constant.windowSize);
    windowManager.setResizable(false);
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
        leftSideBackground: CustomColors.accent01,
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
      color: CustomColors.accent01,
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
            left: 28.0,
            bottom: 2.0,
            child: SvgPicture.asset(
              '${Constant.imagePath}people1.svg',
              width: 459.0,
              semanticsLabel: 'People1',
            ),
          )
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
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late bool _isRemember;
  bool _isShowAlert = false;
  String _alertText = '';

  @override
  void initState() {
    super.initState();
    UserProvider loginProvider =
        Provider.of<UserProvider>(context, listen: false);
    _emailController = TextEditingController(text: loginProvider.email);
    _passwordController = TextEditingController(text: loginProvider.password);
    _isRemember = loginProvider.isRemember;
  }

  void _toggleRemember() {
    setState(() {
      _isRemember = !_isRemember;
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

  void _login() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      Provider.of<UserProvider>(context, listen: false).token = '';
      FormData params =
          FormData.fromMap({'email': email, 'password': password});

      DioService.post(ServiceUrl.login, params: params,
          successCallBack: (dataMap) {
        Map<String, dynamic> data = dataMap['data'];
        String? pw = _isRemember ? password : '';
        data['password'] = pw;
        Provider.of<UserProvider>(context, listen: false).user =
            User.fromJson(data);
        Provider.of<UserProvider>(context, listen: false).isRemember =
            _isRemember;
        Application.router.navigateTo(context, Routes.root);
      }, errorCallBack: (error) {
        _showAlert(error);
      });
    } else {
      _showAlert('The email or password cannot be empty.');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: double.infinity,
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
            top: 118.0,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SelectableText(
                    'Welcome back!',
                    style: theme.textTheme.displaySmall,
                  ),
                  SelectableText(
                    'Please enter your details',
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.extension<ExtensionColors>()!.textGrey),
                  ),
                  const SizedBox(height: 25.0),
                  CommonTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    onEditingComplete: _login,
                    validator: validateEmail,
                  ),
                  SecureTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    onEditingComplete: _login,
                    validator: validatePassword,
                  ),
                  SizedBox(
                    width: 312.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CheckboxWithText(
                          isChecked: _isRemember,
                          onChanged: _toggleRemember,
                          text: 'Remember me',
                          backgroundColor: theme.colorScheme.primary,
                          sideColor: theme
                              .extension<ExtensionColors>()!
                              .backgroundGrey,
                          textStyle: theme.textTheme.bodyLarge!.copyWith(
                              color:
                                  theme.extension<ExtensionColors>()!.textGrey),
                        ),
                        ClickableText(
                          text: 'Forgot Password?',
                          textStyle: theme.textTheme.bodyLarge!
                              .copyWith(color: theme.colorScheme.primary),
                          path: ServiceUrl.forgotPassword,
                          isInternalRoute: false,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 82.0),
                    child: WindowTextButton(
                      backgroundColors: ColorState(
                        normal: CustomColors.primary,
                        mouseOver: CustomColors.primary.withBlue(225),
                        mouseDown: CustomColors.primary,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      text: 'Login',
                      textStyle: theme.textTheme.labelLarge!
                          .copyWith(color: CustomColors.textWhite),
                      onPressed: _login,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 71.0,
            child: SizedBox(
              width: 239.0,
              child: Row(
                children: <Widget>[
                  SelectableText(
                    'Don\'t have an email?',
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.extension<ExtensionColors>()!.textGrey),
                  ),
                  const SizedBox(width: 7.0),
                  ClickableText(
                    text: 'Sign Up',
                    textStyle: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.primary),
                    path: Routes.signup,
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
