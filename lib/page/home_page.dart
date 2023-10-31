import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:potterhead_app/characterModel.dart';

import 'character_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CharacterModel> characters = [];

  CarouselController _carouselController = CarouselController();

  int _current = 0;
  dynamic _selectedIndex = {};

  Future fetchCharacters() async {
    var response = await http.get(
      Uri.https('hp-api.onrender.com', 'api/characters'),
    );
    var jsonData = jsonDecode(response.body);

    for (var eachCharacter in jsonData) {
      final Map<String, dynamic> wandData = eachCharacter['wand'];
      Wand wand = Wand.fromJson(wandData);

      final character = CharacterModel(
        id: eachCharacter['id'],
        name: eachCharacter['name'],
        alternateNames: eachCharacter['alternate_names'].cast<String>(),
        species: eachCharacter['species'],
        gender: eachCharacter['gender'],
        house: eachCharacter['house'],
        dateOfBirth: eachCharacter['dateOfBirth'] ?? "",
        yearOfBirth: eachCharacter['yearOfBirth'] ?? 0,
        wizard: eachCharacter['wizard'],
        ancestry: eachCharacter['ancestry'],
        eyeColour: eachCharacter['eyeColour'],
        hairColour: eachCharacter['hairColour'],
        wand: wand,
        patronus: eachCharacter['patronus'],
        hogwartsStudent: eachCharacter['hogwartsStudent'],
        hogwartsStaff: eachCharacter['hogwartsStaff'],
        actor: eachCharacter['actor'],
        alternateActors: eachCharacter['alternate_actors'],
        alive: eachCharacter['alive'],
        image: eachCharacter['image'] ?? "",
      );
      characters.add(character);
    }
    //print(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    Color textColor;

    fetchCharacters();
    return Scaffold(
      body: FutureBuilder(
        future: fetchCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                options: CarouselOptions(
                  autoPlay: false,
                  height: 500,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.70,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                ),
                itemCount: characters.length,
                itemBuilder: (context, index, pageViewIndex) =>
                    AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: getBgColor(characters[index].house),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.width,
                          child: characters[index].image.isNotEmpty
                              ? Image.network(
                                  characters[index].image,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.error),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          characters[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text('(${characters[index].actor})'),
                        Text(characters[index].house),
                        const SizedBox(
                          height: 4,
                        ),
                        FloatingActionButton(
                          heroTag: null,
                          backgroundColor:
                              getButtonColor(characters[index].house),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CharacterPage(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_upward_outlined,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Color getButtonColor(String house) {
  switch (house) {
    case 'Gryffindor':
      return Colors.red.shade900;
    case 'Slytherin':
      return Colors.green.shade900;
    case 'Hufflepuff':
      return Colors.yellow.shade900;
    default:
      return Colors.blue.shade900;
  }
}

Color getBgColor(String house) {
  switch (house) {
    case 'Gryffindor':
      return Colors.red;
    case 'Slytherin':
      return Colors.green;
    case 'Hufflepuff':
      return Colors.yellow;
    default:
      return Colors.blue;
  }
}
