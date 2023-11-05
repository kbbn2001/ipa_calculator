import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ipa_calculator_favorite_sqlite.dart';
import 'ipa_calculator_log_sqlite.dart';

class ButtonSelectFavorite extends StatelessWidget {

  final TextEditingController resultInputAmountController;
  final TextEditingController resultMoistureController;
  final TextEditingController returnInputAmountController;
  final TextEditingController returnMoistureController;
  final TextEditingController purifyInputIPAController;
  final TextEditingController purifyInputWaterController;
  final TextEditingController purifyTemperatureController;
  final TextEditingController purifyMoistureController;
  final TextEditingController newTemperatureController;
  final TextEditingController newMoistureController;

  const ButtonSelectFavorite({Key? key
    , required this.resultInputAmountController
    , required this.resultMoistureController
    , required this.returnInputAmountController
    , required this.returnMoistureController
    , required this.purifyInputIPAController
    , required this.purifyInputWaterController
    , required this.purifyTemperatureController
    , required this.purifyMoistureController
    , required this.newTemperatureController
    , required this.newMoistureController
  }) : super(key: key);

  void _showFavoritePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoritePage(
          resultInputAmountController : resultInputAmountController
          , resultMoistureController: resultMoistureController
          , returnInputAmountController: returnInputAmountController
          , returnMoistureController: returnMoistureController
          , newTemperatureController: newTemperatureController
          , newMoistureController: newMoistureController
          , purifyInputIPAController: purifyInputIPAController
          , purifyInputWaterController: purifyInputWaterController
          , purifyTemperatureController : purifyTemperatureController
          , purifyMoistureController: purifyMoistureController
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showFavoritePage(context);
      },
      child: const Text('즐겨찾기 불러오기'),
    );
  }
}

class FavoritePage extends StatefulWidget {
  TextEditingController resultInputAmountController;
  TextEditingController resultMoistureController;
  TextEditingController returnInputAmountController;
  TextEditingController returnMoistureController;
  TextEditingController purifyTemperatureController;
  TextEditingController purifyMoistureController;
  TextEditingController newTemperatureController;
  TextEditingController newMoistureController;
  TextEditingController purifyInputIPAController;
  TextEditingController purifyInputWaterController;

  FavoritePage( {Key? key
    , required this.resultInputAmountController
    , required this.resultMoistureController
    , required this.returnInputAmountController
    , required this.returnMoistureController
    , required this.newTemperatureController
    , required this.newMoistureController
    , required this.purifyInputIPAController
    , required this.purifyInputWaterController
    , required this.purifyTemperatureController
    , required this.purifyMoistureController
  }) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageStatus(
      resultInputAmountController
      , resultMoistureController
      , returnInputAmountController
      , returnMoistureController
      , newTemperatureController
      , newMoistureController
      , purifyInputIPAController
      , purifyInputWaterController
      ,purifyTemperatureController
      , purifyMoistureController
  );
}



class _FavoritePageStatus extends State<FavoritePage> {
  TextEditingController? resultInputAmountController;
  TextEditingController? resultMoistureController;
  TextEditingController? returnInputAmountController;
  TextEditingController? returnMoistureController;
  TextEditingController? newTemperatureController;
  TextEditingController? newMoistureController;
  TextEditingController? purifyInputIPAController;
  TextEditingController? purifyInputWaterController;
  TextEditingController? purifyTemperatureController;
  TextEditingController? purifyMoistureController;

  _FavoritePageStatus(
      this.resultInputAmountController
      , this.resultMoistureController
      , this.returnInputAmountController
      , this.returnMoistureController
      , this.newTemperatureController
      , this.newMoistureController
      , this.purifyInputIPAController
      , this.purifyInputWaterController
      , this.purifyTemperatureController
      , this.purifyMoistureController
      );

  @override
  Widget build(BuildContext context) {

    final double dataWidth = 200;
    final double dataWidthLarge = 150;
    final double headerHeight = 50;
    final double dataHeight = 50;

    final ScrollController horizontalScroll = ScrollController();
    final ScrollController verticalScroll = ScrollController();

    final model = SqliteFavoriteModel();


    return Scaffold(
        appBar: AppBar(
          title: const Text('즐겨찾기 목록'),
        ),
        body: Center(
            child: AdaptiveScrollbar(
                controller: verticalScroll,
                width: 5,
                child: AdaptiveScrollbar(
                    controller: horizontalScroll,
                    width: 5,
                    position: ScrollbarPosition.bottom,
                    underSpacing: const EdgeInsets.only(bottom: 5),
                    child: SingleChildScrollView(
                      controller: horizontalScroll,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                          width: 900,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: headerHeight,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('즐겨찾기 명'),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Scrollbar (
                                    child: FutureBuilder(
                                      future: model.SelectFavorite(),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                        if(snapshot.hasData) {
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              padding: const EdgeInsets.all(8),
                                              itemCount: snapshot.data.length,
                                              itemBuilder:(BuildContext context, int index){
                                                return SizedBox(
                                                    height: dataHeight,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['title']}'),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                print('${snapshot.data[index]['title']}');
                                                                print('${snapshot.data[index]['idx']}');
                                                                resultInputAmountController?.text = '${snapshot.data[index]['resultInputAmount']}';
                                                                resultMoistureController?.text = '${snapshot.data[index]['resultMoisture']}';
                                                                returnInputAmountController?.text = '${snapshot.data[index]['returnInputAmount']}';
                                                                returnMoistureController?.text = '${snapshot.data[index]['returnMoisture']}';
                                                                newTemperatureController?.text = '${snapshot.data[index]['newTemperature']}';
                                                                newMoistureController?.text = '${snapshot.data[index]['newMoisture']}';
                                                                purifyInputIPAController?.text = '${snapshot.data[index]['purifyInputIPA']}';
                                                                purifyInputWaterController?.text = '${snapshot.data[index]['purifyInputWater']}';
                                                                purifyTemperatureController?.text = '${snapshot.data[index]['purifyTemperature']}';
                                                                purifyMoistureController?.text = '${snapshot.data[index]['purifyMoisture']}';
                                                                Navigator.pop(context);

                                                              }, child: Text('불러오기'),
                                                            ),
                                                          ],
                                                        )

                                                      ],
                                                    )
                                                );

                                              }
                                          );
                                        }
                                        else{
                                          return const Text('no data');
                                        }
                                      },
                                    ),
                                  )
                              ),
                              //adContainer,
                            ],
                          )
                      ),
                    )))


        )
    );
  }
}