import 'package:age_calculator/screen/result_page.dart';
import 'package:age_calculator/style/app_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../component/utils.dart';
import '../style/app_color.dart';
import '../style/app_fonts.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {


  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late Animation<double> _OpacityAnimation;


  @override
  void initState() {

    _animationController=AnimationController(duration: const Duration(seconds:2),vsync: this);
    _animation=Tween<Offset>(begin: const Offset(0.0, 1.0),end:const Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.ease))
      ..addStatusListener((status) {setState(() {
    });});

    _animationController.forward();
    _OpacityAnimation=Tween<double>(begin:0.0,end:2.0).animate(_animationController)
      ..addStatusListener((status) {setState(() {
    });});
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    return Scaffold(

      body: Container(
        height: SizeConfig.height,
        width:SizeConfig.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff2A4988),
                Color(0xff00B454),
              ])
        ),

        child: SafeArea(

          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal:20,vertical: 15),
            child: SingleChildScrollView(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height:SizeConfig.blockVertical!*6),

                  //Application Name Text String
                  SlideTransition(
                      position: _animation,
                      child: FadeTransition(
                          opacity:_OpacityAnimation ,
                          child: Text(AppName.toUpperCase(),
                            style: largeFonts.copyWith(
                              fontSize:SizeConfig.blockHorizontal!*7,
                              color:fontColor
                            ),
                          ))),

                  const SizedBox(height:20,),

                  //Application Description Text String
                  SlideTransition(
                      position: _animation,
                      child: FadeTransition(
                          opacity: _OpacityAnimation,
                          child: Text(AppDescription,
                            textAlign: TextAlign.center,
                            style: smallFonts.copyWith(
                                fontSize:SizeConfig.blockHorizontal!*3.5,
                                color:fontColor
                            ),
                          ))),

                  const SizedBox(height:40,),

                  FadeTransition(
                    opacity: _OpacityAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal:20,vertical: 20),
                      height:350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.20)
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),

                          Text("Select Date of Birth",
                            style:mediumFonts.copyWith(
                                fontSize:SizeConfig.blockHorizontal!*4,
                                color:fontColor
                            ),
                          ),

                          const SizedBox(height: 7,),
                          Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(.40))
                              ),
                              onPressed: (){
                                _selectDate(context, selectedBithDate, "BirthDate");
                              },
                              child: Row(
                                children: [
                                  Text(dateFormat.format(selectedBithDate),style: GoogleFonts.roboto(color: Colors.black),),

                                  const Spacer(),

                              const Icon(Icons.date_range,)
                          ],
                        ),
                            ),
                      ),

                          const SizedBox(height: 20,),

                          Text("Today Date",
                            style:mediumFonts.copyWith(
                                fontSize:SizeConfig.blockHorizontal!*4,
                                color:fontColor
                            ),
                          ),

                          const SizedBox(height: 7,),
                          Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(.40))
                              ),
                              onPressed: (){
                                _selectDate(context, selectedCurrentDate, "CurrentDate");
                              },
                              child: Row(
                                children: [
                                  Text(dateFormat.format(selectedCurrentDate),style: GoogleFonts.roboto(color: Colors.black),),

                                  const Spacer(),

                                  const Icon(Icons.date_range,)
                                ],
                              ),
                            ),
                          ),

                          const Spacer(),
                          //Calculate Button
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                //color:buttonColor
                            ),
                            child: ElevatedButton(

                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(buttonColor),
                                ),
                                onPressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (_)=>const ResultPage()));
                                },
                                child: Text("Calculate".toUpperCase(),style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),
                            )
                            ),
                          ),

                          const Spacer(),
                        ],
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

  Future<void> _selectDate(BuildContext context, DateTime initialDate, String from) async {
    if(from == 'BirthDate') {
      final DateTime? pickedBirthDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );
      if (pickedBirthDate != null && pickedBirthDate != selectedBithDate) {
        setState(() {
          selectedBithDate = pickedBirthDate;
        });
      }
    }
    if(from == "CurrentDate"){
      final DateTime? pickedCurrentDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );

      if (pickedCurrentDate != null && pickedCurrentDate != selectedCurrentDate) {
        setState(() {
          selectedCurrentDate = pickedCurrentDate;
        });
      }
    }

  }
}




