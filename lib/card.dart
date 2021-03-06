import 'package:flutter/material.dart';


class NewsCard extends StatelessWidget {
  final String url,
      imgUrl,
      primaryText,
      secondaryText,
      sourceName,
      author,
      publishedAt;

  NewsCard(
      {this.url,
      this.imgUrl,
      this.primaryText,
      this.secondaryText,
      this.sourceName,
      this.author,
      this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.2),
            child: Image.network(
             
              imgUrl,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              children: [
                Text('#Governance',
                  style: TextStyle(
                    color:Colors.red,
                  fontWeight: FontWeight.w500, fontSize: 14.0),
                ),
                SizedBox(width:20,),
                 Text('#History',
                      
                  style: TextStyle( color:Colors.red,fontWeight: FontWeight.w500, fontSize: 14.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              primaryText,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                secondaryText,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
              )),
          Container(
            padding: EdgeInsets.only(left:14,top:10,),
            child: Text('Read Full Article',style: TextStyle(color: Colors.blue,),))
        ],
      ),
      
     
    );
  }
}