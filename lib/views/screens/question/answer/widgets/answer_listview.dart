import 'package:blusalt_mini_app/blocs/question/question_bloc.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import 'item_answer.dart';

class QuestionListView extends StatelessWidget {
  final String? filter;
  const QuestionListView({
    Key? key,
    this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        injector.resetLazySingleton(
          instance: QuestionBloc,
        );
        injector.get<QuestionBloc>().add(LoadQuestionList());
        return injector.get<QuestionBloc>();
      },
      child: BlocConsumer<QuestionBloc, QuestionState>(
        listener: (context, state) {
          _handleStateListenerChange(state);
        },
        builder: (context, state) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return context.watch<QuestionBloc>().model.isLoading
                ? Shimmer.fromColors(
                    child: ItemQuestionShimmer(),
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                  )
                : ItemQuestion(
                    question: context.watch<QuestionBloc>().questions[index],
                    index: index,
                  );
          },
          itemCount: context.watch<QuestionBloc>().model.isLoading
              ? 7
              : context.watch<QuestionBloc>().questions.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: SizeConfig.paddingSizeVertical16,
              width: SizeConfig.screenWidth,
              color: Theme.of(context).cardColor,
            );
          },
        ),
      ),
    );
  }

  void _handleStateListenerChange(QuestionState state) {
    if (state is QuestionListErrorState)
      Fluttertoast.showToast(msg: state.errorModel.errorMessage);
  }
}
