import 'package:bezier_chart/bezier_chart.dart';
import 'package:blusalt_mini_app/blocs/answer/answer_list_bloc.dart';
import 'package:blusalt_mini_app/blocs/question/question_bloc.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemWeeklyActivityGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DateTime fromDate = DateTime.now().subtract(Duration(days: 7));
    final DateTime toDate = DateTime.now();
    var themeData = Theme.of(context);
    return BlocProvider<AnswerListBloc>.value(
      value: injector.get<AnswerListBloc>(instanceName: 'profile'),
      child: BlocConsumer<AnswerListBloc, AnswerListState>(
        listener: (context, state) {},
        builder: (context, state) => BlocProvider.value(
          value: injector.get<QuestionBloc>(instanceName: 'profile'),
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
                    if (_showWeeklyGraph(context))
                      Expanded(
                        child: BezierChart(
                          fromDate: fromDate,
                          toDate: toDate,
                          bezierChartScale: BezierChartScale.WEEKLY,
                          series: [
                            if (context
                                .watch<QuestionBloc>()
                                .questions
                                .isNotEmpty)
                              BezierLine(
                                  lineColor: appbarEndGradient,
                                  data: context.watch<QuestionBloc>().dataPoint,
                                  label: 'Questions'),
                            if (context
                                .watch<AnswerListBloc>()
                                .answers
                                .isNotEmpty)
                              BezierLine(
                                  lineColor: appbarStartGradient,
                                  data:
                                      context.watch<AnswerListBloc>().dataPoint,
                                  label: 'Answers'),
                          ],
                          config: BezierChartConfig(
                            verticalIndicatorStrokeWidth: 3.0,
                            verticalIndicatorColor: themeData.dividerColor,
                            displayYAxis: true,
                            showVerticalIndicator: true,
                            verticalIndicatorFixedPosition: true,
                            backgroundColor: themeData.cardColor,
                            xAxisTextStyle: themeData.textTheme.bodyText2!
                                .copyWith(
                                    fontSize: SizeConfig.textSize12,
                                    color: themeData
                                        .colorScheme.secondaryTextColorScheme),
                            yAxisTextStyle: themeData.textTheme.bodyText2!
                                .copyWith(
                                    fontSize: SizeConfig.textSize12,
                                    color: themeData
                                        .colorScheme.secondaryTextColorScheme),
                            footerHeight: SizeConfig.heightSize30 +
                                SizeConfig.heightSize24,
                          ),
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

  bool _showWeeklyGraph(BuildContext context) {
    return (!context.watch<QuestionBloc>().model.isLoading &&
            !context.watch<AnswerListBloc>().model.isLoading) &&
        (context.watch<QuestionBloc>().dataPoint.isNotEmpty ||
            context.watch<AnswerListBloc>().dataPoint.isNotEmpty);
  }
}
