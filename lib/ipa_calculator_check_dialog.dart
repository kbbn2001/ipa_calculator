

import 'package:flutter/material.dart';

Future<void> CheckDialog (BuildContext context){
    // TODO: implement build
    return showDialog(
      context: context,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return AlertDialog(
          //title: Text("전체 내용은 필수값입니다."),
          content: Text("전체 수치는 필수값입니다. 모든 값을 입력해주세요."),
          actions: <Widget>[
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); //창 닫기
                },
                child: Text("확인"),
              ),
            ),
          ],
        );
      }),
    );
  }
