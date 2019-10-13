import 'package:e2e_dictionary/pages/search_result.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String searchQuery = '';

  Widget _searchBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3.0,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Icon(Icons.search),
          ),
          Expanded(
            flex: 5,
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Word or Phrase",
                border: InputBorder.none,
              ),
              autocorrect: false,
              maxLines: 1,
              onSaved: (String value) {
                searchQuery = value;
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return "This can't be empty";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchButton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        child: Center(
          child: Text(
            "Search",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.3,
      ),
      onPressed: () {
        _globalKey.currentState.save();
        if (!_globalKey.currentState.validate()) {
          return;
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
        http.get(
            'https://mashape-community-urban-dictionary.p.rapidapi.com/define?term=' +
                searchQuery,
            headers: {
              "RapidAPI+Project": "default-application_3935317",
              "X-RapidAPI-Host":
                  "mashape-community-urban-dictionary.p.rapidapi.com",
              "X-RapidAPI-Key":
                  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
            }).then((http.Response response) {
          Navigator.pop(context);
          Map<String, dynamic> responseBody = json.decode(response.body);

          List data = responseBody['list'];
          if (data.length == 0) {
            Fluttertoast.showToast(
              msg: "No result found!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return SearchResult(data);
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _searchBox(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              _searchButton(context)
            ],
          ),
        ),
      ),
    );
  }
}
