import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'imageslider.dart';
import 'package:rxdart/rxdart.dart';

class SliverAppBarWidget extends StatefulWidget {
  @override
  State<SliverAppBarWidget> createState() => _SliverAppBarWidgetState();
}

class _SliverAppBarWidgetState extends State<SliverAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        slivers: <Widget>[
          ///First sliver is the App Bar
          SliverAppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    cards.add([
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
                    index=0;
                    setState(() {});
                  },
                  icon: Icon(Icons.restore))
            ],
            backgroundColor: Colors.white,
            floating: false,
            snap: false,
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title:  Text(
                "Pet World",
                style:  TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ubuntuRegularFont'),
              ),
              background:  Image(image:
              NetworkImage(
                // 'https://thumbs.dreamstime.com/z/hand-doodle-vector-clipart-funny-dogs-paw-prints-bones-cute-surface-design-wallpaper-background-print-148075155.jpg'
                'http://freepngclipart.com/download/puppy/12386-puppy-images-image-png.gif'
                ,),
                  fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(

            child: Container(
              // color: Colors.black12,
              //width: MediaQuery.of(context).size.width *1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        // 'https://thumbs.dreamstime.com/z/hand-doodle-vector-clipart-funny-dogs-paw-prints-bones-cute-surface-design-wallpaper-background-print-148075155.jpg'
                          'https://upload.wikimedia.org/wikipedia/commons/b/b1/Little_background.jpg'
                      ),
                      fit: BoxFit.fill)),
              height: MediaQuery.of(context).size.height *1,
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

        ],
      ),
    );
  }

  Widget listItem(Color color, String title) => Container(
    // decoration: BoxDecoration(
    //   border: Border(
    //     top: BorderSide(
    //       color: Colors.black26,
    //       width: 1.0,
    //     ),
    //   ),
    // ),
    // child: Center(
    //   child: Text(
    //     "Kartik",
    //     textAlign: TextAlign.center,
    //     style: TextStyle(
    //         color: Colors.black87,
    //         fontSize: 14.0,
    //         fontWeight: FontWeight.bold,
    //         fontFamily: 'ubuntuRegularFont'),
    //   ),
    // ),
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
class Card extends StatefulWidget {
  // Made to distinguish cards
  // Add your own applicable data here
  final Color color;
  Card(this.color);

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Swipable(
      // Set the swipable widget
      verticalSwipe: false,
      child:
      ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white,
          child: Container(
            // color: Colors.pink.shade100,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                Center(
                  child: Column(
                    children: [
                      Row( mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 5,),
                              Text("Hello, I am  ",style:
                              TextStyle(fontFamily: "Monterrat",
                                  fontSize: 20),),
                            ],
                          ),
                          Text('${name[index].toUpperCase()}',style:
                          TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),)
                        ],
                      ),
                      Divider( thickness: 2,)
                    ],
                  ),
                ),
                Container(
                  child: Image.network(img[index]),
                  //margin: EdgeInsets.all(5),
                  color: Colors.black12,
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width *0.66,),
                MaterialButton(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text("Adopt Me")
                          ,
                          Text("🙂"),
                        ],
                      )
                    ],
                  ),
                  onPressed: (){},
                )
              ],
            ),
            height: MediaQuery.of(context).size.height *0.8,
            width: MediaQuery.of(context).size.width *0.9,
            decoration: BoxDecoration(
              // image: DecorationImage(image: NetworkImage(img[index],),),
              borderRadius: BorderRadius.circular(16.0),
              //color: color,
            ),
          ),
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
        if(index< 9){
          index++;
        }
        if(index==9){
          index=0;
        }
        cards.add([
          ...cards.value,
          Card(
            data[0]['color'],
          ),
        ]);
        print("Swipe Left");
        print(index);
      },
      onSwipeRight: (finalPosition) {
        if(index>0){
          index--;
        }
        if(index==0){
          index=9;
        }
        cards.add([
          ...cards.value,
          Card(
            data[0]['color'],
          ),
        ]);
        print("Swipe Right");
        print(index);
      },

    );
  }
}
final img = [
  'https://thumbs.dreamstime.com/b/indian-street-dog-poor-male-106748686.jpg',
  'http://lh3.googleusercontent.com/FX7DeSKqt-xj61EBLFeXz30AV-GQMfrGfQ1in8qEKoc-_v5o-_-d7b3AcD1YBKNef_oZrdMm5N5AjqRFntG9vzU=s900',
  'https://previews.123rf.com/images/arghman/arghman1411/arghman141100017/34163649-stray-dog-puppy.jpg',
  'https://steemitimages.com/DQmdRLBWGw6iVt5MEkNjeLwHHbVFnShNXXmYbShcyryXyt4/DSC_01612.jpg',
  'https://media.istockphoto.com/photos/stray-dog-picture-id1052500062?b=1&k=20&m=1052500062&s=170667a&w=0&h=UbiPEZuulTJKJHai8wD0ZHV4YAsjk-w6YhVMRFOwyPo=',
  'https://cdn.pixabay.com/photo/2019/04/17/20/09/dog-4135235_960_720.jpg',
  'https://cdn.pixabay.com/photo/2021/03/18/06/24/street-6104056_1280.jpg',
  'https://steemitimages.com/p/C3TZR1g81UNchGPKLQuxAL7oEwDJ42cT977qXjChRixxBJj5uqe6uAP3PVs8cW9cvw757m9XUpr8GaBctf4CEryz647HwUtrZ7sdekWck9BiDbUvim1grPp?format=match&mode=fit&width=640',
  'https://media.istockphoto.com/photos/stray-dog-puppy-picture-id959833214?b=1&k=20&m=959833214&s=170667a&w=0&h=dVlD4prMTXV60xFS1MAQkN9BP0p0T9-3RW4nSRhM7tc=',
  'https://media.istockphoto.com/photos/portrait-of-a-happy-dog-at-sunrisedawn-at-marina-beach-chennai-india-picture-id843813978?k=20&m=843813978&s=612x612&w=0&h=7a0ZFZ1HDp8Xwmz9dKlNs3FpY3B5Jm147YwF075LuGA='
];
var index=0;
final name =[
  'tom','jerry','rocky','bhura','tiger','max','sheru','moti','tommy','jaggu'
];