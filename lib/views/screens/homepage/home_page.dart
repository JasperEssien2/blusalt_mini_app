import 'package:blusalt_mini_app/blocs/question/question_bloc.dart';
import 'package:blusalt_mini_app/blocs/user/user_bloc_cubit.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/utils/time_date_formatter.dart';
import 'package:blusalt_mini_app/views/components/dialog_create.dart';
import 'package:blusalt_mini_app/views/components/item_appbar.dart';
import 'package:blusalt_mini_app/views/routes/routes.dart';
import 'package:blusalt_mini_app/views/screens/question/widgets/question_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig.init(context);
    print(SizeConfig.toString_());
    return Scaffold(
      appBar: PreferredSize(
        child: GradientAppBar(
          height: _appbarHeight(size),
          child: AppbarContent(),
        ),
        preferredSize: Size(size.width, _appbarHeight(size)),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: QuestionListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddQuestionDialog();
        },
        backgroundColor: accentColor,
        child: Icon(
          Icons.create_rounded,
          size: 24.0,
          color: Colors.white,
        ),
      ),
    );
  }

  double _appbarHeight(Size size) => size.height * 0.15;

  void _showAddQuestionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        var textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Theme.of(context).colorScheme.secondaryTextColorScheme,
              fontSize: SizeConfig.textSize18,
              fontWeight: FontWeight.w500,
            );
        return injector.get<UserBlocCubit>().response.id == 'anonymous'
            ? _authenticateDialog(textStyle)
            : DialogCreate(isAnswer: false);
      },
    );
  }

  AlertDialog _authenticateDialog(TextStyle textStyle) {
    return AlertDialog(
      content: Text(
        'Only authenticated users can create question, Authenticate?',
        style: textStyle,
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.popAndPushNamed(context, Routes.authenticationPageLogin);
          },
          child: Text(
            'OK',
            style: textStyle.copyWith(
              fontSize: SizeConfig.textSize16,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    injector.get<UserBlocCubit>().getUser();
    injector.get<QuestionBloc>().add(LoadQuestionList());
  }
}

class AppbarContent extends StatelessWidget {
  const AppbarContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: 25.0, top: SizeConfig.paddingSizeVertical16),
      child: BlocProvider<UserBlocCubit>.value(
        value: injector.get<UserBlocCubit>(),
        child: BlocConsumer<UserBlocCubit, UserBlocState>(
            listener: (context, state) {},
            builder: (context, state) {
              var themeData = Theme.of(context);
              return Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.profilePage,
                              arguments:
                                  context.read<UserBlocCubit>().response),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 16.0,
                            backgroundImage: NetworkImage(
                                'https://library.kissclipart.com/20190326/ae/kissclipart-smile-emoji-image-happiness-emoticon-a4836419f4ca03ae.png'),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        RichText(
                          text: TextSpan(
                              text: TimeDateFormatter.getGreeting(
                                  dateTime: DateTime.now()),
                              style: themeData.textTheme.headline6!.copyWith(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: SizeConfig.textSize18,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      ' ${context.watch<UserBlocCubit>().response.firstname}',
                                  style:
                                      themeData.textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                    fontSize: SizeConfig.textSize18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    customBorder: CircleBorder(),
                    child: Container(
                      height: 24.0,
                      width: 24.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 2.0,
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 5.0,
                                backgroundColor: Color(0xffF2C94C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
