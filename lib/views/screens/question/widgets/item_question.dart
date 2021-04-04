import 'package:blusalt_mini_app/blocs/user/user_bloc_cubit.dart';
import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/intl_util.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/utils/time_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ItemQuestion extends StatelessWidget {
  final Question question;

  const ItemQuestion({Key? key, required this.question}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return Card(
      elevation: 0.0,
      margin:
          EdgeInsets.symmetric(horizontal: SizeConfig.paddingSizeVertical20),
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
            Expanded(
              child: Row(
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
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://cdn4.vectorstock.com/i/1000x1000/52/48/man-cartoon-face-male-facial-expression-vector-15325248.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.paddingSizeHorizontal12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<UserBlocCubit, UserBlocState>(
                        bloc: GetIt.asNewInstance().get<UserBlocCubit>(),
                        builder: (context, state) => Text(
                          '${context.watch<UserBlocCubit>().response.firstname} ${context.watch<UserBlocCubit>().response.lastname}',
                          style: themeData.textTheme.bodyText2!.copyWith(
                            color: themeData.colorScheme.primaryTextColorScheme,
                            fontSize: SizeConfig.textSize16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.paddingSizeVertical5,
                      ),
                      Text(
                        '${TimeDateFormatter.getDateAgo(question.createdAt)} - '
                        '${IntlUtil.formatTimeMedium(question.createdAt)}',
                        style: themeData.textTheme.bodyText1!.copyWith(
                          color: themeData.colorScheme.secondaryTextColorScheme,
                          fontSize: SizeConfig.textSize14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.paddingSizeVertical16,
                      ),
                      Text(
                        '${question.question}',
                        style: themeData.textTheme.bodyText1!.copyWith(
                          color: themeData.colorScheme.secondaryTextColorScheme,
                          fontSize: SizeConfig.textSize14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.paddingSizeVertical16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      margin:
          EdgeInsets.symmetric(horizontal: SizeConfig.paddingSizeVertical20),
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
            Flexible(
              child: Row(
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
                          height: SizeConfig.paddingSizeVertical16,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: SizeConfig.paddingSizeVertical5,
                        ),
                        Container(
                          width: size.width,
                          height: SizeConfig.paddingSizeVertical14,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: SizeConfig.paddingSizeVertical16,
                        ),
                        Container(
                          width: size.width,
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
            ),
          ],
        ),
      ),
    );
  }
}
