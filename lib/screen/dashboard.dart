import 'package:flutter/material.dart';

Color primaryColor = Color(0xff5ca1d4);

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

Container popularMovie(String poster, String heading, String subHeading) {
  return Container(
    width: 160.0,
    child: Card(
      child: Wrap(
        children: <Widget>[
          Image.network(poster),
          ListTile(
            title: Text(heading),
            subtitle: Text(subHeading),
          ),
        ],
      ),
    ),
  );
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 275.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Text('Hello, What do you want to watch?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Quicksand',
                                fontSize: 32.0)),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Material(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(25.0),
                          child: TextFormField(
                            style: new TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search,
                                    color: Colors.white54, size: 30.0),
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: Colors.white54,
                                    fontFamily: 'Quicksand')),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                popularMovie("https://images.unsplash.com/photo-1561495762-47da483981b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=375&q=80", "Heading 1", "Sub Heading 2"),
                popularMovie("https://images.unsplash.com/photo-1561495762-47da483981b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=375&q=80", "Heading 1", "Sub Heading 2"),
                popularMovie("https://images.unsplash.com/photo-1561495762-47da483981b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=375&q=80", "Heading 1", "Sub Heading 2"),
                popularMovie("https://images.unsplash.com/photo-1561495762-47da483981b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=375&q=80", "Heading 1", "Sub Heading 2"),
                popularMovie("https://images.unsplash.com/photo-1561495762-47da483981b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=375&q=80", "Heading 1", "Sub Heading 2"),
                popularMovie("https://images.unsplash.com/photo-1561495762-47da483981b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=375&q=80", "Heading 1", "Sub Heading 2"),
              ],
            ),
          )
        ],
      ),
    );
  }

//   Widget itemCard(String title, String imgPath, bool isFavourite) {
//     return Padding(
//       padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return ProductDetailScreen();
//           }));
//         },
//         child: Container(
//           color: Colors.white,
//           height: 155.0,
//           width: double.infinity,
//           child: Row(
//             children: <Widget>[
//               Container(
//                 width: 140.0,
//                 height: 150.0,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage(imgPath), fit: BoxFit.cover)),
//               ),
//               SizedBox(
//                 width: 4.0,
//               ),
//               Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Text(title,
//                           style: TextStyle(
//                               fontFamily: 'Quicksand',
//                               fontSize: 17.0,
//                               fontWeight: FontWeight.bold)),
//                       SizedBox(
//                         width: 45.0,
//                       ),
//                       Material(
//                         elevation: isFavourite ? 2.0 : 0.0,
//                         borderRadius: BorderRadius.circular(20.0),
//                         child: Container(
//                             width: 40.0,
//                             height: 40.0,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 color: isFavourite
//                                     ? Colors.white
//                                     : Colors.grey.withOpacity(0.2)),
//                             child: Center(
//                               child: isFavourite
//                                   ? Icon(
//                                       Icons.favorite,
//                                       color: Colors.red,
//                                     )
//                                   : Icon(Icons.favorite_border),
//                             )),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.0,
//                   ),
//                   Container(
//                     width: 175.0,
//                     child: Text(
//                       'Scandinavian small sized double sofa imported full leather / Dale Italia oil wax leather black',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.0,
//                   ),
//                   Row(
//                     children: <Widget>[
//                       SizedBox(
//                         width: 35.0,
//                       ),
//                       Container(
//                           height: 40.0,
//                           width: 50.0,
//                           color: Colors.orange,
//                           child: Center(
//                             child: Text("\$248",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'Quicksand',
//                                     fontWeight: FontWeight.bold)),
//                           )),
//                       Container(
//                           height: 40.0,
//                           width: 100.0,
//                           color: Colors.yellow[700],
//                           child: Center(
//                             child: Text("Add to cart",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Quicksand')),
//                           )),
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
}
