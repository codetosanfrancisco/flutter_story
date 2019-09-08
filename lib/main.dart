import 'package:flutter/material.dart';
import './customIcons.dart';
import './data.dart';
import 'dart:math';

//Basically how it works is that:
// There is 1 stack widget that stacks one stack widget and a PageView Widget
// PageView Widget return Empty Container Widget used to detect currentPage upon scrolling
// The other Stack Widget contains an array of images(which is this case is also a Stack Widget to stack together with other widget such as Text Widget) as child and will change its position according to the scrolling of PageView

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var currentPage = images.length - 1;
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);

    controller.addListener(() => {
          setState(() {
            currentPage:
            controller.page;
          })
        });

    return Scaffold(
        backgroundColor: Color(0xFF2d3447),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        CustomIcons.menu,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Trending",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CustomIcons.options,
                          size: 12.0,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFff6e6e),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("Animated",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "25+ Stories",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: images.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, constraint) {
          var width = constraint.maxWidth;
          var height = constraint.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;

          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Positioned> cardItems = [];

          for (var i = 0; i < images.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
                textDirection: TextDirection.rtl,
                top: padding + verticalInset * max(-delta, 0.0),
                bottom: padding + verticalInset * max(-delta, 0.0),
                start: start,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(3.0, 6.0),
                          blurRadius: 10.0),
                    ]),
                    child: AspectRatio(
                      aspectRatio: cardAspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset(images[i], fit: BoxFit.cover),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Text(
                                    title[i],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontFamily: "SF-Pro-Text-Regular"),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 12.0, bottom: 12.0),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      "Read Later",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));

            cardItems.add(cardItem);
          }
          return Stack(children: cardItems);
        },
      ),
    );
  }
}
