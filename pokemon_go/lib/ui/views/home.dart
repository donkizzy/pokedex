

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
                  color: doveGrey.withOpacity(0.1),),
                child: GridView.builder(
                  shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 160,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12),
                    itemBuilder: (BuildContext context,int index) {
                    return Container(
                      height: 186,
                      width: 112,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(4.0),bottomLeft: Radius.circular(4.0))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Container(
                            height: 120,
                            width: 118,
                            decoration: BoxDecoration(
                              color: ceruleanBlue.withOpacity(0.4),

                            ),
                            child: Center(child: Image.asset('assets/test_pokemon.png',height: 70,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:const [
                                SizedBox(height: 10,),
                                Text('#001',style: TextStyle(
                                  color: doveGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                                ),),
                                SizedBox(height: 3,),
                                Text('Bulbasaur',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),),
                                SizedBox(height: 10,),
                                Text('Grass, Poison',style: TextStyle(
                                  color: doveGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                                ),),
                                SizedBox(height: 5,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ) ;
                    },),
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

