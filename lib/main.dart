import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ipa_calculator_main.dart';
import 'ipa_error_main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {

  //server time
  /*
  var dio = Dio();
  final response = await dio.get('http://www.naver.com');
  String dateString = response.headers['date'].toString(); //Sun, 27 Aug 2023 02:34:35 GMT
  dateString = dateString.replaceAll('[', '');
  dateString = dateString.replaceAll(']', '');
  final f = DateFormat('E, d MMM y H:m:s z');
  var serverDate = f.parse(dateString);
  */

  //local time
  var serverDate = DateTime.now();
  var baseDate = DateTime(2023,12,31); //기준날짜

  if(baseDate.compareTo(serverDate) >= 1){
    print("normal");
    runApp(MyApp());
  }
  else{
    print("block");
    runApp(MyAppFalse());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
        ),
        title: 'IPA',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('IPA'),
            ),
            body: const Center(
                child: Column(
                    children: [
                      ButtonIPACalculator(),
                      ButtonIPAError()
                    ]
                )
            )
        )

    );
  }
}


class MyAppFalse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
        ),
        title: 'IPA',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('IPA'),
            ),
            body: const Center(
                child: Column(
                    children: [
                      Text("실행 할 수 없습니다. 관리자에게 문의하세요")
                    ]
                )
            )
        )

    );
  }
}
