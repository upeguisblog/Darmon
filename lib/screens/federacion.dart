import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/foundation/key.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
//import 'package:app_3/widgets/widgets.dart';
import 'package:app_3/theme/app_theme.dart';
import 'package:app_3/modelos/articulos.dart';

class FederacionScreen extends StatefulWidget {
  const FederacionScreen({Key? key}) : super(key: key);

  @override
  State<FederacionScreen> createState() => _FederacionScreenState();
}

class _FederacionScreenState extends State<FederacionScreen> {
  List<Article> articles = [];
  @override
  void initState() {
    super.initState();

    getWebSiteData();
  }

  Future getWebSiteData() async {
    final url = Uri.parse('https://fedepatin.org.co/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('div > h3 > a')
        .map((element) => element.innerHtml.trim())
        .toList();

    final urls = html
        .querySelectorAll('h3 > a')
        .map((element) =>
            'https://fedepatin.org.co/${element.attributes['href']}')
        .toList();

    final urlImages = html
        .querySelectorAll('div > a > img')
        .map((element) =>
            'https://fedepatin.org.co/${element.attributes['src']}')
        .toList();

    print('Count: ${titles.length}');

    setState(() {
      articles = List.generate(
          titles.length,
          (index) => Article(
              title: titles[index],
              url: urls[index],
              urlImage: urlImages[index]));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Web Scraping'),
        centerTitle: true,
        backgroundColor: AppTheme.primary,
      ),
      body: ListView.builder(
          itemCount: 5,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final article = articles[0];

            return ListTile(
                leading: Image.network(
                  article.urlImage,
                  width: 50,
                  fit: BoxFit.fitHeight,
                ),
                title: Text(article.title),
                subtitle: Text(article.url));
          }));
}
