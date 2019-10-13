import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchResult extends StatelessWidget {
  final List results;

  SearchResult(this.results);

  Widget _searchItem(BuildContext context, int index) {
    return Card(
      elevation: 3.0,
      color: Colors.grey[150],
      margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Definition: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: results[index]['definition'].toString().replaceAll('[', '').replaceAll(']', '')),
                  ]),
            ),
            Divider(),
            RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Example: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: results[index]['example'].toString().replaceAll('[', '').replaceAll(']', '')),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(results[0]['word']),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return _searchItem(context, index);
        },
      ),
    );
  }
}
