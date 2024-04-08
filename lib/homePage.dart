import 'package:flutter/material.dart';
import 'destinationPage.dart';
import 'themeChange.dart';
import 'adoptPets.dart';
import 'customSearch.dart';
import 'historyPage.dart';

void main() {
  runApp(MyApp());
}

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomePage({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imagePaths = [
    'images/Dogs.jpg',
    'images/pet1.jpg',
    'images/pet2.jpg',
    'images/pet3.jpg',
    'images/pet4.jpg',
    'images/pet5.jpeg',
    'images/pet6.jpeg',
    'images/pet7.jpg',
    'images/pet8.jpg',
    'images/pet9.jpg',
    'images/gold_fish.png',
    'images/betta_fish.jpg',
    'images/bettafish2.jpg',
    'images/hamster.jpg',
  ];

  List<String> imageTitles = [
    'Bisky (dog) - Corgis',
    'Eagle (dog) - Beagle',
    'Ruby - White Rabbit',
    'Silie  - Native Cat',
    'Snowfy  - Native Cat',
    'Pepa  - Native Cat',
    'Greacy  - Persian Cat',
    'Tommy (dog) - White Husky',
    'Popyy (dog) - Labrador ',
    'Ham - Hamster',
    'Eddie - Gold Fish',
    'Angela - Betta Fish',
    'Lucky - Betta Fish',
    'Stuward Little - Native Hamseter',
  ];

  List<String> imageDescriptions = [
    'Age: 2 months Sex: Male ₹ 3000',
    'Age: 4 months Sex: Female ₹ 15000',
    'Age: 6 months Sex: Male ₹ 3000',
    'Age: 5 months Sex: Female  Free',
    'Age: 3 months Sex: Female ₹ 5000',
    'Age: 9 months Sex: Male ₹ 3000',
    'Age: 12 months Sex: Male ₹ 15000',
    'Age: 15 months Sex: Male ₹ 17500',
    'Age: 2 months Sex: Female ₹ 3000',
    'Age: 2 months Sex: Male ₹ 1200',
    'Age: 3 months Sex: Female ₹300',
    'Age: 5 months Sex: Male₹ 900',
    'Age: 5 months Sex: Female ₹ 1500',
    'Age: 9 months Sex: Male ₹ 2800',
  ];

  List<bool> adoptedPets = List.generate(14, (_) => false);

  List<AdoptedPet> adoptedPetsList = [];

  int currentPage = 0;
  int itemsPerPage = 7;

  @override
  Widget build(BuildContext context) {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final displayedPets = imagePaths.sublist(startIndex, endIndex);
    final displayedTitles = imageTitles.sublist(startIndex, endIndex);
    final displayedDescriptions =
        imageDescriptions.sublist(startIndex, endIndex);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(
                  imageTitles, imagePaths, imageDescriptions),
            );
          },
        ),
        actions: <Widget>[
          Tooltip(
            message: 'Change brightness mode',
            child: IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.wb_sunny_outlined
                  : Icons.brightness_2_outlined),
              onPressed: () {
                widget.toggleTheme();
              },
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: displayedPets.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Destination(
                      imagePath: displayedPets[index],
                      title: displayedTitles[index],
                      description: displayedDescriptions[index],
                      themeMode:
                          Theme.of(context).brightness == Brightness.light
                              ? ThemeMode.light
                              : ThemeMode.dark,
                      isAdopted: adoptedPets[startIndex + index],
                      onAdoptChanged: (adopted) {
                        setState(() {
                          adoptedPets[startIndex + index] = adopted;
                          if (adopted) {
                            adoptedPetsList.add(
                              AdoptedPet(
                                imagePath: displayedPets[index],
                                title: displayedTitles[index],
                                description: displayedDescriptions[index],
                                timestamp: DateTime.now(),
                              ),
                            );
                          } else {
                            adoptedPetsList.removeWhere(
                                (pet) => pet.imagePath == displayedPets[index]);
                          }
                        });
                      },
                    );
                  },
                ),
              ).then((_) {
                setState(() {});
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                color: adoptedPets[startIndex + index] ? Colors.grey : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            displayedPets[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (adoptedPets[startIndex + index])
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Already Adopted',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        displayedTitles[index],
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed:
                  currentPage > 0 ? () => setState(() => currentPage--) : null,
            ),
            Text('Page ${currentPage + 1}'),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: endIndex < imagePaths.length
                  ? () => setState(() => currentPage++)
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => History(adoptedPetsList)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
