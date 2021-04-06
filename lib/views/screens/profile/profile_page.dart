import 'package:blusalt_mini_app/blocs/answer/answer_list_bloc.dart';
import 'package:blusalt_mini_app/blocs/question/question_bloc.dart';
import 'package:blusalt_mini_app/blocs/user/user_bloc_cubit.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/views/components/item_appbar.dart';
import 'package:blusalt_mini_app/views/screens/profile/graph/weekly_activity.dart';
import 'package:blusalt_mini_app/views/screens/question/widgets/question_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: PreferredSize(
                  child: GradientAppBar(
                    child: AppbarContent(
                      user: user!,
                    ),
                    alignment: Alignment.topCenter,
                    height: size.height * 0.2,
                  ),
                  preferredSize: Size(size.width, size.height * 0.2),
                ),
              ),
              Positioned(
                top: size.height * 0.10,
                child: ItemWeeklyActivityGraph(),
              ),
              Positioned(
                top: size.height * 0.35,
                child: Container(
                  height: size.height * 0.6,
                  child: QuestionListView(
                    filter: user!.id,
                    instance: 'profile',
                  ),
                  width: size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  UserResponse? user;
  @override
  void didChangeDependencies() {
    user = (ModalRoute.of(context)!.settings.arguments as UserResponse);
    if (user == null) Navigator.pop(context);
    injector
        .get<QuestionBloc>(instanceName: 'profile')
        .add(LoadQuestionList(filterByUserId: user!.id));

    injector
        .get<AnswerListBloc>(instanceName: 'profile')
        .add(LoadAnswerList(userId: user!.id));
    super.didChangeDependencies();
  }
}

class AppbarContent extends StatelessWidget {
  final UserResponse user;
  const AppbarContent({
    Key? key,
    required this.user,
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 16.0,
                              backgroundImage: NetworkImage(
                                  'https://library.kissclipart.com/20190326/ae/kissclipart-smile-emoji-image-happiness-emoticon-a4836419f4ca03ae.png'),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: ' ${user.firstname} '
                                      '${user.lastname}',
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
                  ),
                ],
              );
            }),
      ),
    );
  }
}
