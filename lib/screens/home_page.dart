import 'package:covid/API_Helper/API_Helper.dart';
import 'package:covid/globals/global.dart';
import 'package:covid/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xfff5f9fe),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                controller: searchController,
                onSubmitted: (val) {
                  Global.endpoint = "countries/$val";
                  setState(() {});
                  searchController.clear();
                },
                placeholder: "Search Countries",
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xffcfe3fc),
            child: CircleAvatar(
              radius: 22,
              backgroundImage:
                  (Global.image != null) ? NetworkImage(Global.image!) : null,
              backgroundColor: Colors.blueGrey,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.2,
              width: size.width,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/3.png"), fit: BoxFit.fill),
                color: const Color(0xffcfe3fc),
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    Global.api = 2;
                    Global.endpoint = "countries/india";
                  });
                },
                style: (Global.api == 2)
                    ? ButtonStyle(
                        side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.deepPurpleAccent, width: 3),
                        ),
                      )
                    : const ButtonStyle(),
                child: Text(
                  "Country",
                  style:  TextStyle(color: (Global.api == 2)? Colors.black : Colors.grey),
                ),
              ),
              button(text: "State"),
              button(text: "City"),
              TextButton(
                onPressed: () {
                  setState(() {
                    Global.api = 1;
                    Global.endpoint = "all";
                  });
                  setState(() {});
                },
                style: (Global.api == 1)
                    ? ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.deepPurpleAccent, width: 3),
                  ),
                )
                    : const ButtonStyle(),
                child: Text(
                  "Worldwide",
                  style: TextStyle(color: (Global.api == 1)? Colors.black : Colors.grey),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: APIHelper.covidHelpers.getAllData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error is : ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                Covid? data = snapshot.data;
                Global.image = data!.flag;
                return (data != null)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              display(
                                  h: size.height * 0.2,
                                  w: size.width * 0.44,
                                  colors: const Color(0xfffc1441),
                                  text: "Confirmed",
                                  num: data.todayCases),
                              display(
                                  h: size.height * 0.2,
                                  w: size.width * 0.44,
                                  colors: const Color(0xff157ffb),
                                  text: "Active",
                                  num: data.active),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              display(
                                  h: size.height * 0.2,
                                  w: size.width * 0.44,
                                  colors: const Color(0xff30a64a),
                                  text: "Recovered",
                                  num: data.todayRecovered),
                              display(
                                  h: size.height * 0.2,
                                  w: size.width * 0.44,
                                  colors: const Color(0xff6d757d),
                                  text: "Deceased",
                                  num: data.todayDeaths),
                            ],
                          ),
                        ],
                      )
                    : const Center(
                        child: Text("Data is Not Founds ...."),
                      );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: const BorderSide(color: Colors.black,width: 2)
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: const Center(
          child: Icon(
            Icons.refresh,
            size: 22,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  button({
    required String text,
  }) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  display(
      {required double h,
      required double w,
      required Color colors,
      required String text,
      required int num}) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: colors.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
                color: colors, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            "$num",
            style: TextStyle(
                color: colors, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ],
      ),
    );
  }
}
