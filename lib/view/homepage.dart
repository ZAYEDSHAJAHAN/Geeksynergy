import 'package:flutter/material.dart';
import 'package:geeksynergy/view/companyinfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/moviemodal.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Movie> movieslist = [];
  Future<List<Movie>> fetchMovies() async {
    final url = Uri.parse('https://hoblist.com/api/movieList');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'category': 'movies',
      'language': 'kannada',
      'genre': 'all',
      'sort': 'voting',
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)["result"];
      for (int i = 0; i < jsonList.length; i++) {
        if (jsonList[i] != null) {
          Map<String, dynamic> map = jsonList[i];
          movieslist.add(Movie.fromJson(map));
        }
      }

      return movieslist;
      // jsonList.map((json) => Movies.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: CompanyInfoScreen(),
            appBar: AppBar(
              title: const Text("Movie List"),
            ),
            body: FutureBuilder<List<Movie>>(
                future: fetchMovies(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                            height: 10,
                          ),
                      itemCount: movieslist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 230,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_up,
                                          size: 80,
                                        ),
                                        Text(
                                          movieslist[index].voting.toString(),
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          size: 80,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Container(
                                        width: 150,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.amber,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    movieslist[index].poster),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            movieslist[index].title,
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          Text(
                                            "Genre : ${movieslist[index].genre}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                          Text(
                                            "Director : ${movieslist[index].director[0]}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                          Text(
                                            "Staring :  ${movieslist[index].stars[0]}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                          Text(
                                              "Mins | ${movieslist[index].language} | 2 Apr"),
                                          Text(
                                            "${movieslist[index].pageViews} views | Voted by ${movieslist[index].totalVoted}people",
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 300,
                                    child: Text('Watch trailer')),
                              ),
                            ],
                          ),
                        );
                      });
                })));
  }
}
