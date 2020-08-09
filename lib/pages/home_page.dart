import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_feed_app/bloc/firebase_auth_bloc.dart';
import 'package:simple_feed_app/bloc/feed/bloc.dart';
import 'package:simple_feed_app/commons/feed_card_widget.dart';
import 'package:simple_feed_app/commons/loading_widget.dart';
import 'package:simple_feed_app/config/theme.dart';
import 'package:simple_feed_app/model/all_feeds_model.dart';
import 'package:simple_feed_app/pages/add_feed_page.dart';

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
  FeedBloc feedBloc = FeedBloc();

  @override
  void initState() {
    feedBloc.fetchAllFeeds();
    super.initState();
  }

  void fetchNextPage(int totalNumberOfPages) async {

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentPage += 1;

      AllFeeds allFeeds = await feedBloc.fetchAllFeeds(
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
          backgroundColor: Pallet.primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddFeedPage()));
          },
        ),
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Feed",
            style: TextStyle(color: Pallet.CodGrayTextColor),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Pallet.CodGrayTextColor),
              onPressed: () {
                FirebaseAuthBloc.instance.signOut();
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh:
          feedBloc.fetchAllFeeds, // This is called after the being pulled down
          semanticsLabel: "Pull down to refershe Feeds",
          child: BlocBuilder(
            cubit: feedBloc,
            builder: (context, AllFeeds snapshot) {
              List<Widget> children;
              _scrollController.addListener(() async {
                if (currentPage <= snapshot.pages) {
                  setState(() {
                    showLoading = true;
                  });
                  fetchNextPage(snapshot.pages);
                }
              });
              if(snapshot!=null){
                if (snapshot.feedModel.length != 0) {
                  feedModelList = snapshot.feedModel;

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
              }else{
               children = <Widget> [
                 Container(
                   child: LoadingWidget(),
                   margin: EdgeInsets.only(
                       top: MediaQuery.of(context).size.height / 4),
                 ),
               ];
              }

              return Column(
                children: children,
              );
            },
          ),
        ));
  }
}
