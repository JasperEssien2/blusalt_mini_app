import 'package:blusalt_mini_app/blocs/authentication/login_cubit.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.keys.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/views/components/custom_button.dart';
import 'package:blusalt_mini_app/views/routes/routes.dart';
import 'package:blusalt_mini_app/views/screens/authentication/widgets/edit_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    email.addListener(() {
      print('email changed ===================== ');
      injector.get<LoginCubit>().updateEmail(email.text);
    });
    password.addListener(() {
      injector.get<LoginCubit>().updatePassword(password.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return BlocProvider(
      create: (_) => injector.get<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          _handleStateChange(state, context);
        },
        builder: (context, state) => Card(
          color: themeData.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 4.0,
          margin: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 30.0,
          ),
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight / 1.5,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Login',
                        style: themeData.accentTextTheme.bodyText2!.copyWith(
                          color: appbarEndGradient,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.textSize30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.paddingSizeVertical20,
                    ),
                    CustomEditText(
                      textEditingController: email,
                      hintText: 'Email',
                      type: TextInputType.emailAddress,
                    ),
                    CustomEditText(
                      textEditingController: password,
                      hintText: 'Password',
                      type: TextInputType.text,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _openSignUpPage();
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account yet?',
                            style: themeData.textTheme.bodyText2!.copyWith(
                              fontSize: SizeConfig.textSize14,
                              fontWeight: FontWeight.w400,
                              color: themeData
                                  .colorScheme.secondaryTextColorScheme,
                            ),
                            children: [
                              TextSpan(
                                text: ' Sign Up!',
                                style: themeData.accentTextTheme.bodyText2!
                                    .copyWith(
                                  fontSize: SizeConfig.textSize14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: _getPaddingBetweenButtonAndLastEditText(),
                        left: SizeConfig.paddingSizeHorizontal16,
                        right: SizeConfig.paddingSizeHorizontal16,
                        bottom: SizeConfig.paddingSizeVertical16,
                      ),
                      child: CustomButton(
                        buttonText: 'Log in',
                        isLoading: context.watch<LoginCubit>().model.isLoading,
                        isEnabled:
                            context.watch<LoginCubit>().model.isButtonEnabled,
                        onPressed: () {
                          context.read<LoginCubit>().login();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleStateChange(LoginState state, BuildContext context) {
    if (state is LoginSuccessfulState) {
      Navigator.popAndPushNamed(context, Routes.homePage);
    } else if (state is LoginErrorState) {
      Fluttertoast.showToast(msg: '${state.errorModel.errorMessage}');
    }
  }

  void _openSignUpPage() {
    Navigator.popAndPushNamed(context, Routes.authenticationPageSignUp);
  }

  double _getPaddingBetweenButtonAndLastEditText() =>
      SizeConfig.paddingSizeVertical20 + SizeConfig.paddingSizeVertical12;

}
