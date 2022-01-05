import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'imageslider.dart';
import 'package:rxdart/rxdart.dart';

class SliverAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Scroll view for Sliver app bar for giving custom scroll behaviour
      body: CustomScrollView(
        slivers: <Widget>[
          ///First sliver is the App Bar
          SliverAppBar(
            ///Properties of app bar
            ///
            /// Color of app bar when it is collapsed
            backgroundColor: Colors.white,
            /// Set to false so that appbar is always invisible after
            /// collapsing
            /// If set to true here, the app bar will expand as soon as you
            /// start scrolling up even if you haven't reached the top
            floating: false,
            /// To make the app bar visible at all times after collapsing
            /// we set pinned to true
            pinned: true,
            expandedHeight: 200.0,

            ///Properties of the App Bar when it is expanded
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "SliverAppBar Widget",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ubuntuRegularFont'),
              ),
              background: Container(
                color: Colors.lightBlue,
              ),
            ),
          ),
           SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height *0.8,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.7,
                  // Important to keep as a stack to have overlay of cards.
                  child: StreamBuilder<List<Card>>(
                    stream: cards,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return SizedBox();
                      final data = snapshot.data;
                      return Stack(
                        children: data!,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          ///Next sliver is the Sliver list that is used here to
          ///allow the user to scroll and observe the collapsing
          ///behaviour of SliverAppBar widget
          // SliverFixedExtentList(
          //   itemExtent: 100.0,
          //   delegate: SliverChildListDelegate(
          //     [
          //       listItem(
          //         Colors.white,
          //         "List item 1",
          //       ),
          //       listItem(
          //         Colors.white,
          //         "List item 2",
          //       ),
          //       listItem(
          //         Colors.white,
          //         "List item 3",
          //       ),
          //       listItem(
          //         Colors.white,
          //         "List item 4",
          //       ),
          //       listItem(
          //         Colors.white,
          //         "List item 5",
          //       ),
          //       listItem(
          //         Colors.white,
          //         "List item 6",
          //       ),
          //       listItem(
          //         Colors.white,
          //         "List item 7",
          //       ),
          //       listItem(
          //         Colors.white,
          //         "List item 8",
          //       ),
          //       listItem(
          //         Colors.white,
          //         "List item 9",
          //       ),
          //       listItem(
          //         Colors.white,
          //         "List item 10",
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget listItem(Color color, String title) => Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.black26,
          width: 1.0,
        ),
      ),
    ),
    child: Center(
      child: Text(
        "$title",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'ubuntuRegularFont'),
      ),
    ),
  );
}
final List data = [
  {
    'color': Colors.red,
  },
  {
    'color': Colors.green,
  },
  {
    'color': Colors.blue,
  }
];
BehaviorSubject<List<Card>> cards = BehaviorSubject.seeded([
  Card(
    data[0]['color'],
  ),
  Card(
    data[1]['color'],
  ),
  Card(
    data[2]['color'],
  ),
]);
class Card extends StatelessWidget {
  // Made to distinguish cards
  // Add your own applicable data here
  final Color color;
  Card(this.color);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      // Set the swipable widget
      verticalSwipe: false,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: color,
        ),
      ),
      onSwipeStart: (details) {},
      onSwipeCancel: (position, details) {},
      onSwipeEnd: (position, details) {},
      onPositionChanged: (details) {},
      onSwipeUp: (finalPosition) {
        print("Swipe Up");
      },
      onSwipeDown: (finalPosition) {
        print("Swipe Down");
      },
      onSwipeLeft: (finalPosition) {
        cards.add([
          ...cards.value,
          Card(
            data[0]['color'],
          ),
        ]);
        print("Swipe Left");
      },
      onSwipeRight: (finalPosition) {
        cards.add([
          ...cards.value,
          Card(
            data[0]['color'],
          ),
        ]);
        print("Swipe Right");
      },
      // onSwipeRight, left, up, down, cancel, etc...
    );
  }
}