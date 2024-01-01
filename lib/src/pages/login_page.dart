import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/constant/custom_colors.dart';
import 'package:toolbox/src/constant/service_url.dart';
import 'package:toolbox/src/models/color_state.dart';
import 'package:toolbox/src/models/token.dart';
import 'package:toolbox/src/models/user.dart';
import 'package:toolbox/src/provider/token_provider.dart';
import 'package:toolbox/src/routers/routes.dart';
import 'package:toolbox/src/services/dio_service.dart';
import 'package:toolbox/src/provider/user_provider.dart';
import 'package:toolbox/src/routers/application.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/widgets/popup/alert.dart';
import 'package:toolbox/src/widgets/button/window_text_button.dart';
import 'package:toolbox/src/widgets/text/clickable_text.dart';
import 'package:toolbox/src/widgets/text_field/email_text_field.dart';
import 'package:toolbox/src/widgets/text_field/password_text_field.dart';
import 'package:toolbox/src/widgets/window_appbar/login_page_appbar.dart';

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
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LoginPageAppbar(),
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
              '${Constant.imagePath}people.svg',
              width: 459.0,
              semanticsLabel: 'People',
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

  void _showAnimatedContainer(String alertText) {
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
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      FormData params = FormData.fromMap({
        'email': _emailController.text,
        'password': _passwordController.text
      });

      DioService.post(ServiceUrl.login, params, successCallBack: (data) {
        Provider.of<TokenProvider>(context, listen: false).token = Token(
            accessToken: data['access'],
            refreshToken: data['refresh'],
            accessTokenExpiresIn: data['access_expires_in'],
            refreshTokenExpiresIn: data['refresh_expires_in']);
        DioService.get(ServiceUrl.users + data['id'].toString(),
            successCallBack: (data) {
          String? password = _isRemember ? _passwordController.text : '';
          data['password'] = password;
          Provider.of<UserProvider>(context, listen: false).user =
              User.fromJson(data);
          Provider.of<UserProvider>(context, listen: false).isRemember =
              _isRemember;
          Application.router.navigateTo(context, Routes.root);
        }, errorCallBack: (error) {
          _showAnimatedContainer(error);
        });
      }, errorCallBack: (error) {
        if (error == 'Access denied') {
          _showAnimatedContainer('The emaill or password is incorrect');
        } else {
          _showAnimatedContainer(error);
        }
      });
    } else {
      _showAnimatedContainer('The email or password cannot be empty');
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
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      'Welcome back!',
                      style: theme.textTheme.displaySmall,
                    ),
                  ),
                  SelectableText(
                    'Please enter your details',
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.extension<ExtensionColors>()!.textGrey),
                  ),
                  const SizedBox(height: 25.0),
                  EmailTextField(controller: _emailController),
                  PasswordTextField(controller: _passwordController),
                  SizedBox(
                    width: 312.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RememberMeWithCheckbox(
                          isRemember: _isRemember,
                          onChanged: _toggleRemember,
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
                          url: ServiceUrl.forgotPassword,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 82.0, 0.0, 76.0),
                    child: WindowTextButton(
                      backgroundColors: ColorState(
                        normal: CustomColors.primary,
                        mouseOver: CustomColors.primary.withBlue(225),
                        mouseDown: CustomColors.primary.withBlue(255),
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      text: 'Login',
                      textStyle: theme.textTheme.labelLarge!
                          .copyWith(color: CustomColors.textWhite),
                      onPressed: _login,
                    ),
                  ),
                  SizedBox(
                    width: 245.0,
                    child: Row(
                      children: <Widget>[
                        SelectableText(
                          'Don\'t have an email?',
                          style: theme.textTheme.bodyLarge!.copyWith(
                              color:
                                  theme.extension<ExtensionColors>()!.textGrey),
                        ),
                        const SizedBox(width: 7.0),
                        ClickableText(
                          text: 'Sign Up',
                          textStyle: theme.textTheme.bodyLarge!
                              .copyWith(color: theme.colorScheme.primary),
                          url: ServiceUrl.signUp,
                        ),
                      ],
                    ),
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

class RememberMeWithCheckbox extends StatelessWidget {
  const RememberMeWithCheckbox({
    super.key,
    required this.isRemember,
    required this.onChanged,
    this.backgroundColor,
    this.sideColor = const Color(0xFF000000),
    this.textStyle,
  });

  final bool isRemember;
  final VoidCallback onChanged;
  final Color? backgroundColor;
  final Color sideColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 16.0,
          child: Checkbox(
            value: isRemember,
            activeColor: backgroundColor,
            side: BorderSide(width: 2.0, color: sideColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            splashRadius: 0.0,
            onChanged: (_) => onChanged(),
          ),
        ),
        const SizedBox(width: 7.0),
        SelectableText('Remember me', style: textStyle),
      ],
    );
  }
}
