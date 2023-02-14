import 'package:flutter/material.dart';
import '../component/customdivider.dart';
import '../component/utils.dart';
import '../controller/agecalculate.dart';
import '../style/app_color.dart';
import '../style/app_fonts.dart';
import '../style/app_size.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>with TickerProviderStateMixin {

  late AnimationController animationController;
  late AnimationController animationController2;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;
  late Animation<Offset> _offsetAnimation2;


  @override
  void initState() {

    animationController=AnimationController(vsync: this,duration: const Duration(milliseconds:1000));
    animationController2=AnimationController(vsync: this,duration: const Duration(milliseconds:1000));

    _opacityAnimation=Tween<double>(begin: 0.0,end: 2.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut))
      ..addStatusListener((status) {setState(() {});});

    _offsetAnimation=Tween<Offset>(begin: const Offset(0.0, 1.0),end:const Offset(0.0, 0.0))
        .animate(animationController)..addStatusListener((status) { });

    _offsetAnimation2=Tween<Offset>(begin: const Offset(0.0, 1.0),end:const Offset(0.0, 0.0))
        .animate(animationController)..addStatusListener((status) { });

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xff2A4988),
              Color(0xff00B454),
            ])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20,vertical: 10),
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(height: 50,),

                  SlideTransition(
                    position: _offsetAnimation,

                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: Text(AppName.toUpperCase(),
                        style: largeFonts.copyWith(
                            fontSize:SizeConfig.blockHorizontal!*7,
                            color:fontColor
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50,),

                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.20),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Row(
                              children: [
                                Text("Date of Birth",
                                  style: smallFonts.copyWith(
                                      fontSize:SizeConfig.blockHorizontal!*3.5,
                                      color:fontColor
                                  ),
                                ),
                                const Spacer(),
                                Text(dateFormat.format(selectedBithDate),
                                  style: smallFonts.copyWith(
                                      fontSize:SizeConfig.blockHorizontal!*3.5,
                                      color:fontColor
                                  ),)
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text("Today Date",
                                  style: smallFonts.copyWith(
                                      fontSize:SizeConfig.blockHorizontal!*3.5,
                                      color:fontColor
                                  ),
                                ),
                                const Spacer(),
                                Text(dateFormat.format(selectedCurrentDate),
                                  style: smallFonts.copyWith(
                                      fontSize:SizeConfig.blockHorizontal!*3.5,
                                      color:fontColor
                                  ),)
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height:20,),

                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                     position: _offsetAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.20),
                            borderRadius: BorderRadius.circular(5)),

                        child: Row(
                          children: [

                            Expanded(child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text('Age',
                                  style: mediumFonts.copyWith(
                                      fontSize:SizeConfig.blockHorizontal!*4,
                                      color:fontColor
                                  ),),

                                Text.rich(
                                  TextSpan(
                                    children:[
                                      TextSpan(text:AgeCalculator.age(selectedBithDate, today: selectedCurrentDate).years.toString(),
                                        style: mediumFonts.copyWith(
                                            fontSize:SizeConfig.blockVertical!*4.5,
                                            color:fontColor
                                        ),),

                                      TextSpan(text:'Years',
                                        style: mediumFonts.copyWith(
                                            fontSize:SizeConfig.blockHorizontal!*3.5,
                                            color:fontColor
                                        ),)
                                    ])
                                ),

                                Text("${AgeCalculator.age(selectedBithDate, today: selectedCurrentDate)
                                    .months.toString()} Months | ${AgeCalculator.age(selectedBithDate, today: selectedCurrentDate)
                                    .days.toString()} Days", style: smallFonts.copyWith(
                                      fontSize:SizeConfig.blockHorizontal!*3.5,
                                      color:fontColor
                                  ),),
                              ],
                            )),

                            const CustomDivider(),

                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text('Next Birthday',
                                  style: mediumFonts.copyWith(
                                      fontSize:SizeConfig.blockHorizontal!*5,
                                      color:fontColor
                                  ),),

                                Text(AgeCalculator.findDayName().toString(),
                                  style: smallFonts.copyWith(
                                      fontSize:SizeConfig.blockHorizontal!*6,
                                      color:fontColor
                                  ), ),

                                Text("${AgeCalculator.timeToNextBirthday(selectedBithDate, fromDate: selectedCurrentDate).months}"
                                    " months | ${AgeCalculator.timeToNextBirthday(selectedBithDate, fromDate: selectedCurrentDate).days}  Days",
                                  style: smallFonts.copyWith(
                                      fontSize:SizeConfig.blockHorizontal!*3.5,
                                      color:fontColor
                                  ),),

                              ],
                            )),

                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height:20,),

                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        height: 190,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.20),
                            borderRadius: BorderRadius.circular(5)),

                        child: Column(
                          children: [

                            Text("Age in",style: mediumFonts.copyWith(
                                fontSize:SizeConfig.blockHorizontal!*4.5,
                                color:fontColor
                            ),),
                            const SizedBox(height: 20,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomPoint(
                                  title: 'Years',
                                  subTitle:  AgeCalculator.age(selectedBithDate, today: selectedCurrentDate).years.toString(),
                                ),

                                CustomPoint(title: 'Months',
                                  subTitle:(AgeCalculator.age(selectedBithDate, today: selectedCurrentDate).years * 12).toString(),
                                ),
                                CustomPoint(title: 'Days',
                                  subTitle:AgeCalculator.daysBetween(selectedBithDate, selectedCurrentDate).toString(),
                                ),
                              ],
                            ),

                            const Spacer(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomPoint(
                                  title: 'Weeks',
                                  subTitle: (AgeCalculator.age(selectedBithDate, today: selectedCurrentDate).years * 52).toString(),
                                ),
                                CustomPoint(title: 'Hours',
                                  subTitle:AgeCalculator.hoursBetween(selectedBithDate, selectedCurrentDate).toString(),
                                ),
                                CustomPoint(title: 'Minutes',
                                  subTitle:AgeCalculator.minutesBetween(selectedBithDate, selectedCurrentDate).toString(),
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),


                  const SizedBox(height:50,),

                  //Calculate Button
                  SlideTransition(
                   position: _offsetAnimation2,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(buttonColor),
                          ),
                          onPressed: (){Navigator.pop(context);},
                          child: Text("Re-Calculate".toUpperCase(),
                            style: mediumFonts.copyWith(
                              fontSize:SizeConfig.blockHorizontal!*5,
                              color:fontColor
                          ),
                          )
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPoint extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final double? fontSize;
  const CustomPoint({
    required this.title,
    required this.subTitle,
     this.fontSize,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title!,style: smallFonts.copyWith(
            fontSize:SizeConfig.blockHorizontal!*4,
            color:fontColor
        ),),
        const SizedBox(height: 5,),
        Text(subTitle!,
          style: smallFonts.copyWith(
            fontSize:SizeConfig.blockHorizontal!*4,
            color:fontColor
        ),),
      ],
    );
  }
}

