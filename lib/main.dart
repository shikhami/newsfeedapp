import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appstate.dart';
import 'card.dart';
import 'newsDummy.dart';
import 'newsModal.dart';
import 'shared.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child:
     MyApp()
  ));
}

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

       int index = 0;
  NewsModal newsModal;
  
           

  @override
  void initState() {
    fetchData();
    setupLastIndex();
    super.initState();
  }

  fetchData() {
    newsModal = NewsModal.fromJson(newsDummy);
  }

  void updateIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
    SharePreference.setLastIndex(newIndex);
  }

  void setupLastIndex() async {
    int lastIndex = await SharePreference.getLastIndex();
    if (lastIndex != null && lastIndex < newsModal.result.length - 1) {
      updateIndex(lastIndex);
    }
  }

  void updateContent(direction) {
    if (index <= 0 && direction == DismissDirection.down) {
      index = newsModal.result.length - 1;
    } else if (index == newsModal.result.length - 1 &&
        direction == DismissDirection.up) {
      index = 0;
    } else if (direction == DismissDirection.up) {
      index++;
    } else {
      index--;
    }
    updateIndex(index);
  }

  String getShareText() {
    return "${newsModal.result[index].title}\n${newsModal.result[index].url}";
  }

  Widget newsCard(int index) {
    return NewsCard(
      imgUrl: newsModal.result[index].urlToImage,
      primaryText: newsModal.result[index].title,
      secondaryText: newsModal.result[index].description,
      sourceName: newsModal.result[index].sourceName,
      author: newsModal.result[index].author,
      publishedAt: newsModal.result[index].publishedAt,
      url: newsModal.result[index].url,
    );
  }     
  @override
  Widget build(BuildContext context) {
     int prevIndex = index <= 0 ? 0 : index - 1;
    int nextIndex = index == newsModal.result.length - 1 ? 0 : index + 1;
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) {
    return MaterialApp(
    
      darkTheme: theme.getTheme(),
        theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
  
      home: Scaffold(
      appBar: AppBar(
        
        title:  Text('Feeds'),
        
        actions:[
            SizedBox(
              width: 80,
              child: RaisedButton(
                
                onPressed: (){
                 theme.setLightMode();
               },
               child: Text(' Light Theme'),),
            )   ,
             SizedBox(
               width:80,
               child: RaisedButton(onPressed: (){
                 theme.setDarkMode();
               },
               child: Text(' Dark Theme'),),
             )   ,

          
         
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.green,
            ),
            onPressed: () {
              
            },
          ),
         
        ],
        
      ),
      body: Center(
        child: Dismissible(
          background: newsCard(prevIndex),
          child: newsCard(index),
          secondaryBackground: newsCard(nextIndex),
          resizeDuration: Duration(milliseconds: 10),
          key: Key(index.toString()),
          direction: DismissDirection.vertical,
          onDismissed: (direction) {
            updateContent(direction);
          },
        ),
      ),
    ),
    );
      }
    );
  }
}

