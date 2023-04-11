import 'package:flutter/material.dart';
import 'package:mydoc/providers/dio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_screen.dart';

var users, user;

void fetchData() async {
  user = await DioProvider().fetchCurrentUserData();

  if (user['role'] == 'doctor') {
    users = await DioProvider().getPatients();
  } else {
    users = await DioProvider().getDoctors();
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    fetchData();
    
    List imgs = [
      "doctor1.jpg",
      "doctor2.jpg",
      "doctor3.jpg",
      "doctor4.jpg",
      "doctor1.jpg",
      "doctor2.jpg",
      "doctor3.jpg",
      "doctor4.jpg",
    ];

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Messages",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Recent Chat",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    minVerticalPadding: 30,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(),
                          ));
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        "images/${imgs[index]}",
                      ),
                    ),
                    title: const Text(
                      "Dr. Doctor Name",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showSearch(
            context: context,
            delegate: CustomSearchDelegate(),
          ),
          child: const Icon(Icons.search),
        ));
  }
}

class CustomSearchDelegate extends SearchDelegate<String?> {
  final List<String> _history = <String>[];

  @override
  String get searchFieldLabel => "Search people";

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Voice Search',
          icon: const Icon(Icons.mic),
          onPressed: () {
            query = '';
          },
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String? searched = query;
    if (searched == null || !users.contains(searched)) {
      return Center(
        child: Text(
          '"$query"\n is not a valid search.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      children: <Widget>[Title(color: Colors.red, child: Text('hello'))],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<dynamic> suggestions = query.isEmpty
        ? users
        : users.where((dynamic s) => '$s'.startsWith(query));
    return _SuggestionList(
      query: query,
      suggestions: suggestions,
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
        _history.add(suggestion);
      },
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList(
      {required this.suggestions,
      required this.query,
      required this.onSelected});

  final Iterable<dynamic> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final suggestion = suggestions.elementAt(i);
        return ListTile(
          leading: query.isEmpty
              ? Icon(Icons.account_circle, size: 50.0)
              : const Icon(null),
          title: Text(suggestion['full_name']),
          subtitle: Text(suggestion['phone_number']),
          onTap: () {
            // selected user
            onSelected(suggestion['full_name']);

            // create new chat
            final res = DioProvider().createChat(user['role'] == 'doctor'
                ? suggestion['patient_id']
                : suggestion['doctor_id']);

            /// push to chat screen
            Navigator.pushNamed(context, '/chat_screen',
                arguments: {'chat_id': 1});
          },
        );
      },
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard(
      {required this.integer,
      required this.title,
      required this.searchDelegate});

  final int integer;
  final String title;
  final SearchDelegate<int> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        searchDelegate.close(context, integer);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(title),
              Text(
                '$integer',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
