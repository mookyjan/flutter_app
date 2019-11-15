import 'package:english_words/english_words.dart';
import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords>{

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = Set<WordPair>();

  Widget _buildSuggestions(){
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context,i){
          if(i.isOdd) return Divider() ; /*2*/
          final index = i ~/ 2; /*3*/
          if(index>= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10)) ; /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return Container(
      color: Colors.amberAccent[200],
      child: ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        subtitle: Text(
          pair.asCamelCase,
          style: TextStyle(
            color: Colors.red[300],
            fontStyle: FontStyle.italic,
          ),
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.account_circle),
          title: Text('Startup Name Generator'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list),onPressed: _pushSaved),
          ],
        ),
        body: _buildSuggestions()
    );
  }


  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair){
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
          );

          final List<Widget> divided = ListTile
          .divideTiles(context: context,
              tiles: tiles)
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text("Saved Suggestions"),
            ),
            body: ListView(children: divided,),
          );

        }
      )
    );
  }

}

class RandomWords extends StatefulWidget {

  @override
  RandomWordsState createState() => RandomWordsState();

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final wordPair = WordPair.random();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(wordPair.asPascalCase),
          ],

        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
