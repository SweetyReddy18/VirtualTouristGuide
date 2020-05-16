import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeachAppBarRecipe',
      color: Colors.white,
      home: SearchAppBarRecipe(title: 'SeachAppBarRecipe'),
    );
  }
}

class SearchAppBarRecipe extends StatefulWidget {
  SearchAppBarRecipe({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchAppBarRecipeState createState() => _SearchAppBarRecipeState();
}

class _SearchAppBarRecipeState extends State<SearchAppBarRecipe> {
  final List<String> kWords;
  _SearchAppBarDelegate _searchDelegate;

  _SearchAppBarRecipeState()
      : kWords = [
          'CharMinar',
          'BirlaMandir',
          'Golcondafort',
          'Nehru Zoological Park',
          'NTR garden',
          'Qutb Shahi Tombs',
          'Salarjung Museum',
          'Hussain Sagar',
          'Ramoji Film City',
          'Mecca Masjid'
        ]..sort(
            (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
          ),
        super();

  @override
  void initState() {
    super.initState();
    _searchDelegate = _SearchAppBarDelegate(kWords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Tourist Attractions',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            color: Colors.black,
            icon: const Icon(Icons.search),
            //Don't block the main thread
            onPressed: () {
              showSearchPage(context, _searchDelegate);
            },
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: kWords.length,
          itemBuilder: (context, idx) => ListTile(
            title: Text(kWords[idx]),
            onTap: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.white,
                  content: Text(
                    "Click the Search action",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  action: SnackBarAction(
                    label: 'Search',
                    textColor: Colors.black,
                    onPressed: () {
                      showSearchPage(context, _searchDelegate);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void showSearchPage(
      BuildContext context, _SearchAppBarDelegate searchDelegate) async {
    final String selected = await showSearch<String>(
      context: context,
      delegate: searchDelegate,
    );

    if (selected != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Time taken to visit $selected is 2hours'),
        ),
      );
    }
  }
}

//Search delegate
class _SearchAppBarDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  _SearchAppBarDelegate(List<String> words)
      : _words = words,
        //pre-populated history of words
        _history = <String>[
          'CharMinar',
          'BirlaMandir',
          'Golcondafort',
          'Nehru Zoological Park',
          'NTR garden',
          'Qutb Shahi Tombs',
          'Salarjung Museum',
          'Hussain Sagar',
          'Ramoji Film City',
          'Mecca Masjid'
        ],
        super();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  String timeTakenToVisit(String q) {
    if (q == 'CharMinar') return '1 hour is ';
    if (q == 'BirlaMandir')
      return '1 - 2 hours are';
    else if (q == 'Golcondafort')
      return '2 - 3 hours are';
    else if (q == 'Nehru Zoological Park')
      return '3 - 4 hours are';
    else if (q == 'NTR garden')
      return '2 - 3 hours are';
    else if (q == 'Qutb Shahi Tombs')
      return '2 - 3 hours are';
    else if (q == 'Salarjung Museum')
      return '4 hours are';
    else if (q == 'Hussain Sagar')
      return 'Around 1 hour is';
    else if (q == 'Ramoji Film City')
      return '2 full days are';
    else if (q == 'Mecca Masjid')
      return '1 - 2 hours are';
    else
      return 'Sorry, data unavailable!';
  }

  @override
  Widget buildResults(BuildContext context) {
    print(query);
    var timeTaken = timeTakenToVisit(query);
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 130.0,
                backgroundImage: AssetImage('images/$query.jpg'),
              ),
              Text(
                '$timeTaken taken to Visit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Inconsolata',
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  //print(query);
                  this.close(context, this.query);
                },
                child: Text(
                  this.query,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Inconsolata',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _WordSuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        print(suggestion);
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          : IconButton(
              icon: const Icon(Icons.mic),
              tooltip: 'Voice input',
              onPressed: () {
                this.query = '';
              },
            ),
    ];
  }
}

class _WordSuggestionList extends StatelessWidget {
  const _WordSuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
