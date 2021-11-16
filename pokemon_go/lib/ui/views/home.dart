

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/ui/widgets/rectangle_tab_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: _tabController.length,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
               SliverAppBar(
                backgroundColor: Colors.white,
                floating: true,
                pinned: true,
                centerTitle: true,
                title: Image.asset('assets/logo.png',height: 33,),
                 bottom:  TabBar(
                   controller: _tabController,
                   labelColor: mirageBlue,
                   unselectedLabelColor: doveGrey,
                   indicator: const CurvedRectangleIndicator(
                     indicatorHeight: 4.0,
                     indicatorColor: ceruleanBlue,
                   ),
                   tabs: const [
                    Tab(child: Text('All Pokemon\'s',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),),
                    Tab(child: Text('Favourites',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),),
                   ],
                 ),
              ),

            ];
          },
          body:  TabBarView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: doveGrey.withOpacity(0.2),),
                child: Gr,
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  }

