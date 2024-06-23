import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_me_new/app/models/article.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageView extends StatefulWidget {
  HomePageView({Key? key}) : super(key: key);
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final Dio dio = Dio();

  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 112, 112),
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ListTile(
          onTap: () {
            _launchUrl(
              Uri.parse(article.url ?? ""),
            );
          },
          leading: Image.network(
            article.urlToImage ?? placeHolderImageLink,
            height: 250,
            width: 100,
            fit: BoxFit.cover,
          ),
          title: Text(
            article.title ?? "",
          ),
          subtitle: Text(
            article.publishedAt ?? "",
          ),
        );
      },
    );
  }

  Future<void> _getNews() async {
    final response = await dio.get(
      'https://api.worldnewsapi.com/search-news?api-key=$newsAPIKey&text=pelecehan seksual&source-countries=id&language=id&sort=publish-time&sort-direction=ASC&number=10',
    );
    final articlesJson = response.data["news"] as List;
    setState(() {
      List<Article> newsArticle =
          articlesJson.map((a) => Article.fromJson(a)).toList();
      newsArticle = newsArticle.where((a) => a.title != "[Removed]").toList();
      articles = newsArticle;
    });
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      Get.snackbar('Ooops...', 'Can not launch url');
    }
  }
}
