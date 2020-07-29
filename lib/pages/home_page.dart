import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_feed_app/bloc/bloc.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/pages/add_feed_page.dart';
import 'package:simple_feed_app/widgets/counter_widget.dart';
import 'package:simple_feed_app/widgets/feed_card_widget.dart';
import 'package:simple_feed_app/widgets/loading_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1; //The current page is always on the first page. Starting position.
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 38,
          ),
          elevation: 5,
          backgroundColor: CONSTANTS.primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddFeedPage()));
          },
        ),
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Feed",
            style: TextStyle(color: CONSTANTS.CodGrayTextColor),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app, color: CONSTANTS.CodGrayTextColor),
              onPressed: () {
                bloc.signOut();
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: bloc.fetchAllFeeds, // This is called after the being pulled down
          semanticsLabel: "Pull down to refershe Feeds",
          child: StreamBuilder(
            stream: bloc.allFeedsStreamController.stream,
            builder: (BuildContext context, AsyncSnapshot<AllFeeds> snapshot) {
              List<Widget> children;
              if (snapshot.hasError) {
                children = <Widget>[
                  Icon(
                    Icons.error,
                    color: CONSTANTS.primaryColor,
                    size: 41,
                  ),
                  Text(
                      "It seems to be there is internal error please contact the team."),
                ];
              } else {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    children = <Widget>[Text("There is no connection.. ")];
                    break;
                  case ConnectionState.waiting:
                    children = <Widget>[
                      //This is the loading of widget.
                      Container(
                        child: LoadingWidget(),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 4),
                      )
                    ];
                    break;
                  case ConnectionState.active:
                    if (snapshot.data.feedModel.length != 0) {
                      children = <Widget>[
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.feedModel.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: <Widget>[
                                    //This is the card built with for every build.
                                    FeedCard(
                                      feedModel: snapshot.data.feedModel[index],
                                    ),

                                    //This is the counter of the page. This is found at the bottom of the page.
                                    Visibility(
                                      visible: snapshot.data.feedModel.length ==
                                          index + 1,
                                      child: CounterWidget(snapshot: snapshot)
                                    )
                                  ],
                                );
                              }),
                        ),
                      ];
                    } else {
                      children = <Widget>[
                        Text("There is no feed currently"),
                      ];
                    }

                    break;
                  case ConnectionState.done:
                    children = <Widget>[
                      Text("Done"),
                    ];
                    break;
                }
              }
              return Column(
                children: children,
              );
            },
          ),
        ));
  }
}
