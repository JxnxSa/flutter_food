// import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:flutter_food/models/api_result.dart';
import 'package:flutter_food/models/food_item.dart';
import 'package:flutter_food/services/api.dart';
// import 'package:http/http.dart' as http;

// const apiBaseUrl = 'https://cpsu-test-api.herokuapp.com';
// const apiGetFoods = '$apiBaseUrl/foods222';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  List<FoodItem>? _foodList; //? ให้เป็น  null ได้
  var _isLoading = false;
  String? _errMessage;

  @override
  void initState() {
    super.initState();
    _fetchFoodData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FOOD LIST'),
      ),
      body: Column(
        children: [
          /*Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _fetchFoodData,
              child: const Text('GET FOOD DATA'),
            ),
          ),*/
          Expanded(
            child: Stack(
              children: [
                if (_foodList != null)
                  ListView.builder(
                    itemBuilder: _buildListItem,
                    itemCount: _foodList!.length,
                  ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (_errMessage != null && !_isLoading)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(_errMessage!),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _fetchFoodData();
                            },
                            child: const Text('RETRY'))
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*void _handleClickButton() {
    var response = http.get(Uri.parse(apiGetFoods));
    //Future<http.Response> response = http.get(Uri.parse(apiGetFoods));
    response.then((data) { //callback
      // print(data);
      // print(data.statusCode);
      print(data.body); //ต้องรอapiส่งข้อมูลกลับมาก่อน

    });
    print('123'); //print 123 ก่อน data.body // ทำทันทีเลย
  }*/

  void _fetchFoodData() async {
    setState(() {
      //_foodList = null;
      _isLoading = true;
    });

    try {
      var data = await Api().fetch('foods');
      setState(() {
        _foodList =
            data.map<FoodItem>((item) => FoodItem.fromJson(item)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errMessage = e.toString();
        _isLoading = false;
      });
    }

    // call ไปยัง api
    /*  var response = await http.get(Uri.parse(apiGetFoods));
    // print(response.statusCode);
    // print(response.body);
    //print('123'); //ปริ้นตามลำดับจากข้างบน

    if (response.statusCode == 200) {
      //แปลง Json type ไปเป็น Dart type
      var output = jsonDecode(response.body);
      var apiResult = ApiResult.fromJson(output);
      if (apiResult.status == 'ok') {
        //ปั้น model ข้อมูลอาหารแต่ละข้อมูล
        setState((){
          _foodList = apiResult.data
              .map<FoodItem>((item) => FoodItem.fromJson(item))
              .toList();
          _isLoading = false;
        });

      } else {
        // handle error
        setState(() {
          _isLoading = false;
          _errMessage = apiResult.message;
        });
      }
    } else {
      // handle error
      setState(() {
        _isLoading = false;
        _errMessage = 'Network connection failed';
      });
    }

    //print(output['status']);
    //print(output['message']);
    //print(output['data']);

    setState(() {
      //_foodList = [];

      /*_foodList = output['data'].map<FoodItem>((item) {
        return FoodItem.fromJson(item);
      }).toList();*/

      /*output['data'].forEach((item) {
        //print(item['name'] + ' ราคา ' + item['price'].toString());
        /*var foodItem = FoodItem(
          id: item['id'],
          name: item['name'],
          price: item['price'],
          image: item['image'],
        );*/
        var foodItem = FoodItem.fromJson(item);
        _foodList!.add(foodItem);
      });*/
    });

  */
  }

  Widget _buildListItem(BuildContext context, int index) {
    var foodItem = _foodList![index];
    return Card(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(
              foodItem.image,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(foodItem.name),
          ],
        ),
      ),
    );
  }
}
