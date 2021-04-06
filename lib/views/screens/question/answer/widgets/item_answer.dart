import 'package:blusalt_mini_app/data/network/model/answer_response.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/views/routes/routes.dart';
import 'package:flutter/material.dart';

class ItemAnswer extends StatelessWidget {
  final AnswerResponse answer;
  final int index;

  const ItemAnswer({Key? key, required this.answer, required this.index})
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, Routes.profilePage,
                      arguments: answer.user),
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
                        '${answer.user.firstname} '
                        '${answer.user.lastname}',
                        style: themeData.textTheme.bodyText2!.copyWith(
                          color: themeData.colorScheme.secondaryTextColorScheme,
                          fontSize: SizeConfig.textSize16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.paddingSizeVertical5,
                      ),
                      Text(
                        'Time',
                        style: themeData.textTheme.bodyText1!.copyWith(
                          color: themeData.colorScheme.secondaryTextColorScheme,
                          fontSize: SizeConfig.textSize13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.paddingSizeVertical16,
                      ),
                      Text(
                        '${answer.answer}',
                        style: themeData.textTheme.bodyText1!.copyWith(
                          color: themeData.colorScheme.primaryTextColorScheme,
                          fontSize: SizeConfig.textSize14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.paddingSizeVertical16,
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

class ItemAnswerShimmer extends StatelessWidget {
  const ItemAnswerShimmer({
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
