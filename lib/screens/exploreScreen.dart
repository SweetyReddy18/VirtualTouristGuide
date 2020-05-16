import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchAppBarRecipeState createState() => _SearchAppBarRecipeState();
}

class _SearchAppBarRecipeState extends State<ExploreScreen> {
  final List<String> kWords;
  _SearchAppBarDelegate _searchDelegate;

  //Initializing with sorted list of english words
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
        title: Text('Tourist Attractions',
            style: TextStyle(
              color: Colors.black,
            )),
        actions: <Widget>[
          //Adding the search widget in AppBar
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
        //Displaying all English words in list in app's main page
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

  //Shows Search result
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

  // Setting leading icon for the search bar.
  //Clicking on back arrow will take control to main page
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

  String infoAboutThatPlace(String q) {
    if (q == 'CharMinar')
      return 'The Charminar constructed by Muhammad Quli Qutb Shah in 1591,is a monument and mosque.The landmark has become known globally as a symbol of Hyderabad and is listed among the most recognized structures in India. It is incorporated as the Emblem of Telangana.Its long history includes the existence of a mosque on its top floor. While both historically and religiously significant,it is also known for its popular and busy local markets surrounding the structure, and has become one of the most frequented tourist attractions.It is also a site of numerous festival celebrations, such as Eid-ul-adha and Eid al-Fitr';
    if (q == 'BirlaMandir')
      return 'Birla Mandir is a Hindu temple, built on a 280 feet (85 m) high hillock called Naubath Pahad on a 13 acres plot(53,000 m2). The construction took 10 years & was opened in 1976 by Swami Ranganathananda of Ramakrishna Mission. The temple was constructed by Birla Foundation.The temple manifests a blend of Dravidian, Rajasthani and Utkala architectures. It is constructed of 2000 tons of pure white marble. The granite idol of presiding deity Lord Venkateswara is about 11 ft tall and a carved lotus forms an umbrella on the top.Birla temples are open to all';
    else if (q == 'Golcondafort')
      return 'Golconda was originally known as Mankal.Golconda Fort was first built by the Kakatiyas as part of their western defenses along the lines of the Kondapalli Fort. The city and the fortress were built on a granite hill that is 120m (390 ft) high, surrounded by massive battlements. The fort was rebuilt and strengthened by Rani Rudrama Devi and her successor Prataparudra.Later, the fort came under the control of the Kamma Nayakas, who defeated the Tughlaqi army occupying Warangal.It was ceded by Kamma king Musunuri Kapaya Nayaka to the Bahmani Sultanate as part of a treaty in 1364.';
    else if (q == 'Nehru Zoological Park')
      return 'Nehru Zoological Park is a zoo located near Mir Alam Tank in Hyderabad. It is one of the most visited destinations in Hyderabad.The Park was established in vide G.O.Ms. No.247, dated 26 October 1959 and opened to the public on 6 October 1963.The Park is run by forest department of Telangana & is named after the first Prime Minister of India, Jawaharlal Nehru. The zoo occupies 380 acres. Nearly 100 species of birds,animals & reptiles are housed at the zoo.The nocturnal house at the zoo artificially reverses night and day for the animals so that nocturnal animals are active while visitors are at the zoo.';
    else if (q == 'NTR garden')
      return 'NTR Gardens is a small public, urban park of 36 acres adjacent to Hussain Sagar lake in Hyderabad.In 1999, a land of 5 acres from a 55-acre plot was utilized for erecting a memorial for N.T.Rama Rao, the former Chief Minister of unbifurcated Andhra Pradesh. It was inaugurated by N.Chandrababu Naidu. It was planned to further expand this area by constructing a museum about N.T.Rama Rao. This memorial was a part of the Buddha Purnima Project that was being handled by Hyderabad Urban Development Authority for the beautification and development of the Hussain Sagar lake';
    else if (q == 'Qutb Shahi Tombs')
      return 'The Qutb Shahi Tombs are located in the Ibrahim Bagh in Hyderabad.They contain the tombs and mosques built by the various kings of the Qutb Shahi dynasty.During the Qutb Shahi period, these tombs were held in great veneration. But after their reign, the tombs were neglected until Sir Salar Jung III ordered their restoration in the early 19th century. A garden was laid out, and a compound wall was built. Once again, the tomb-garden of the Qutb Shahi family became a place of serene beauty. All except the last of the Qutb Shahi sultans lie buried here.';
    else if (q == 'Salarjung Museum')
      return 'The Salar Jung Museum is an art museum located at Dar-ul-Shifa in Hyderabad.It is one of the three National Museums of India.[1] Originally a private art collection of the Salar Jung family, it was endowed to the nation after the death of Salar Jung III. It was inaugurated on 16 December 1951.It has a collection of sculptures, paintings, carvings, textiles, manuscripts, ceramics, metallic artifacts, carpets, clocks, and furniture from Japan, China, Burma, Nepal, India, Persia, Egypt, Europe, and North America. It is one of the largest museums in the world.';
    else if (q == 'Hussain Sagar')
      return 'Hussain Sagar is a heart-shaped lake in Hyderabad, Telangana, built by Ibrahim Quli Qutb Shah in 1563. It is spread across an area of 5.7 square kilometers and is fed by the River Musi. A large monolithic statue of the Gautama Buddha, erected in 1992, stands on Gibraltar Rock in the middle of the lake. It also separates the city centre of Hyderabad from its neighborhood Secunderabad.The maximum depth of the lake is 32 feet.Hussain Sagar was built across a tributary of the river Musi river in 1563 by Ibrahim Quli Qutb Shah. The lake was named after Hussain Shah Wali, who helped to design it.';
    else if (q == 'Ramoji Film City')
      return 'The Ramoji Film City in India is located in Hyderabad. Spread over 1666 acres, it is the largest integrated film city in the world and as such has been certified by the Guinness World Records as the largest studio complex in the world. It was built by Telugu film producer Ramoji Rao in 1996.Film City EntranceIt is also a popular tourism and recreation centre, containing natural and artificial attractions including an amusement park. Around 1.5 million tourists visit the place every year.The film city is the brainchild of film producer Ramoji Rao, who wanted to build a studio similar to the ones in Hollywood.';
    else if (q == 'Mecca Masjid')
      return ' Mecca Masjid or Makkah Masjid was built during the reign of Muhammad Quli Qutb Shah, the fifth Qutb Shahi Sultan of Golconda (now Hyderabad). The three arched facades[dubious – discuss] have been carved from a single piece of granite, which took five years to quarry. More than 8,000 workers were employed to build the mosque. Muhammad Quli Qutb Shah personally laid the foundation stone and constructed it. The construction was abandoned after the death of the Emperor.It is one of the largest mosques in India with a capacity of 20,000.The mosque was built between the 16th &17th centuries.';
    else
      return 'Sorry, data unavailable!';
  }

  String openingClosingTime(String q) {
    if (q == 'CharMinar')
      return '9:30 AM – 5:30 PM\nEntery fee:\nRupees.5 per person for Indians\nnRupees.100 per person for Foreign Tourists';
    if (q == 'BirlaMandir')
      return '7:00 AM – 12:00 PM\n3:00 PM – 9:00 PM\nEntery fee: FREE';
    else if (q == 'Golcondafort')
      return '9:00 AM - 5:30 PM\nClosed on Mondays.\nEntery fee:\nRupees.15 per person for Indians\nRupees.200 per person for Foreign Tourists';
    else if (q == 'Nehru Zoological Park')
      return '8:00 AM - 5:00 PM\nClosed on Mondays.\nEntery fee during week days:\nRupees.50 per adult\nRupees.30 per Child (3 to 10 yrs)\nEntery fee during weekends:\nRupees.60 per adult\nRupees.40 per Child (3 to 10 yrs)';
    else if (q == 'NTR garden')
      return 'Moday - Saturday:\n2:30 PM – 8:30 PM\nSuday:\n12:30 PM – 8:30 PM\nEntry fee:\nRupees.20 per Adult\nRupees.10 per Child';
    else if (q == 'Qutb Shahi Tombs')
      return '9:30 AM – 4:30 PM\nClosed on Fridays.\nEntery fee:\nRupees.10 per Adult\nRupees.5 per Child';
    else if (q == 'Salarjung Museum')
      return '10:00 AM – 5:00 PM\nClosed on Fridays.\nEntery fee:\nRupees.20 for Indians\nRupees.500 Foreign Visitors\nFree for Students with ID Cards (upto 18 Yrs)\n50% Concession for defence personnel in uniform & organized Kisan parties';
    else if (q == 'Hussain Sagar')
      return '08:00 AM – 10:00 PM\nEntry fee: Rupees.0\n55 per Adult for Mechanised Boat\nRupees.35 per Adult for Mechanised Boat\nRupees.250 per Person for Jet Ski Boat\nRupees.300 per Couple for Jet Ski Boat\nRupees.100 per Person for Rajahamsa Boat (min 5 persons)\nRupees.400 per Person for Para Sailing';
    else if (q == 'Ramoji Film City')
      return '9:00 am – 5:30 pm\nEntry fee vastly varies depending on if you want to stay or just visit.\nGeneral Guided One Day Tour with-out-Food\nTour Start & End Time: 9.00 AM to 5.30 PM\n(Entry Time from: 9.00 AM to 2.00 PM only)\nAdult: Rs.1150/-\nChild (33" Ht to 54" Ht): Rs.950/-';
    else if (q == 'Mecca Masjid')
      return '4:00 AM - 9:30 PM\nEntery fee: Rupees.0';
    else
      return 'Sorry, data unavailable!';
  }

  // Builds page to populate search results.
  @override
  Widget buildResults(BuildContext context) {
    print(query);
    var placeInfo = infoAboutThatPlace(query);
    var ocTime = openingClosingTime(query);
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$ocTime',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.lightBlueAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    '$placeInfo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inconsolata',
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      this.close(context, this.query);
                    },
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Suggestions list while typing search query - this.query.
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _WordSuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
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

// Suggestions list widget displayed in the search page.
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
          // Highlight the substring that matched the query.
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
