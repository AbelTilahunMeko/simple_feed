import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_feed_app/bloc/feed/bloc.dart';
import 'package:simple_feed_app/bloc/post/bloc.dart';
import 'package:simple_feed_app/config/constants.dart';
import 'package:simple_feed_app/model/feed_model.dart';
import 'package:simple_feed_app/util/logger.dart';

// ignore: must_be_immutable
class FeedCard extends StatefulWidget {
  final FeedModel feedModel;

  FeedCard({Key key, this.feedModel}) : super(key: key);

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  String imageURL =
      "https://storage.googleapis.com/simple-feed-704cd.appspot.com/";
  int numberOfLikes;
  PostBloc postBloc;

  @override
  void initState() {
    numberOfLikes = widget.feedModel.likes;
    postBloc = PostBloc(widget.feedModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildFeedCard();
  }

  void dislike() {}

  void likeCount() {}

  Widget _buildFeedCard() {
    return Column(
      children: <Widget>[
        //THe placeholder is the gif used while the image is solved.
        FadeInImage.assetNetwork(
          placeholder: "assets/loading_gif.gif",
          image: imageURL + widget.feedModel.image,
          height: 300,
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(left: 20, right: 5),
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(imageURL +
                      widget.feedModel.user.profilePic +
                      "?alt=media&token=47062ce1-85ae-47a7-a7c4-6347b2830f3f")),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.feedModel.user.name.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CONSTANTS.CodGrayTextColor,
                        fontSize: 18),
                  ),
                  Text(
                    "@" +
                        widget.feedModel.user.userName.toString() +
                        " . 49 sec ago",
                    style: TextStyle(color: CONSTANTS.lightGrayTextColor),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: StreamBuilder(
                stream: postBloc.singleFeedsStreamController.stream,
                builder: (context, AsyncSnapshot<FeedModel> snapshot) {
                  if(ConnectionState.active == snapshot.connectionState){
                  return Row(
                    children: <Widget>[
                      !snapshot.data.isLiked?
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: (){
                          postBloc.likeFeed();
                        },
                      ):IconButton(
                        icon: Icon(Icons.favorite, color: CONSTANTS.primaryColor,),
                        onPressed: (){
                          postBloc.dislikeFeed();
                        },
                      ),
                      Text(snapshot.data.likes.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                    ],
                  );
                  }else{
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            widget.feedModel.caption,
            style: TextStyle(color: CONSTANTS.lightGrayTextColor, fontSize: 16),
          ),
        )
      ],
    );
  }
}


