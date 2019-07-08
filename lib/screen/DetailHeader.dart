import 'package:flutter/material.dart';
import 'package:flutter_movies/model/MovieDetail.dart';
import 'package:flutter_movies/screen/BannerImage.dart';
import 'package:flutter_movies/screen/poster.dart';
import 'package:flutter_movies/screen/RatingInformation.dart';

class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.movies);

  final MovieDetail movies;

  _buildCategoryChips(TextTheme textTheme) {
    return movies.genres.map((genres) {
      return new Chip(
        label: new Text(genres),
        labelStyle: textTheme.caption,
        backgroundColor: Colors.black12,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            movies.originalTitle,
            style: textTheme.title,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: new RatingInformation(movies),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: new Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            direction: Axis.horizontal,
            children: _buildCategoryChips(textTheme),
          ),
        )
      ],
    );

    return new Stack(
      children: [
        new Padding(
          padding: const EdgeInsets.only(bottom: 240.0),
          child: new BannerImage(
              "https://image.tmdb.org/t/p/w500/" + movies.backdropPath),
        ),
        new Positioned(
          bottom: 32.0,
          left: 16.0,
          right: 16.0,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: new Poster(
                  "https://image.tmdb.org/t/p/w500/" + movies.posterPath,
                  height: 190.0,
                ),
              ),
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: movieInformation,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}