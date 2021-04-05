import 'package:blusalt_mini_app/blocs/create/create_cubit.dart';
import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'custom_button.dart';

class DialogCreate extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final bool isAnswer;
  final Question? question;

  DialogCreate({Key? key, required this.isAnswer, this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textEditingController.addListener(() {
      injector.get<CreateCubit>().updateText(textEditingController.text);
    });
    return BlocProvider<CreateCubit>.value(
      value: injector.get<CreateCubit>(),
      child: BlocConsumer<CreateCubit, CreateState>(
        listener: (context, state) {
          _handleListenerStateChanges(state);
        },
        builder: (context, state) => Dialog(
          backgroundColor: Theme.of(context).cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width - 32,
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.symmetric(
              vertical: SizeConfig.paddingSizeVertical8,
              horizontal: SizeConfig.paddingSizeHorizontal16,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.paddingSizeVertical16,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '${isAnswer ? 'Answer Question' : 'Create Question'}',
                      style:
                          Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                                color: accentColor,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.textSize22,
                              ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.paddingSizeVertical20,
                  ),
                  if (isAnswer)
                    Text(
                      '${question!.question}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryTextColorScheme,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.textSize16,
                          ),
                    ),
                  if (isAnswer)
                    SizedBox(
                      height: SizeConfig.paddingSizeVertical12,
                    ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: textEditingController,
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.start,
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: _getHintText(),
                        labelStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryTextColorScheme,
                                  fontWeight: FontWeight.w700,
                                ),
                        helperStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryTextColorScheme,
                                  fontWeight: FontWeight.w700,
                                ),
                        focusColor: accentColor,
                        hoverColor: accentColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Theme.of(context)
                                .colorScheme
                                .dividerColorScheme,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Theme.of(context)
                                .colorScheme
                                .dividerColorScheme,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                          borderSide: BorderSide(
                            width: 0.5,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  CustomButton(
                    buttonText:
                        '${isAnswer ? 'Upload Answer' : 'Create Question'}',
                    isEnabled: context
                        .watch<CreateCubit>()
                        .createUIModel
                        .text
                        .trim()
                        .isNotEmpty,
                    isLoading:
                        context.watch<CreateCubit>().createUIModel.isLoading,
                    onPressed: () {
                      if (textEditingController.text.trim().isNotEmpty)
                        context.read<CreateCubit>().create(
                            question != null ? question!.id : '', isAnswer);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleListenerStateChanges(CreateState state) {
    if (state is CreateErrorState) {
      Fluttertoast.showToast(
          msg: 'Error posting ${isAnswer ? 'answer' : 'question'}');
    }
  }

  _getHintText() {
    return isAnswer
        ? 'Input your answer here, answers should be easy to understand'
        : 'Start your question with "What", "How", "Why", etc.';
  }
}
