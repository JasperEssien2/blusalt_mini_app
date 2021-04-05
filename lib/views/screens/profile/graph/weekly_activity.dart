import 'package:bezier_chart/bezier_chart.dart';
import 'package:blusalt_mini_app/blocs/question/question_bloc.dart';
import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/utils/time_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemWeeklyActivityGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DateTime fromDate = DateTime.now().subtract(Duration(days: 7));
    final DateTime toDate = DateTime.now();
    var themeData = Theme.of(context);
    return BlocProvider.value(
      value: injector.get<QuestionBloc>(),
      child: BlocConsumer<QuestionBloc, QuestionState>(
        listener: (context, state) {},
        builder: (context, state) => Card(
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.paddingSizeHorizontal20,
            vertical: SizeConfig.paddingSizeVertical16,
          ),
          elevation: 2.0,
          color: themeData.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Container(
            width: size.width - (SizeConfig.paddingSizeHorizontal20 * 2),
            height: size.height * 0.23,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.paddingSizeHorizontal16,
              vertical: SizeConfig.paddingSizeVertical16,
            ),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Weekly Activity',
                  style: themeData.textTheme.bodyText1!.copyWith(
                    color: themeData.colorScheme.primaryTextColorScheme,
                    fontSize: SizeConfig.textSize16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: BezierChart(
                    fromDate: fromDate,
                    toDate: toDate,
                    bezierChartScale: BezierChartScale.WEEKLY,
                    bubbleLabelValueBuilder: (length) {
                      return '${length.toString()}';
                    },
                    series: [
                      BezierLine(
                          lineColor: appbarEndGradient,
                          data: _getAxisPoint(
                              context.watch<QuestionBloc>().questions),
                          label: 'Questions'),
                    ],
                    config: BezierChartConfig(
                      verticalIndicatorStrokeWidth: 3.0,
                      verticalIndicatorColor: themeData.dividerColor,
                      displayYAxis: true,
                      showVerticalIndicator: true,
                      verticalIndicatorFixedPosition: true,
                      backgroundColor: themeData.cardColor,
                      xAxisTextStyle: themeData.textTheme.bodyText2!.copyWith(
                          fontSize: SizeConfig.textSize12,
                          color:
                              themeData.colorScheme.secondaryTextColorScheme),
                      yAxisTextStyle: themeData.textTheme.bodyText2!.copyWith(
                          fontSize: SizeConfig.textSize12,
                          color:
                              themeData.colorScheme.secondaryTextColorScheme),
                      footerHeight:
                          SizeConfig.heightSize30 + SizeConfig.heightSize24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DataPoint<DateTime>> _getAxisPoint(List<Question> questions) {
    Map<DateTime, List<Question>> dateToQuestionMap = {};
    questions.forEach((element) {
      _insertDateTimeToMap(element, dateToQuestionMap);
    });
    return _insertDataPointsFromDateToQuestionListMap(dateToQuestionMap);
  }

  void _insertDateTimeToMap(
      Question element, Map<DateTime, List<Question>> dateToQuestionMap) {
    var dateTime = TimeDateFormatter.parseStringDateOnly(element.createdAt);
    if (dateToQuestionMap.containsKey(dateTime))
      dateToQuestionMap[dateTime]!.add(element);
    else
      dateToQuestionMap[dateTime] = [element];
  }

  List<DataPoint<DateTime>> _insertDataPointsFromDateToQuestionListMap(
      Map<DateTime, List<Question>> dateToQuestionMap) {
    List<DataPoint<DateTime>> points = [];
    dateToQuestionMap.forEach((key, value) {
      points
          .add(DataPoint<DateTime>(value: value.length.toDouble(), xAxis: key));
    });
    return points;
  }
}
