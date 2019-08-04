import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fade Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  int _counter = 0;
  AnimationController _controllerGreen;
  AnimationController _controllerBlue;
  AnimationController _controllerSlide;
  Animation<double> _animation;
  Animation<Offset> _animationSlide;
  Animation  _animationTween;
  @override
  void initState() {
    super.initState();
    _controllerBlue = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2500));
    _controllerGreen = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = Tween<double>(begin: 0.0, end: 1).animate(_controllerGreen);
 
 
 _animationTween=ColorTween(begin: Colors.blue,end: Colors.transparent).animate(_controllerBlue);
     _controllerBlue.addStatusListener((status) {
      if (status == AnimationStatus.dismissed)
        _controllerBlue.forward();
      else if (status == AnimationStatus.completed) _controllerBlue.reverse();
    });
_controllerBlue.forward();
    _controllerGreen.addStatusListener((status) {
      if (status == AnimationStatus.dismissed)
        _controllerGreen.forward();
      else if (status == AnimationStatus.completed) _controllerGreen.reverse();
    });



      _controllerSlide=AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000)
        );
   _animationSlide=Tween(begin: Offset.fromDirection(-27,1),end:Offset.fromDirection( -27,-5) ).animate(_controllerSlide);
    //_animationSlide=Tween(begin: Offset(4,124),end:Offset(100,25) ).animate(_controllerSlide);
    _controllerSlide.addStatusListener((status){
      if(status==AnimationStatus.completed)
      _controllerSlide.reverse();
      if(status==AnimationStatus.dismissed)
      _controllerSlide.forward();
    });
  }



  @override
  void dispose() {
    super.dispose();
    _controllerGreen.dispose();
    _controllerBlue.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerGreen.forward();
    _controllerBlue.forward();
    _controllerSlide.forward();
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            width: 200,
                height: 200,
                child:Stack(
            children:[
           
              AnimatedBuilder(
                animation: _animationTween,
                builder:(context,widget)=>
               Container(
                
                decoration: BoxDecoration(
                 color: _animationTween.value, 
                 border: Border.all(width:0),
                  shape: BoxShape.circle
          
                ),
              )), 
              SizeTransition(axis:Axis.vertical,
              sizeFactor: CurvedAnimation(curve: Curves.easeInOut,parent: _controllerGreen),
              child:Icon(Icons.access_alarms,size: 60,)),
              SlideTransition(position: _animationSlide,child:Icon(Icons.account_circle,size:62),textDirection: TextDirection.ltr,),
              ]
              )
          
        )));
  }
}
