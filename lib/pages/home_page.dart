import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/cubit/app_cubits.dart';
import 'package:travel_app/misc/colors.dart';
import 'package:travel_app/widgets/app_large_text.dart';

import '../widgets/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  var image = {
    "balloning.png":"Ballonig",
    "hiking.png":"Ballonig",
    "kayaking.png":"Ballonig",
    "snorkling.png":"Ballonig",

  };

  List images = [

  ];
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state){
          if(state is LoadedState){
            var info = state.places;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50,left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu,size: 30,color: Colors.black54,),
                      // Expanded(child: Container()),
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(right: 20),
                        // padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: AppLargeText(text: "Discover"),
                ),
                SizedBox(height: 20,),
                Container(
                  child: TabBar(
                    labelPadding: EdgeInsets.only(left: 0,right: 20),
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: CircileTapIndicator(color: AppColors.mainColor, radius: 4),
                    tabs: [
                      Tab(text: "Places",),
                      Tab(text: "Inspiration",),
                      Tab(text: "Emotions",),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 300,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount:info.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index){
                          return
                            GestureDetector(
                              onTap: (){
                                BlocProvider.of<AppCubits>(context).detailPage(info[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15, top: 10),
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'http://mark.bslmeiyu.com/uploads/'+info[index].img
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );

                        },
                      ),
                      Text("There"),
                      Text("Bye"),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  margin: EdgeInsets.only(left: 20 , right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(text: "Explore More" , size: 22,),
                      AppText(text: "See All",color: AppColors.textColor1,),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 120,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 20),
                  child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_ , index){
                        return Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Column(
                            children: [
                              Container(
                                // margin: EdgeInsets.only(right: 50),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'img/'+image.keys.elementAt(index)),
                                    fit: BoxFit.cover,),),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                child: AppText(
                                  text: image.values.elementAt(index),
                                  color: AppColors.textColor2,
                                  size: 10,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),

              ],
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}


class CircileTapIndicator extends Decoration{

  final Color color;
  double radius;
  CircileTapIndicator({required this.color , required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color:color , radius:radius);
  }

}
class _CirclePainter extends BoxPainter{
  final Color color;
  double radius;
  _CirclePainter({required this.color , required this.radius});


  @override
  void paint(Canvas canvas, Offset offset,
      ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffest = Offset(configuration.size!.width/2 -radius/2 , configuration.size!.height -radius);
    canvas.drawCircle(offset+circleOffest, radius, _paint);
  }

}