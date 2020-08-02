import 'package:flutter/material.dart';
import 'package:simple_feed_app/bloc/bloc.dart';
import 'package:simple_feed_app/config/constants.dart';

class CounterWidget extends StatefulWidget {
  final AsyncSnapshot snapshot;
  const CounterWidget({Key key, this.snapshot}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int currentPage = 1;
  Widget _buildCounter(snapshot) {
    return Container(
      child: Card(
        child: Center(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
//              _logger.d(snapshot.data.page.toString());
              return Container(
                  margin: EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPage = index + 1;
                      });
                      bloc.fetchAllFeeds(pageNumber: currentPage.toString());
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPage == index + 1
                              ? CONSTANTS.primaryColor
                              : Colors.transparent),
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                              color: currentPage == index + 1
                                  ? Colors.white
                                  : CONSTANTS.CodGrayTextColor,
                              fontSize: 21),
                        ),
                      ),
                    ),
                  ));
            },
            itemCount: snapshot.data.pages,
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 40,
      margin: EdgeInsets.only(left: 10, right: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCounter(widget.snapshot);
  }
}
