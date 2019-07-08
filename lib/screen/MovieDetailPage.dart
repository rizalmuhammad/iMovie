import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/config.dart';
import 'package:flutter_movies/model/MovieDetail.dart';
import 'package:flutter_movies/screen/DetailHeader.dart';
import 'package:flutter_movies/screen/ProductionCompaniesScroller.dart';
import 'package:flutter_movies/screen/StoryLine.dart';
import 'package:http/http.dart' as http;

class MovieDetailPage extends StatelessWidget {
  MovieDetailPage(this.id);

  var id;

  MovieDetail detail;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder<MovieDetail>(
        future: getMovieDetail(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print("Result $snapshot");
            return new Container(
              // Progress Indikator
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return new Center(
              child: new Text("${snapshot.error}"),
            );
          } else {
            MovieDetail movies = snapshot.data;
            return new SingleChildScrollView(
              child: new Column(
                children: [
                  new MovieDetailHeader(movies),
                  new Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: new StoryLine(movies.synopsis),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 50.0,
                    ),
                    child: new ProductionCompaniesScroller(movies.productionCompanies),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

// Method untuk mendapatkan movie
  Future<MovieDetail> getMovieDetail(id) async {
    final String nowPlaying = 'https://api.themoviedb.org/3/movie/' +
        id.toString() +
        '?api_key=' +
        Config.apiKey +
        '&page=' +
        '1';

    var httpClient = new HttpClient();
    try {
      final response = await http.get(nowPlaying);
      final responseJson = json.decode(response.body);

      MovieDetail movieDetail = createDetailList(responseJson);
      return movieDetail;
    } catch (exception) {
      print("Ini errornya "  + exception.toString());
    }
    return null;
  }

  MovieDetail createDetailList(data) {
    List<String> genresList = new List();
    List<ProductionCompanies> productionCompanyList = new List();

    var id = data["id"];
    var title = data["original_title"];
    var productionCompany = data["production_companies"];
    for (var i = 0; i < productionCompany.length; i++) {
      var id = productionCompany[i]["id"];
      var name = productionCompany[i]["name"];
      var logoPath = productionCompany[i]["logo_path"];
      ProductionCompanies productionCompanies =
          new ProductionCompanies(id, name, logoPath);
      productionCompanyList.add(productionCompanies);
    }
    var genres = data["genres"];
    for (var i = 0; i < genres.length; i++) {
      String name = genres[i]["name"];
      genresList.add(name);
    }
    var overview = data["overview"];
    var posterPath = data["poster_path"];
    var backdropPath = data["backdrop_path"];
    var voteAverage = data["vote_average"];
    MovieDetail detail = MovieDetail(id, title, genresList, overview, posterPath,
        backdropPath, voteAverage, productionCompanyList);
    return detail;
  }
}
