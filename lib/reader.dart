import 'dart:async';
import 'package:epub/epub.dart' as epub;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';

class Reader extends StatefulWidget {
  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  String content = 'no';

  @override
  void initState() {
    _showReaderInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('書籍リーダー'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Html(
            data: content,
          ),
        ),
      ),
    );
  }

  _showReaderInfo() async {
    epub.EpubBook book = await fetchBook(
        'http://www.naigai-net.co.jp/dlmagic/dlmagic.php?url=http://www.naigai-net.co.jp/ebook/chumonno_oi_ryoriten.epub');
    epub.EpubContent bookContent = book.Content;
    Map<String, epub.EpubTextContentFile> htmlFiles = bookContent.Html;
//    htmlFiles.values.forEach((epub.EpubTextContentFile htmlFile) {
//      String htmlContent = htmlFile.Content;
//      print(htmlContent);
//    });
    print(htmlFiles.values.toList().length);
    setState(() {
      content = htmlFiles.values.toList()[2].Content;
    });
  }

  Future<epub.EpubBook> fetchBook(String url) async {
    // Hard coded to Alice Adventures In Wonderland in Project Gutenberb
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the EPUB
      return epub.EpubReader.readBook(response.bodyBytes);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load epub');
    }
  }
}
