import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'config.dart';
import 'model/PopularMovie.dart';
import 'model/UpcomingMovie.dart';
import 'model/NowPlayingMovie.dart';
import 'screen/MovieDetailPage.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

// Method untuk mendapatkan data Popular Movie dari API
Future<List<PopularMovie>> getPopularMovie() async{
  final String popularMovie = 'https://api.themoviedb.org/3/movie/popular?api_key=' + Config.apiKey + '&page=' + '1';

  var httpClient = new HttpClient();
  try {
    //Melakukan panggilan API
    var request = await httpClient.getUrl(Uri.parse(popularMovie));
    var response = await request.close();
    if (response.statusCode == 200) {
      var jsonResponse = await response.transform(utf8.decoder).join();
      //Decode respon json
      var data = jsonDecode(jsonResponse);
      //Mendapatkan hasil
      List results = data["results"];
      //Movie list
      List<PopularMovie> movieList = createPopularMovieList(results);
      //print movielist
      return movieList;
    } else {
      print("Failed http call.");
    }
  } catch (exception) {
    print(exception.toString());
  }
  return null;
}

// Method untuk mendapatkan data Upcoming Movie dari API
Future<List<UpcomingMovie>> getUpcomingMovie() async{
  final String upcomingMovie = 'https://api.themoviedb.org/3/movie/upcoming?api_key=' + Config.apiKey + '&page=' + '1';

  var httpClient = new HttpClient();
  try {
    //Melakukan panggilan API
    var request = await httpClient.getUrl(Uri.parse(upcomingMovie));
    var response = await request.close();
    if (response.statusCode == 200) {
      var jsonResponse = await response.transform(utf8.decoder).join();
      //Decode respon json
      var data = jsonDecode(jsonResponse);
      //Mendapatkan hasil
      List results = data["results"];
      //Movie list
      List<UpcomingMovie> upcomingMovieList = createUpcomingMovieList(results);
      //print movielist
      return upcomingMovieList;
    } else {
      print("Failed http call.");
    }
  } catch (exception) {
    print(exception.toString());
  }
  return null;
}

// Method untuk mendapatkan data Now Playing Movie dari API
Future<List<NowPlayingMovie>> getNowPlayingMovie() async{
  final String nowPlayingMovie = 'https://api.themoviedb.org/3/movie/now_playing?api_key=' + Config.apiKey + '&page=' + '1';

  var httpClient = new HttpClient();
  try {
    //Melakukan panggilan API
    var request = await httpClient.getUrl(Uri.parse(nowPlayingMovie));
    var response = await request.close();
    if (response.statusCode == 200) {
      var jsonResponse = await response.transform(utf8.decoder).join();
      //Decode respon json
      var data = jsonDecode(jsonResponse);
      //Mendapatkan hasil
      List results = data["results"];
      //Movie list
      List<NowPlayingMovie> nowPlayingMovieList = createNowPlayingMovieList(results);
      //print movielist
      return nowPlayingMovieList;
    } else {
      print("Failed http call.");
    }
  } catch (exception) {
    print(exception.toString());
  }
  return null;
}


//Method untuk parsing data yang telah dipanggil
List<PopularMovie> createPopularMovieList(List data){
  List<PopularMovie> list = new List();
  for (int i = 0; i < data.length; i++){
    var id = data[i]["id"];
    String title = data[i]["title"];
    String posterPath = data[i]["poster_path"];
    String backdropPath = data[i]["backdrop_path"];
    String originalTitle = data[i]["original_title"];
    var voteAverage = data[i]["vote_average"];
    String overview = data[i]["overview"];
    String releaseDate = data[i]["release_date"];

    PopularMovie movie = new PopularMovie(id, title, posterPath, backdropPath, originalTitle, voteAverage, overview, releaseDate);
    list.add(movie);
  }
  return list;
}

//Method untuk parsing data yang telah dipanggil
List<UpcomingMovie> createUpcomingMovieList(List data){
  List<UpcomingMovie> list = new List();
  for (int i = 0; i < data.length; i++){
    var id = data[i]["id"];
    String title = data[i]["title"];
    String posterPath = data[i]["poster_path"];
    String backdropPath = data[i]["backdrop_path"];
    String originalTitle = data[i]["original_title"];
    var voteAverage = data[i]["vote_average"];
    String overview = data[i]["overview"];
    String releaseDate = data[i]["release_date"];

    UpcomingMovie movie = new UpcomingMovie(id, title, posterPath, backdropPath, originalTitle, voteAverage, overview, releaseDate);
    list.add(movie);
  }
  return list;
}

//Method untuk parsing data yang telah dipanggil
List<NowPlayingMovie> createNowPlayingMovieList(List data){
  List<NowPlayingMovie> list = new List();
  for (int i = 0; i < data.length; i++){
    var id = data[i]["id"];
    String title = data[i]["title"];
    String posterPath = data[i]["poster_path"];
    String backdropPath = data[i]["backdrop_path"];
    String originalTitle = data[i]["original_title"];
    var voteAverage = data[i]["vote_average"];
    String overview = data[i]["overview"];
    String releaseDate = data[i]["release_date"];

    NowPlayingMovie movie = new NowPlayingMovie(id, title, posterPath, backdropPath, originalTitle, voteAverage, overview, releaseDate);
    list.add(movie);
  }
  return list;
}

// Memabuat card layout untuk popular movie
List<Widget> createPopularMovieCardItem(List<PopularMovie> movies, BuildContext context){
  // Children  list
  List<Widget> listElementWidgetList = new List<Widget>();
  if (movies != null) {
    var lengthOfList = movies.length;
    for (var i = 0; i < lengthOfList; i++) {
      PopularMovie movie = movies[i];
      //image
      var imageUrl = "https://image.tmdb.org/t/p/w500/" + movie.posterPath;
      // list item dengan image
      var listItem = new GridTile(
        footer: new GridTileBar(
          backgroundColor: Colors.black45,
          title: new Text(movie.title),
        ),
        child: new GestureDetector(
          onTap: (){
            if (movie.id > 0) {
              Navigator.push(context, new MaterialPageRoute(builder: (_) => new MovieDetailPage(movie.id)),)
              ;
            }
          },
          child: new FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
      listElementWidgetList.add(listItem);
    }
  }
  return listElementWidgetList;
}

// Memabuat card layout untuk popular movie
List<Widget> createUpcomingMovieCardItem(List<UpcomingMovie> movies, BuildContext context){
  // Children  list
  List<Widget> listElementWidgetList = new List<Widget>();
  if (movies != null) {
    var lengthOfList = movies.length;
    for (var i = 0; i < lengthOfList; i++) {
      UpcomingMovie movie = movies[i];
      //image
      var imageUrl = "https://image.tmdb.org/t/p/w500/" + movie.posterPath;
      // list item dengan image
      var listItem = new GridTile(
        footer: new GridTileBar(
          backgroundColor: Colors.black45,
          title: new Text(movie.title),
        ),
        child: new GestureDetector(
          onTap: (){
            if (movie.id > 0) {
              Navigator.push(context, new MaterialPageRoute(builder: (_) => new MovieDetailPage(movie.id)),)
              ;
            }
          },
          child: new FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
      listElementWidgetList.add(listItem);
    }
  }
  return listElementWidgetList;
}

// Memabuat card layout untuk Now Playing movie
List<Widget> createNowPlayingMovieCardItem(List<NowPlayingMovie> movies, BuildContext context){
  // Children  list
  List<Widget> listElementWidgetList = new List<Widget>();
  if (movies != null) {
    var lengthOfList = movies.length;
    for (var i = 0; i < lengthOfList; i++) {
      NowPlayingMovie movie = movies[i];
      //image
      var imageUrl = "https://image.tmdb.org/t/p/w500/" + movie.posterPath;
      // list item dengan image
      var listItem = new GridTile(
        footer: new GridTileBar(
          backgroundColor: Colors.black45,
          title: new Text(movie.title),
        ),
        child: new GestureDetector(
          onTap: (){
            if (movie.id > 0) {
              Navigator.push(context, new MaterialPageRoute(builder: (_) => new MovieDetailPage(movie.id)),)
              ;
            }
          },
          child: new FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
      listElementWidgetList.add(listItem);
    }
  }
  return listElementWidgetList;
}



class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Movies'),
      ),
      body: PageView(
        children: <Widget>[
          //Popular
          new Offstage(
            offstage: _page != 0,
            child: new TickerMode(
              enabled: _page == 0,
              child: new FutureBuilder(
                future: getPopularMovie(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                  if (!snapshot.hasData) return new Container(
                    child: new Center(
                      child: new CircularProgressIndicator(),
                    ),
                  );
                  // Menampilkan data asli
                  List movies = snapshot.data;
                  return new CustomScrollView(
                    primary: false,
                    slivers: <Widget>[
                      new SliverPadding(
                        padding: const EdgeInsets.all(10.0),
                        sliver: new SliverGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          children: createPopularMovieCardItem(movies, context),
                        ),
                      )
                    ],
                  );
                },
              )
            ),
          ),
          //Upcoming
          new Offstage(
            offstage: _page != 1,
            child: new TickerMode(
              enabled: _page == 1,
              child: new FutureBuilder(
                future: getUpcomingMovie(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                  if (!snapshot.hasData) return new Container(
                    child: new Center(
                      child: new CircularProgressIndicator(),
                    ),
                  );
                  // Menampilkan data asli
                  List movies = snapshot.data;
                  return new CustomScrollView(
                    primary: false,
                    slivers: <Widget>[
                      new SliverPadding(
                        padding: const EdgeInsets.all(10.0),
                        sliver: new SliverGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          children: createUpcomingMovieCardItem(movies, context),
                        ),
                      )
                    ],
                  );
                },
              )
            ),
          ),
          //now playing
          new Offstage(
            offstage: _page != 2,
            child: new TickerMode(
              enabled: _page == 2,
              child: new FutureBuilder(
                future: getNowPlayingMovie(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                  if (!snapshot.hasData) return new Container(
                    child: new Center(
                      child: new CircularProgressIndicator(),
                    ),
                  );
                  // Menampilkan data asli
                  List movies = snapshot.data;
                  return new CustomScrollView(
                    primary: false,
                    slivers: <Widget>[
                      new SliverPadding(
                        padding: const EdgeInsets.all(10.0),
                        sliver: new SliverGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          children: createNowPlayingMovieCardItem(movies, context),
                        ),
                      )
                    ],
                  );
                },
              )
            ),
          )
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text("Popular")),
          BottomNavigationBarItem(icon: Icon(Icons.event), title: Text("Upcoming")),
          BottomNavigationBarItem(icon: Icon(Icons.event_seat), title: Text("Now Playing")),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void navigationTapped(int page){
    _pageController.animateToPage(page, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page){
    setState(() {
      this._page = page;
    });
  }
}