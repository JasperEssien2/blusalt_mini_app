import 'package:blusalt_mini_app/constants.dart';

class _Question {
  final askQuestion = Constants.baseUrl + '/question';
  final questionList = Constants.baseUrl + '/question';
  final searchQuestion = Constants.baseUrl + '/user/text/search';
  final voteQuote = Constants.baseUrl + '/question/vote';
}

class _Answer {
  final answer = Constants.baseUrl + '/answer';
  final answerList = Constants.baseUrl + '/answer';
  final answerSearch = Constants.baseUrl + '/answer/text/search';
}

class _Authentication {
  final signUp = Constants.baseUrl + '/user/signup';
  final signIn = Constants.baseUrl + '/user/signin';
  final searchUser = Constants.baseUrl + '/user/text/search';
}

final authenticationEndpoint = _Authentication();
final answerEndpoint = _Answer();
final questionEnpoint = _Question();
