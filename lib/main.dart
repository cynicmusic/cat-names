import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

//void main() => runApp(new MyApp());
void main() async {
  var myCats = new MyCats();
  await myCats.loadMyCatsFromTextFile();
  runApp(new MyApp());
}

class MyCats {
  static var catNames = "";
  static var catSuffixes = "";
  static var catList = <String>[];
  static var catSuffixList = <String>[];
  static var fullCatList = <String>[];

  var random = new Random();

  loadMyCatsFromTextFile() async {
    await loadCatNames();
    await parseCatNames();
  }

  loadCatNames() async {
    try {
      catNames = await rootBundle.loadString('assets/cats.txt');
      catSuffixes = await rootBundle.loadString('assets/suffixes.txt');
    } catch (e) {
      print("THERE WAS AN ERROR LOADING CATS $e !!!");
    }
  }

  parseCatNames() {
    catList = catNames.split("\n");
    catList.shuffle(random);
    catSuffixList = catSuffixes.split("\n");

    catList.forEach((catName) => conconctCatName(catName));
  }

  conconctCatName(catName) {
    var catSuffix = catSuffixList[random.nextInt(catSuffixList.length - 1)];
    var fullCatName = "";

    if (random.nextInt(5) == 1) {
      fullCatName = "$catName The $catSuffix";
    } else {
      fullCatName = "$catName $catSuffix";
    }
    fullCatList.add(fullCatName);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      title: 'Cats',
      home: new RandomCats(),
    
    );
  }
}

class RandomCats extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomCats> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  var catList = MyCats.fullCatList;

  @override
  void initState() {
    super.initState();
  }

  RandomWordsState() {
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        print("There are ${catList.length} cats!!!");
        
        if (i.isOdd) return new Divider();
        final index = i ~/ 2;
        if (index >= catList.length) {
        }

        return _buildRow(i);
      }

    );
  } // Widget

  Widget _buildRow(index) {
    return new ListTile(
      title: new Text(
        catList[index],
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (appBar: new AppBar(
      title: new Text('Kittens'),
    ),
      body: _buildSuggestions(),
    );
  }

} // class