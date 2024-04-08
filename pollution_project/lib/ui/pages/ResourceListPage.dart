import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/ui/pages/ResourcePage.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';

class ResourceListPage extends StatefulWidget {
  ResourceListPage({Key? key}) : super(key: key);

  @override
  _ResourceListPageState createState() => _ResourceListPageState();
}

class _ResourceListPageState extends State<ResourceListPage> {
  List<Map<String, dynamic>> _resources = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _fetchResources() async {
    db.collection('resources').get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          var data = docSnapshot.data();
          final resource = <String, dynamic>{
            'article_name': data['article_name'],
            'updated_date': data['updated']['date'],
            'updated_time': data['updated']['time'],
            'author': data['author'],
            'description': data['description'],
            'image': data['image'],
          };
          setState(() {
            _resources.add(resource);
          });
        }

        print(_resources);
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchResources();
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Resource',
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
                  itemCount: _resources.length,
                  itemBuilder: ((context, index) {
                    var resource = _resources[index];
                    return ResourceBox(
                        article_name: resource['article_name'],
                        author: resource['author'],
                        updated_date: resource['updated_date'],
                        updated_time: resource['updated_time'],
                        description: resource['description'],
                        image: resource['image']);
                  }),
                ),
              ),
            ],
          )),
      bottomNavigationBar: MyNavigationBar(index: 2),
    );
    ;
  }
}

class ResourceBox extends StatelessWidget {
  final String article_name;
  final String author;
  final String updated_date;
  final String updated_time;
  final String description;
  final String image;

  ResourceBox({
    Key? key,
    required this.article_name,
    this.author = "IQAir Staff Writers",
    required this.updated_date,
    required this.updated_time,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResourcePage(
                  articleName: article_name,
                  author: author,
                  updatedDate: '$updated_date | $updated_time',
                  content: description,
                  image: image),
            ));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                article_name,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Image.network(
              image,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
