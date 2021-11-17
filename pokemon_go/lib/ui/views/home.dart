

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/shared/app_constant.dart';
import 'package:pokemon_go/ui/widgets/pokemon_item.dart';
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
        length: 2,
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
                 bottom:   TabBar(
                   labelColor: mirageBlue,
                   unselectedLabelColor: doveGrey,
                   indicator: const CurvedRectangleIndicator(
                     indicatorHeight: 4.0,
                     indicatorColor: ceruleanBlue,
                   ),
                   tabs: [
                    const Tab(child: Text('All Pokemon\'s',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),),
                    Tab(child: Row(
                      children:  [
                      const  Text('Favourites',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                        const SizedBox(width: 5,),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ceruleanBlue,
                          ),
                          child: const Center(
                            child: Text('20',style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            )),
                          ),
                        )

                      ],
                    ),),
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
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                    childAspectRatio: width(context) /
                        (height(context) - 100),
                  ),
                    itemBuilder: (BuildContext context,int index) {
                    return  PokemonItem(key: UniqueKey(),) ;
                    },),
              ),
              Container(
                decoration: BoxDecoration(
                  color: doveGrey.withOpacity(0.1),),
                child: GridView.builder(
                  shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    itemCount: 10,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    childAspectRatio: width(context) /
                        (height(context) - 100),
                  ),
                    itemBuilder: (BuildContext context,int index) {
                    return PokemonItem(key: UniqueKey(),);
                    },),
              ),
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

