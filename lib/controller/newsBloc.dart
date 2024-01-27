import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:clean_architecture/model/newsInfo.dart';

enum NewsAction { Fetch, Delete }

class NewsBloc {
  final _statStreamController = StreamController<List<Article>>();

  StreamSink<List<Article>> get _newsSink => _statStreamController.sink;
  Stream<List<Article>> get newsStream => _statStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();

  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get eventStream => _eventStreamController.stream;

  NewsBloc() {
    eventStream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          var repsonse = await getNews();
          _newsSink.add(repsonse.articles);
        } catch (e) {
          _newsSink.addError("Something went wrong");
        }
      } else if (event == NewsAction.Delete) {}
    });
  }
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse(
          "https://newsapi.org/v2/everything?q=tesla&from=2023-04-17&sortBy=publishedAt&apiKey=3a4ee84a8de54baca51ddea4554880a8"));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        print("chuecjbfdnfndjd");

        newsModel = NewsModel.fromJson(jsonMap);
        print("fmrmfirfiorjfi");

        print("0000000000000000" + newsModel);
      }
    } on Exception { 
      return newsModel;
    }

    return newsModel;
  }
}
