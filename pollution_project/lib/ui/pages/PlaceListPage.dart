import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pollution_project/ui/pages/PlacePage.dart';
import 'package:pollution_project/ui/cityFunctions.dart';
import 'package:pollution_project/ui/pages/LoadingPage.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pollution_project/models/user.dart';

class PlaceListPage extends StatefulWidget {
  PlaceListPage({Key? key}) : super(key: key);

  @override
  _PlaceListPageState createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserModel>();
    List<Map<String, dynamic>> placeList = user.savePlaces; // for loop
    print(user.savePlaces);
    int placeLength = user.lengthPlace;
    print('PlaceList: $placeLength');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Air Pollution',
              style: GoogleFonts.birthstone(
                textStyle: const TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
            const Text(
              'Place',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
              itemCount: placeLength,
              itemBuilder: ((context, index) {
                print('PlaceList: $placeLength');
                var place = placeList[index];
                print(place['city']);
                return (place['ic'] == 'error')
                    ? const LoadingPage()
                    : BoxItem(
                        city: place['city'],
                        state: place['state'],
                        country: place['country'],
                        ic: place['ic'],
                        tp: place['tp'],
                        aqius: place['aqius']);
              }),
            )),
          ],
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}

class BoxItem extends StatelessWidget {
  final String city;
  final String state;
  final String country;
  final String ic;
  final int tp;
  final int aqius;

  BoxItem({
    Key? key,
    required this.city,
    required this.state,
    required this.country,
    required this.ic,
    required this.tp,
    required this.aqius,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlacePage(country: country, state: state, city: city),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$city, $country',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  Text('$state', style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.network(
                        'https://www.airvisual.com/images/${getImage(ic)}.png',
                        height: 20,
                      ),
                      SizedBox(width: 5),
                      Text('${tp.toString()}°'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    getDescription(aqius),
                    style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.all(1.5),
                    width: 30,
                    color: getBgColor(aqius),
                    child: Center(
                      child: Text(
                        aqius.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: getTxtColor(aqius),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Text('US AQI', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
