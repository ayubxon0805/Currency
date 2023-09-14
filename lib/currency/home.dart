import 'dart:async';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:webscrap/currency/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  num number = 0;
  List<String> bankPrice2 = [];
  List<String> bankName1 = [];
  List<String> bankName2 = [];
  List<String> bankPrice1 = [];
  List<Article> articles = [];
  @override
  void initState() {
    super.initState();
    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://bank.uz/uz/currency');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("malumot tog'ri keldi");
      print(response.body);
    }
    dom.Document html = dom.Document.html(response.body);
///////////////Sotish
    final title1 = html
        .querySelectorAll('div > a > span')
        .map((e) => e.innerHtml.trim())
        .toList();
    bankName1 = title1;
    print('narxi1 ${bankName1.length}');
    bankName1.removeRange(0, 5);
    print(bankName1.length);
    bankName1.removeRange(29, 237);
    print(bankName1.length);
    final price1 = html
        .querySelectorAll('div:nth-child(3)> div > span')
        .map((e) => e.innerHtml.trim())
        .toList();
    bankPrice1 = price1;
    print('narxi1 ${bankPrice1.length}');
    print(bankPrice1.length);
    bankPrice1.removeRange(29, 126);
    print(bankPrice1.length);
///////////////Sotib olish
    final title2 = html
        .querySelectorAll('div > div:nth-child(3) > div > div > a > span')
        .map((e) => e.innerHtml.trim())
        .toList();
    bankName2 = title2;
    bankName2.removeRange(29, 119);
    final price2 = html
        .querySelectorAll('div > div > div > div:nth-child(1) > div > span')
        .map((e) => e.innerHtml.trim())
        .toList();
    bankPrice2 = price2;
    print('narxi2 ${bankPrice2.length}');
    bankPrice2.removeRange(0, 6);
    print(bankPrice2.length);
    bankPrice2.removeRange(29, 122);
    print(bankPrice2.length);
  }

///////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Scraping'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Sotish',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 730,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    reverse: false,
                    padding: const EdgeInsets.all(12),
                    itemCount: bankName2.length,
                    itemBuilder: (context, index) {
                      return Text(
                        bankName2[index].toString(),
                        style: TextStyle(fontSize: 17),
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 730,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    reverse: false,
                    padding: const EdgeInsets.all(12),
                    itemCount: bankPrice1.length,
                    itemBuilder: (context, index) {
                      return Text(
                        bankPrice1[index].toString(),
                        style: const TextStyle(fontSize: 17),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2, color: Colors.black),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Sotib Olish',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 730,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      reverse: false,
                      padding: const EdgeInsets.all(12),
                      itemCount: bankName1.length,
                      itemBuilder: (context, index) {
                        return Text(
                          bankName1[index].toString(),
                          style: const TextStyle(fontSize: 17),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 730,
                    child: ListView.builder(
                      reverse: false,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(12),
                      itemCount: bankPrice2.length,
                      itemBuilder: (context, index) {
                        return Text(
                          bankPrice2[index].toString(),
                          style: const TextStyle(fontSize: 17),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
