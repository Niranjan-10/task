import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/utils/apis/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<User> data;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    data = await Api().getUser();

    print(data.length);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                        data[index].lowThumbnail)),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Text(data[index].channelname)),
                              Icon(Icons.more_vert)
                            ],
                          ),
                        ),
                        Container(
                          child: Image.network(data[index].highThumbnail),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 2.0),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(FontAwesomeIcons.heart),
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                              ),
                              Container(
                                  child: Icon(FontAwesomeIcons.comment),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0)),
                              Container(
                                child: Icon(FontAwesomeIcons.paperPlane),
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                              ),
                              Spacer(),
                              Icon(FontAwesomeIcons.bookmark)
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Row(children: [
                            Expanded(
                           child: !data[index].isClicked ?Text(
                              data[index].title.substring(0, 15),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis
                            ):Text(
                              data[index].title,
                              // textAlign: TextAlign.left,
                              // overflow: TextOverflow.ellipsis
                            )
                            ),
                            data[index].isClicked
                                ?Container()
                                : Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          data[index].isClicked =
                                              !data[index].isClicked;
                                        });
                                      },
                                      child: Text(
                                        "show More",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.blueAccent),
                                      ),
                                    )),
                          ]),
                        )
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
