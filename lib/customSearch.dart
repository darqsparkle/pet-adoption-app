import 'package:flutter/material.dart';
import 'destinationPage.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> imageTitles;
  final List<String> imagePaths;
  final List<String> imageDescriptions;

  CustomSearchDelegate(
    this.imageTitles,
    this.imagePaths,
    this.imageDescriptions,
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionTitles = imageTitles
        .where((title) => title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionTitles.length,
      itemBuilder: (BuildContext context, int index) {
        final String title = suggestionTitles[index];
        final int imageIndex = imageTitles.indexOf(title);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Destination(
                    imagePath: imagePaths[imageIndex],
                    title: imageTitles[imageIndex],
                    description: imageDescriptions[imageIndex],
                    themeMode: Theme.of(context).brightness == Brightness.light
                        ? ThemeMode.light
                        : ThemeMode.dark,
                    isAdopted: false, 
                    onAdoptChanged: (adopted) {}, 
                  );
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePaths[imageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
