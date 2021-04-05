import 'package:blusalt_mini_app/blocs/authentication/login_cubit.dart';
import 'package:blusalt_mini_app/blocs/authentication/sign_up_cubit.dart';
import 'package:blusalt_mini_app/data/network/model/request_models/signup_body.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/views/components/custom_button.dart';
import 'package:blusalt_mini_app/views/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'edit_text.dart';

class SignUpCard extends StatefulWidget {
  @override
  _SignUpCardState createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  TextEditingController email = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  @override
  void initState() {
    _addListenerToEditTextController();
    super.initState();
  }

  void _addListenerToEditTextController() {
    email.addListener(() {
      injector.get<SignUpCubit>().updateSignUpBodyModel(
          _getCubitSignUpBodyModel().copyWith(email: email.text));
    });
    password.addListener(() {
      injector.get<SignUpCubit>().updateSignUpBodyModel(
          _getCubitSignUpBodyModel().copyWith(password: password.text));
    });
    cPassword.addListener(() {
      injector.get<SignUpCubit>().updateSignUpBodyModel(
          _getCubitSignUpBodyModel().copyWith(cPassword: cPassword.text));
    });
    firstname.addListener(() {
      injector.get<SignUpCubit>().updateSignUpBodyModel(
          _getCubitSignUpBodyModel().copyWith(firstname: firstname.text));
    });

    lastName.addListener(() {
      injector.get<SignUpCubit>().updateSignUpBodyModel(
          _getCubitSignUpBodyModel().copyWith(lastname: lastName.text));
    });
  }

  SignupBody _getCubitSignUpBodyModel() =>
      injector.get<SignUpCubit>().model.signupBody;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(
          create: (context) => injector.get<SignUpCubit>(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => injector.get<LoginCubit>(),
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessfulState)
                Navigator.popAndPushNamed(context, Routes.homePage);
              else if (state is LoginErrorState) {
                Fluttertoast.showToast(
                    msg: 'An error occurred while login in, please try again!');
                Navigator.popAndPushNamed(
                    context, Routes.authenticationPageLogin);
              }
            },
          ),
        )
      ],
      child: BlocConsumer<SignUpCubit, SignUpState>(
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
                        'Sign Up',
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
                      textEditingController: firstname,
                      hintText: 'First Name',
                      type: TextInputType.name,
                    ),
                    CustomEditText(
                      textEditingController: lastName,
                      hintText: 'Last Name',
                      type: TextInputType.name,
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
                    CustomEditText(
                      textEditingController: cPassword,
                      hintText: 'Confirm Password',
                      type: TextInputType.text,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _openLoginPage();
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Have an account?',
                            style: themeData.textTheme.bodyText2!.copyWith(
                              fontSize: SizeConfig.textSize14,
                              fontWeight: FontWeight.w400,
                              color: themeData
                                  .colorScheme.secondaryTextColorScheme,
                            ),
                            children: [
                              TextSpan(
                                text: ' Log In!',
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
                        buttonText: 'Sign Up',
                        isLoading: context.watch<SignUpCubit>().model.isLoading,
                        isEnabled:
                            context.watch<SignUpCubit>().model.isButtonEnabled,
                        onPressed: () {
                          context.read<SignUpCubit>().signUp();
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

  void _handleStateChange(SignUpState state, BuildContext context) {
    if (state is SignUpSuccessfulState) {
      Fluttertoast.showToast(msg: 'Sign up successful, Login you in...');
      // Navigator.popAndPushNamed(context, Routes.homePage);
    } else if (state is SignUpErrorState) {
      Fluttertoast.showToast(msg: '${state.errorModel.errorMessage}');
    }
  }

  void _openLoginPage() {
    Navigator.popAndPushNamed(context, Routes.authenticationPageSignUp);
  }

  double _getPaddingBetweenButtonAndLastEditText() =>
      SizeConfig.paddingSizeVertical20 + SizeConfig.paddingSizeVertical12;
}
