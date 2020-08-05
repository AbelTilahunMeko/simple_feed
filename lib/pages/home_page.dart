import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_feed_app/bloc/firebase_auth_bloc.dart';
import 'package:simple_feed_app/bloc/feed/bloc.dart';
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
  int currentPage =
      1; //The current page is always on the first page.
  bool showLoading = false;
  ScrollController _scrollController = new ScrollController();
  List feedModelList;

  @override
  void initState() {
    FeedBloc.instance.fetchAllFeeds();
    super.initState();
  }

  void fetchNextPage(int totalNumberOfPages) async {
    //calling the fetch function when the scroll reaches 0.9(90%)

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentPage += 1;

      AllFeeds allFeeds = await FeedBloc.instance.fetchAllFeeds(
          pageNumber: currentPage.toString(), initialLoad: false);

      allFeeds.feedModel.forEach((element) {
        feedModelList.add(element);
      });
      showLoading = false;
      setState(() {});
    }
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
                FirebaseAuthBloc.instance.signOut();
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh:
          FeedBloc.instance.fetchAllFeeds, // This is called after the being pulled down
          semanticsLabel: "Pull down to refershe Feeds",
          child: StreamBuilder(
            stream: FeedBloc.instance.allFeedsStreamController.stream,
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
                    _scrollController.addListener(() async {
                      if (currentPage <= snapshot.data.pages) {
                        setState(() {
                          showLoading = true;
                        });
                        fetchNextPage(snapshot.data.pages);
                      }
                    });

                    if (snapshot.data.feedModel.length != 0) {
                      feedModelList = snapshot.data.feedModel;

                      children = <Widget>[
                        Expanded(
                          child: ListView.builder(
                              controller: _scrollController,
                              itemCount: feedModelList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: <Widget>[
                                    //This is the card built with for every build.
                                    FeedCard(
                                      feedModel: feedModelList[index],
                                    ),

                                    //This is the counter of the page. This is found at the bottom of the page.
                                    Visibility(
                                        visible:
                                        feedModelList.length == index + 1 &&
                                            showLoading,
                                        child: Container(
                                          child: LoadingWidget(
                                            height: 140,
                                          ),
                                        )),
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
