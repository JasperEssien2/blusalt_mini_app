import 'package:blusalt_mini_app/blocs/question/question_bloc.dart';
import 'package:blusalt_mini_app/blocs/user/user_bloc_cubit.dart';
import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/app_util.dart';
import 'package:blusalt_mini_app/utils/image_util.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/utils/time_date_formatter.dart';
import 'package:blusalt_mini_app/views/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemQuestion extends StatelessWidget {
  final Question question;
  final int index;

  const ItemQuestion({Key? key, required this.question, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return Card(
      elevation: 0.0,
      color: Colors.transparent,
      margin:
          EdgeInsets.symmetric(horizontal: SizeConfig.paddingSizeVertical20),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.questionDetailPage,
            arguments: question),
        child: Container(
          width: size.width,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.paddingSizeHorizontal20,
            vertical: SizeConfig.paddingSizeVertical16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocProvider<UserBlocCubit>(
                lazy: false,
                create: (context) {
                  var userBlocCubit = UserBlocCubit(repository: injector.get());
                  userBlocCubit.getUser(id: question.user);
                  return userBlocCubit;
                },
                child: BlocConsumer<UserBlocCubit, UserBlocState>(
                  listener: (context, state) {
                    if (state is UserGotten) {
                      question.userModel = state.user;
                    }
                  },
                  builder: (context, state) => Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.profilePage,
                            arguments: context.read<UserBlocCubit>().response),
                        child: Container(
                          width: SizeConfig.heightSize30,
                          height: SizeConfig.heightSize30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://cdn4.vectorstock.com/i/1000x1000/52/48/man-cartoon-face-male-facial-expression-vector-15325248.jpg'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.paddingSizeHorizontal12,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${context.watch<UserBlocCubit>().response.firstname} '
                              '${context.watch<UserBlocCubit>().response.lastname}',
                              style: themeData.textTheme.bodyText2!.copyWith(
                                color: themeData
                                    .colorScheme.secondaryTextColorScheme,
                                fontSize: SizeConfig.textSize16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.paddingSizeVertical5,
                            ),
                            Text(
                              '${TimeDateFormatter.getDateAgo(question.createdAt)}',
                              style: themeData.textTheme.bodyText1!.copyWith(
                                color: themeData
                                    .colorScheme.secondaryTextColorScheme,
                                fontSize: SizeConfig.textSize13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.paddingSizeVertical16,
                            ),
                            Text(
                              '${question.question}',
                              style: themeData.textTheme.bodyText1!.copyWith(
                                color: themeData
                                    .colorScheme.primaryTextColorScheme,
                                fontSize: SizeConfig.textSize14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.paddingSizeVertical16,
                            ),
                            Container(
                              height: SizeConfig.heightSize30,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    customBorder: CircleBorder(),
                                    onTap: () => _voteQuestion(
                                        context: context, voteAction: 'up'),
                                    child: Container(
                                      height: 20.0,
                                      width: 20.0,
                                      margin: EdgeInsets.only(
                                          right: SizeConfig
                                              .paddingSizeHorizontal12),
                                      child: SvgPicture.asset(
                                        ImageUtil.upvote,
                                        height: 18.0,
                                        width: 18.0,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${question.votes}',
                                    style:
                                        themeData.textTheme.bodyText1!.copyWith(
                                      color: themeData
                                          .colorScheme.secondaryTextColorScheme,
                                      fontSize: SizeConfig.textSize18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  InkWell(
                                    customBorder: CircleBorder(),
                                    onTap: () => _voteQuestion(
                                        context: context, voteAction: 'down'),
                                    child: Container(
                                      height: 20.0,
                                      width: 20.0,
                                      margin: EdgeInsets.only(
                                          left: SizeConfig
                                              .paddingSizeHorizontal12),
                                      child: SvgPicture.asset(
                                        ImageUtil.downvote,
                                        height: 24.0,
                                        width: 24.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.paddingSizeVertical16,
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
        ),
      ),
    );
  }

  void _voteQuestion(
      {required BuildContext context, required String voteAction}) {
    if (injector.get<UserBlocCubit>().response.id == 'anonymous') {
      _showNotAuthenticatedDialog(context);
    } else {
      injector.get<QuestionBloc>().add(VoteQuestion(
          question: question, voteAction: voteAction, questionIndex: index));
    }
  }

  void _showNotAuthenticatedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        var textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Theme.of(context).colorScheme.secondaryTextColorScheme,
              fontSize: SizeConfig.textSize18,
              fontWeight: FontWeight.w500,
            );
        return AppUtil.authenticateDialog(context, textStyle);
      },
    );
  }
}

class ItemQuestionShimmer extends StatelessWidget {
  const ItemQuestionShimmer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return Card(
      elevation: 0.0,
      color: Colors.transparent,
      margin:
          EdgeInsets.symmetric(horizontal: SizeConfig.paddingSizeVertical20),
      child: Container(
        color: Colors.transparent,
        width: size.width,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.paddingSizeHorizontal20,
          vertical: SizeConfig.paddingSizeVertical16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.heightSize30,
                  height: SizeConfig.heightSize30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.paddingSizeHorizontal12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                            right: SizeConfig.paddingSizeHorizontal20),
                        height: SizeConfig.paddingSizeVertical16,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: SizeConfig.paddingSizeVertical8,
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                            right: SizeConfig.paddingSizeHorizontal20),
                        height: SizeConfig.paddingSizeVertical14,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: SizeConfig.paddingSizeVertical16,
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                            right: SizeConfig.paddingSizeHorizontal20),
                        height: SizeConfig.paddingSizeVertical20,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: SizeConfig.paddingSizeVertical16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
