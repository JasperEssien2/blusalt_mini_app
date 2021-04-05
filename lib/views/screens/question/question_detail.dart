import 'package:blusalt_mini_app/blocs/answer/answer_list_bloc.dart';
import 'package:blusalt_mini_app/blocs/user/user_bloc_cubit.dart';
import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/app_util.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/views/components/dialog_create.dart';
import 'package:blusalt_mini_app/views/components/item_appbar.dart';
import 'package:blusalt_mini_app/views/screens/question/answer/widgets/answer_listview.dart';
import 'package:flutter/material.dart';

class QuestionDetailPage extends StatefulWidget {
  const QuestionDetailPage({Key? key}) : super(key: key);
  @override
  _QuestionDetailPageState createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  Question? question;

  @override
  void didChangeDependencies() {
    question = (ModalRoute.of(context)!.settings.arguments as Question);
    if (question == null) Navigator.pop(context);
    injector
        .get<AnswerListBloc>()
        .add(LoadAnswerList(questionId: question!.id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig.init(context);
    print(SizeConfig.toString_());
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        child: GradientAppBar(
          height: _appbarHeight(size),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: SizeConfig.heightSize30,
              ),
              AppbarContent(
                question: question!,
              ),
            ],
          ),
        ),
        preferredSize: Size(size.width, _appbarHeight(size)),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: AnswerListView(
          questionId: question!.id,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAnswerDialog();
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

  void _showAddAnswerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        var textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Theme.of(context).colorScheme.secondaryTextColorScheme,
              fontSize: SizeConfig.textSize18,
              fontWeight: FontWeight.w500,
            );
        return injector.get<UserBlocCubit>().response.id == 'anonymous'
            ? AppUtil.authenticateDialog(context, textStyle)
            : DialogCreate(
                isAnswer: true,
                question: question,
              );
      },
    );
  }
}

class AppbarContent extends StatelessWidget {
  final Question question;
  const AppbarContent({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
              left: 25.0, top: SizeConfig.paddingSizeVertical16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                customBorder: CircleBorder(),
                child: Container(
                  height: 24.0,
                  width: 24.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Text(
                ' ${question.question}',
                style: themeData.textTheme.headline6!.copyWith(
                  color: Colors.white,
                  fontSize: SizeConfig.textSize18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.paddingSizeVertical20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Tooltip(
              message: 'Write Answer',
              child: Icon(
                Icons.edit,
                size: 24.0,
                color: Colors.white,
                semanticLabel: 'Write Answer',
              ),
            ),
            Tooltip(
                message: 'Share Question',
                child: Icon(
                  Icons.share,
                  size: 24.0,
                  color: Colors.white,
                  semanticLabel: 'Share Question',
                )),
            Tooltip(
                message: 'Follow user',
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 24.0,
                  color: Colors.white,
                  semanticLabel: 'Follow user',
                )),
            Tooltip(
                message: 'Search Answers',
                child: Icon(
                  Icons.search,
                  size: 24.0,
                  color: Colors.white,
                  semanticLabel: 'Search Answer',
                )),
          ],
        ),
      ],
    );
  }
}
