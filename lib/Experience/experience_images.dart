import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Club extends StatefulWidget {
  const Club({super.key});

  @override
  State<Club> createState() => _ClubState();
}

class _ClubState extends State<Club> {
  final Set<int> selectedIndexes = {};
  late Future<List<dynamic>> _futureExperiences;

  @override
  void initState() {
    super.initState();
    _futureExperiences = fetchResult(); // Fetch only once
  }

  Future<List<dynamic>> fetchResult() async {
    final response = await http.get(
      Uri.parse('https://staging.chamberofsecrets.8club.co/v1/experiences?active=true'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is Map &&
          data.containsKey('data') &&
          data['data'].containsKey('experiences')) {
        return data['data']['experiences'];
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _futureExperiences, // Use stored future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Data Found"));
        }

        final experiences = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(experiences.length, (index) {
              final exp = experiences[index];
              final isSelected = selectedIndexes.contains(index);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedIndexes.remove(index);
                    } else {
                      selectedIndexes.add(index);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Transform.rotate(
                    angle: index.isEven ? -0.1 : 0.1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "Assets/back.png",
                            fit: BoxFit.cover,
                            width: 120,
                            height: 150,
                          ),
                        ),

                        // Main image (colored if selected, greyscale if not)
                        if (exp['image_url'] != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ColorFiltered(
                              colorFilter: isSelected
                                  ? const ColorFilter.mode(
                                Colors.transparent,
                                BlendMode.multiply,
                              )
                                  : const ColorFilter.matrix(<double>[
                                0.2126, 0.7152, 0.0722, 0, 0, //
                                0.2126, 0.7152, 0.0722, 0, 0, //
                                0.2126, 0.7152, 0.0722, 0, 0, //
                                0, 0, 0, 1, 0, //
                              ]),
                              child: Image.network(
                                exp['image_url'],
                                fit: BoxFit.cover,
                                width: 100,
                                height: 130,
                              ),
                            ),
                          ),

                        // Selection overlay (border + tint)
                        if (isSelected)
                          Container(
                            width: 120,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 3,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
