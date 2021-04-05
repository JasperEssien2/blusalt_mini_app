import 'package:blusalt_mini_app/blocs/answer/answer_list_bloc.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import 'item_answer.dart';

class AnswerListView extends StatelessWidget {
  final String? filter;
  final String questionId;
  const AnswerListView({
    Key? key,
    this.filter,
    required this.questionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return BlocProvider.value(
      value: injector.get<AnswerListBloc>(),
      child: BlocConsumer<AnswerListBloc, AnswerListState>(
        listener: (context, state) {
          _handleStateListenerChange(state);
        },
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.05,
              color: themeData.cardColor,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.paddingSizeVertical16),
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.paddingSizeVertical20),
              alignment: Alignment.centerLeft,
              child: Text(
                '${context.watch<AnswerListBloc>().answers.length} Answer(s)',
                style: themeData.textTheme.bodyText2!.copyWith(
                  color: themeData.colorScheme.secondaryTextColorScheme,
                  fontSize: SizeConfig.textSize16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return context.watch<AnswerListBloc>().model.isLoading
                      ? Shimmer.fromColors(
                          child: ItemAnswerShimmer(),
                          baseColor: Colors.grey,
                          highlightColor: Colors.grey[100]!,
                          enabled: true,
                        )
                      : ItemAnswer(
                          answer:
                              context.watch<AnswerListBloc>().answers[index],
                          index: index,
                        );
                },
                itemCount: context.watch<AnswerListBloc>().model.isLoading
                    ? 7
                    : context.watch<AnswerListBloc>().answers.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: SizeConfig.paddingSizeVertical16,
                    width: SizeConfig.screenWidth,
                    color: Theme.of(context).cardColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleStateListenerChange(AnswerListState state) {
    if (state is AnswerListErrorState)
      Fluttertoast.showToast(msg: state.errorModel.errorMessage);
  }
}
