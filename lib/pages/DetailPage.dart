import 'package:flutter/material.dart';
import 'package:flutterapp/models/detail.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> course;
  List<Chapter> chapter = [];
  bool isLoading = true;
  final fNumber = NumberFormat('#,###');

  _getData(int id) async {
    var url = Uri.parse('https://api.codingthailand.com/api/course/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      final Detail detail = Detail.fromJson(convert.jsonDecode(response.body));
      setState(() {
        chapter = detail.chapter;
        isLoading = false;
      });
    } else {
      //error 400, 500
      print('error from backend ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    //print('insit detail page');
    Future.delayed(Duration.zero, () {
      //print('insit delayed');
      _getData(course['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('build detail page');
    course = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('${course['title']}'),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(chapter[index].chTitle),
                      subtitle: Text(chapter[index].chDateadd),
                      trailing: Chip(
                        label: Text('${fNumber.format(chapter[index].chView)}'),
                        backgroundColor: Colors.redAccent,
                      ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: chapter.length));
  }
}
