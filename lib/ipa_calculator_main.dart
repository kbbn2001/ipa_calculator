import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ipa_calculator_calculatePageWithCSV.dart';
import 'ipa_calculator_favoritePage.dart';
import 'ipa_calculator_favorite_sqlite.dart';
import 'ipa_calculator_logPage.dart';

class BackData {
  final double? temperature;
  final double? moisture;
  final double? resultValue;

  BackData({this.temperature, this.moisture, this.resultValue});

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'moisture': moisture,
      'result_value': resultValue,
    };
  }

  //정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'BackData{temperature: $temperature, moisture: $moisture, result_value: $resultValue}';
  }
}

class ButtonIPACalculator extends StatelessWidget {
  const ButtonIPACalculator({Key? key}) : super(key: key);

  void _showIPACalculatorPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const IpaCalculator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showIPACalculatorPage(context);
      },
      child: const Text('IPA Calculator'),
    );
  }
}

class IpaCalculator extends StatefulWidget {
  const IpaCalculator({super.key});

  @override
  IpaCalculatorState createState() => IpaCalculatorState();
}



class IpaCalculatorState extends State<IpaCalculator>{
  @override
  void initState() {
    super.initState();
    // Load ads.
  }
  final _resultInputAmount = TextEditingController();
  final _resultMoisture = TextEditingController();
  final _returnInputAmount = TextEditingController();
  final _returnMoisture = TextEditingController();

  final _purifyInputIPA = TextEditingController();
  final _purifyInputWater = TextEditingController();
  final _purifyTemperature = TextEditingController();
  final _purifyMoisture = TextEditingController();
  final _newTemperature = TextEditingController();
  final _newMoisture = TextEditingController();

  final _titleName = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*
    _resultInputAmount.text = '5400';
    _resultMoisture.text = '16';
    _returnInputAmount.text = '245';
    _returnMoisture.text = '34';

    _purifyInputIPA.text = '4000';
    _purifyInputWater.text = '6';
    _purifyTemperature.text = '17';
    _purifyMoisture.text = '11.5';

    _newTemperature.text = '17';
    _newMoisture.text = '0.01';
     */

    return MaterialApp(
      title: 'Flutter Demo',
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
      home: Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('IPA calculator'),
        ),
        body: SingleChildScrollView(
          child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                          builder: ((context) {
                            if(_resultInputAmount!.text.isEmpty
                                ||  _resultMoisture!.text.isEmpty
                                ||  _returnInputAmount!.text.isEmpty
                                ||  _returnMoisture!.text.isEmpty
                                ||  _purifyInputIPA!.text.isEmpty
                                ||  _purifyInputWater!.text.isEmpty
                                ||  _purifyTemperature!.text.isEmpty
                                ||  _purifyMoisture!.text.isEmpty
                                ||  _newTemperature!.text.isEmpty
                                ||  _newMoisture!.text.isEmpty
                            ){
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
                            }
                            else{
                              return AlertDialog(
                                title: const Text("즐겨찾기 추가."),
                                content: Row(
                                  children: [
                                    Text("즐겨찾기 명 : "),
                                    Flexible(
                                      child: TextField(
                                        controller: _titleName,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final _favoriteModel = SqliteFavoriteModel();
                                        _favoriteModel.InsertFavorite(IPAFavorite(
                                            resultInputAmount : double.parse(_resultInputAmount!.text)
                                            ,resultMoisture : double.parse(_resultMoisture!.text)
                                            ,returnInputAmount : double.parse(_returnInputAmount!.text)
                                            ,returnMoisture : double.parse(_returnMoisture!.text)
                                            ,purifyInputIPA : double.parse(_purifyInputIPA!.text)
                                            ,purifyInputWater : double.parse(_purifyInputWater!.text)
                                            ,purifyTemperature : double.parse(_purifyTemperature!.text)
                                            ,purifyMoisture : double.parse(_purifyMoisture!.text)
                                            ,newTemperature : double.parse(_newTemperature!.text)
                                            ,newMoisture : double.parse(_newMoisture!.text)
                                            , log_date :  DateTime.now().toString()
                                            , title : _titleName!.text
                                        ));
                                        Navigator.of(context).pop(); //창 닫기
                                      },
                                      child: Text("저장"),
                                    ),
                                  ),
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {

                                        Navigator.of(context).pop(); //창 닫기
                                      },
                                      child: Text("취소"),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                        );
                      },
                      child: const Text('즐겨찾기 추가'),
                    ),
                    ButtonSelectFavorite(
                        resultInputAmountController : _resultInputAmount
                        , resultMoistureController : _resultMoisture
                        , returnInputAmountController : _returnInputAmount
                        , returnMoistureController : _returnMoisture
                        , newTemperatureController : _newTemperature
                        , newMoistureController : _newMoisture
                        , purifyInputIPAController : _purifyInputIPA
                        , purifyInputWaterController : _purifyInputWater
                        , purifyTemperatureController: _purifyTemperature
                        , purifyMoistureController : _purifyMoisture
                    ),

                ]

                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      )),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20), //apply padding to all four sides
                        child: Text("목표값"),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _resultInputAmount,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: '총투입량',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _resultMoisture,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '기준수분',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10)
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      )),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20), //apply padding to all four sides
                        child: Text("회수IPA"),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _returnInputAmount,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: '초기투입',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _returnMoisture,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '수분',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10)
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      )),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20), //apply padding to all four sides
                        child: Text("정제IPA"),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _purifyInputIPA,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: '초기투입',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _purifyInputWater,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: '세척수',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _purifyTemperature,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '온도',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _purifyMoisture,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '수분',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10)
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      )),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20), //apply padding to all four sides
                        child: Text("새IPA"),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _newTemperature,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '온도',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _newMoisture,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '수분',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10)
                ),
                Row(
                    children: [
                      ButtonCalculateWithCSV(
                          resultInputAmountController : _resultInputAmount
                          , resultMoistureController : _resultMoisture
                          , returnInputAmountController : _returnInputAmount
                          , returnMoistureController : _returnMoisture
                          , newTemperatureController : _newTemperature
                          , newMoistureController : _newMoisture
                          , purifyInputIPAController : _purifyInputIPA
                          , purifyInputWaterController : _purifyInputWater
                          , purifyTemperatureController: _purifyTemperature
                          , purifyMoistureController : _purifyMoisture
                      ),
                    ]
                ),
                const Row(
                    children: [
                      ButtonSelectLogs(),
                    ]
                ),
                const Row(
                  children: [
                    //adContainer,
                  ],
                ),
              ]
          ),
          ),
        ),
      ),
    );
  }
}