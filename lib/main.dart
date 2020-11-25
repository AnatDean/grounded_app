import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

// ------- Animation Utils ---------

class InVisibleFlipper extends StatefulWidget {
  int duration;
  Widget child;
  Function toggle;
  Function predicate;
  int delay;
  String type;

  InVisibleFlipper(
      {@required this.duration,
      @required this.child,
      @required this.toggle,
      @required this.predicate,
      this.type,
      this.delay});

  @override
  createState() => _InVisibleFlipperState();
}

// class _InVisibleFlipperState extends State<InVisibleFlipper>
//     with SingleTickerProviderStateMixin {
//   bool _visible;
//   AnimationController _controller;
//   List<Animation> _animations = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         vsync: this,
//         duration: Duration(seconds: widget.type == 'breath' ? 1 : 2));

//     var test_animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(
//           0.0, 0.100,
//           curve: Curves.ease,
//         ),
//       ),
//     );
//     var _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
//     var _delayed2Animation = Tween(begin: 0.2, end: 0.4).animate(_controller);
//     var _delayed3Animation = Tween(begin: 0.4, end: 0.6).animate(_controller);
//     var _delayed4Animation = Tween(begin: 0.8, end: 1.0).animate(_controller);

//     print('here');
//     print(_animations);
//     print('and here');
//     this._animations.add(_animation);
//     this._animations.add(_delayed2Animation);
//     this._animations.add(_delayed3Animation);
//     this._animations.add(_delayed4Animation);
//     _controller.forward();
//   }

//   @override
//   dispose() {
//     print('disposing');
//     this._controller.dispose();
//     super.dispose();
//   }

//   void toggleVisible() {
//     setState(() => {_visible = true});
//   }

//   bool get visible {
//     return _visible;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.type == 'breath') {
//       print('printing - multiple animated builder');
//       print(this._animations[0]);

//       return AnimatedBuilder(
//           animation: this._controller,
//           child: widget.child,
//           builder: (BuildContext context, Widget child) {
//             return FadeTransition(
//                 opacity: this._animations[0], child: widget.child);
//           });
//     } else {
//       print('printing - singling animated opacity');
//       return AnimatedOpacity(
//           opacity: 1.0,
//           duration: Duration(milliseconds: 2000),
//           child: widget.child,
//           onEnd: () => {if (widget.predicate()) widget.toggle()});
//     }
//   }
// }

class _InVisibleFlipperState extends State<InVisibleFlipper> {
  bool _visible;
// AnimationController _controller;
  // Animation _animation;
  // @override
  // void initState() {
  // super.initState()
  //   _controller =
  //       AnimationController(vsync: this, duration: Duration(seconds: 2));
  //   _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  // }

  // @override
  // dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  void initState() {
    _visible = false;
    SchedulerBinding.instance.addPostFrameCallback((_) => {toggleVisible()});
  }

  void toggleVisible() {
    setState(() => {_visible = true});
  }

  bool get visible {
    return _visible;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedOpacity(
            opacity: _visible == true ? 1.0 : 0,
            duration: Duration(milliseconds: widget.duration),
            child: widget.child,
            onEnd: () => {if (widget.predicate()) widget.toggle()}),
      ],
    );
  }
}

// -------  Buttons & Media ---------
const MaterialColor myGreen =
    const MaterialColor(0xFF99CCA3, const <int, Color>{
  50: Color.fromRGBO(153, 204, 163, .9),
  100: Color.fromRGBO(153, 204, 163, .9),
  200: Color.fromRGBO(153, 204, 163, .9),
  300: Color.fromRGBO(153, 204, 163, .9),
  400: Color.fromRGBO(153, 204, 163, .9),
  500: Color.fromRGBO(153, 204, 163, .9),
  600: Color.fromRGBO(153, 204, 163, .9),
  700: Color.fromRGBO(153, 204, 163, .9),
  800: Color.fromRGBO(153, 204, 163, .9),
  900: Color.fromRGBO(153, 204, 163, .9),
});

class NextButton extends StatelessWidget {
  final String text;
  final Widget navigateTo;
  final Function onClick;
  const NextButton(
      {Key key, @required this.text, this.navigateTo, this.onClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => {
        if (navigateTo != null)
          {
            Navigator.of(context).pushReplacement(new PageRouteBuilder(
                pageBuilder: (BuildContext context, _, __) {
              return this.navigateTo;
            }, transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
              return new FadeTransition(opacity: animation, child: child);
            }))
          }
        else if (onClick != null)
          {onClick()}
      },
      color: Colors.orange,
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        // Replace with a Row for horizontal icon + text
        children: <Widget>[
          Text(this.text, style: TextStyle(color: Colors.white)),
          // Icon(Icons.arrow_forward, size: 40, color: Colors.white),
        ],
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Ground Me')));
                // Navigate back to first route when tapped.
              },
              icon: Icon(Icons.home),
            )));
  }
}

class Inputbox extends StatelessWidget {
  const Inputbox({
    Key key,
  }) : super(key: key);

  // var a = TextEditingController();
  // a.addListener(_onSubmit);

  // void _onSubmit() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextField(
        cursorColor: Colors.white,
        enableInteractiveSelection: true,
        // expands: true,
        showCursor: true,
        autofocus: true,
        cursorWidth: 3.0,
        style: TextStyle(color: Colors.white, fontSize: 15.0),
        decoration: new InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
      ),
    );
  }
}

class WhiteOutlineButton extends StatelessWidget {
  final String text;
  final Widget navigateTo;
  const WhiteOutlineButton({Key key, @required this.text, this.navigateTo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
            border: Border.all(width: 2, color: Colors.white)),
        child: FlatButton(
          color: myGreen,
          textColor: myGreen,
          onPressed: () {
            Navigator.of(context).pushReplacement(new PageRouteBuilder(
                pageBuilder: (BuildContext context, _, __) {
              return this.navigateTo;
            }, transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
              return new FadeTransition(opacity: animation, child: child);
            }));
          },
          child: Text(this.text,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal)),
        ));
  }
}

// -------- Page Layouts -----------

class BreathingCount extends StatefulWidget {
  String direction;
  Widget navigateTo;
  BreathingCount(this.direction, this.navigateTo);
  @override
  createState() => _BreathingCountState();
}

class _BreathingCountState extends State<BreathingCount> {
  List<int> _seconds = [1, 2, 3, 4];

  bool _breathedOut = false;
  void initState() {
    super.initState();
    _breathedOut = false;
  }

  @override
  Widget _buildTitle() {
    return InVisibleFlipper(
        child: RichText(
            text: TextSpan(
          text: 'Breathe ',
          style: TextStyle(fontSize: 40, color: Colors.white),
          children: <TextSpan>[
            TextSpan(
                text: widget.direction,
                style: TextStyle(fontSize: 40, color: Colors.white)),
          ],
        )),
        toggle: () => null,
        duration: 500,
        predicate: () => false);
  }

  void _breatheOut() {
    Navigator.of(context).pushReplacement(
        new PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
      return widget.navigateTo;
    }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return new FadeTransition(opacity: animation, child: child);
    }));
  }

  void _toggleButton() {
    setState(() {
      _breathedOut = true;
    });
  }

  Widget _buildAnimatedNumber(i) {
    return InVisibleFlipper(
        // type: 'breath',
        child: Text('$i', style: TextStyle(color: Colors.white, fontSize: 40)),
        toggle: widget.direction == 'In' ? _breatheOut : _toggleButton,
        duration: 1000 * i,
        // delay: i,
        predicate: () => (widget.direction == 'In' && i == 4 ||
            widget.direction == 'Out' && i == 4));
  }

  @override
  Widget build(BuildContext context) {
    List<int> s = _seconds;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildTitle(),
        Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  for (var i in s) _buildAnimatedNumber(i),
                ])),
        if (_breathedOut == true)
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: NextButton(text: 'Next', navigateTo: widget.navigateTo))
      ],
    );
  }
}

class CalmTextPage extends StatefulWidget {
  final String text;
  final Widget buttonToAppear;
  final bool isInput;

  const CalmTextPage(
      {Key key, @required this.text, this.buttonToAppear, this.isInput})
      : super(key: key);

  createState() => CalmTextPageState();
}

class CalmTextPageState extends State<CalmTextPage> {
  bool _showButton = false;
  void initState() {
    super.initState();
    _showButton = false;
  }

  void _toggleButton() {
    setState(() {
      _showButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: myGreen,
        child: Column(children: [
      Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(children: <Widget>[
            InVisibleFlipper(
                predicate: () => true,
                toggle: () =>
                    widget.buttonToAppear == null ? null : _toggleButton(),
                duration: 1500,
                child: Text(widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, color: Colors.white))),
            if (widget.isInput == true)
              InVisibleFlipper(
                  predicate: () => true,
                  toggle: () => null,
                  duration: 1500,
                  child: Inputbox()),
            if (_showButton == true && widget.buttonToAppear != null)
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InVisibleFlipper(
                      predicate: () => false,
                      toggle: () => null,
                      duration: 1500,
                      child: widget.buttonToAppear)),
          ]))
    ]));
  }
}

class WellDone extends StatelessWidget {
  final String message;
  final Widget navigateTo;
  const WellDone({Key key, @required this.message, @required this.navigateTo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: myGreen,
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CalmTextPage(
                            text: this.message,
                            buttonToAppear: NextButton(
                                text: 'Next', navigateTo: this.navigateTo))),
                  ]),
                  HomePageButton(),
                ]),
          )),
    );
  }
}

class SenseForm extends StatefulWidget {
  final String sense;
  final int number;
  final Widget nextPage;
  final bool overideText;
  final String text;

  SenseForm(
      {this.sense,
      this.number,
      this.nextPage,
      this.overideText = false,
      this.text});
  @override
  createState() => _SenseFormState();
}

class _SenseFormState extends State<SenseForm> {
  int _count = 100;
  void initState() {
    super.initState();
    _count = widget.number;
  }

  void _decreaseCount() {
    setState(() {
      _count = _count - 1;
    });
  }

  String _getSense() {
    return widget.sense;
  }

  String _buildTitle() {
    String sense = _getSense();
    if (widget.overideText) {
      return widget.text;
    } else {
      return widget.number == _count
          ? "The first thing I $sense is:"
          : " $_count";
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //     height: 250,

        // constraints: BoxConstraints.expand(),
        // child: Padding(
        //     padding: const EdgeInsets.only(top: 200),
        // child:
        Column(children: <Widget>[
      CalmTextPage(
          text: _buildTitle(),
          isInput: true,
          buttonToAppear: NextButton(
            text: 'next',
            onClick: _decreaseCount,
            navigateTo: _count == 1 ? widget.nextPage : null,
          )),
    ]);
  }
}

// -------- Routes & App --------
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ground Me',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: myGreen,
      ),
      home: MyHomePage(title: 'Ground Me'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional(0.0, 0.0),
        color: myGreen,
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                constraints: BoxConstraints.expand(width: 250.0, height: 250.0),
                decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(120.0)),
                    border: Border.all(width: 8, color: Colors.orange)),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  focusColor: Colors.orange,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
                    );
                  },
                  child: Text('Begin', style: TextStyle(fontSize: 30)),
                  shape: new CircleBorder(),
                )),
            Container(
                decoration: new BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white)),
                child: FlatButton(
                  color: myGreen,
                  textColor: myGreen,
                  onPressed: () {},
                  child: const Text('About Ground Me',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal)),
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: myGreen,
          child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [BreathingCount('In', ThirdRoute())],
              ))),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: AlignmentDirectional(0.0, 0.0),
          color: myGreen,
          child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [BreathingCount('Out', FourthRoute())],
              ))),
    );
  }
}

class FourthRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: myGreen,
            height: double.maxFinite,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: CalmTextPage(
                      buttonToAppear:
                          NextButton(text: 'Next', navigateTo: FifthRoute()),
                      text:
                          'I would like you to tell me some things about your surroundings.'),
                )),
                Positioned(
                    child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: HomePageButton(),
                ))
              ],
            )));
  }
}

class FifthRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myGreen,
        height: double.maxFinite,
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(children: <Widget>[
              CalmTextPage(text: 'We\'ll go through each sense, one by one.'),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CalmTextPage(
                    text: 'Take as much time as you need.',
                    buttonToAppear:
                        NextButton(text: 'Next', navigateTo: IntroSightPage())),
              ),
            ]),
          ),
          Positioned(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: HomePageButton())),
        ]),
      ),
    );
  }
}

class IntroSightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: myGreen,
          child: Stack(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 100),
                child: CalmTextPage(
                    text:
                        'First, try to name 5 things that you can see right now.',
                    buttonToAppear:
                        NextButton(text: 'Okay', navigateTo: SightForm()))),
            Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: HomePageButton())),
          ])),
    );
  }
}

class SightForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: myGreen,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SenseForm(
                  sense: 'see',
                  number: 5,
                  nextPage: WellDone(
                      message: 'Well done.', navigateTo: IntroFeelingPage())),
            ),
            Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: HomePageButton())),
          ])),
    );
  }
}

class IntroFeelingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.maxFinite,
          color: myGreen,
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(children: <Widget>[
                CalmTextPage(
                    text:
                        'Now try to name 4 things your body can feel physically.'),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CalmTextPage(
                      text: 'For example, your feet on the floor.',
                      buttonToAppear:
                          NextButton(text: 'Next', navigateTo: FeelForm())),
                ),
              ]),
            ),
            Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: HomePageButton())),
          ])),
    );
  }
}

class FeelForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: myGreen,
          height: double.maxFinite,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SenseForm(
                  sense: 'feel',
                  number: 4,
                  nextPage: WellDone(
                    message: 'You\'re doing great.',
                    navigateTo: IntroHearingPage(),
                  )),
            ),
            Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: HomePageButton())),
          ])),
    );
  }
}

class IntroHearingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: myGreen,
          height: double.maxFinite,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: CalmTextPage(
                  text: 'Now try to name 3 things you can hear.',
                  buttonToAppear:
                      NextButton(text: 'Next', navigateTo: HearForm())),
            ),
            Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: HomePageButton())),
          ])),
    );
  }
}

class HearForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: myGreen,
          height: double.maxFinite,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SenseForm(
                  sense: 'hear',
                  number: 3,
                  nextPage: WellDone(
                    message: 'Good',
                    navigateTo: SmellForm(),
                  )),
            ),
            Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: HomePageButton())),
          ])),
    );
  }
}

class SmellForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: myGreen,
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SenseForm(
                overideText: true,
                text: 'Now what can you smell?',
                number: 1,
                nextPage: AirForm(),
              ),
            ),
            Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: HomePageButton())),
          ])),
    );
  }
}

class AirForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: myGreen,
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SenseForm(
                overideText: true,
                text: 'And is the air mild, warm, hot or cold?',
                number: 1,
                nextPage: FinalBreathin(),
              ),
            ),
            Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: HomePageButton()))
          ])),
    );
  }
}

class FinalBreathin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            color: myGreen,
            child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [BreathingCount('In', FinalBreatheOut())],
                ))));
  }
}

class FinalBreatheOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            color: myGreen,
            child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [BreathingCount('Out', FinalPage())],
                ))));
  }
}

class FinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: myGreen,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: CalmTextPage(text: 'You are here.')),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CalmTextPage(
                      text: 'You are safe.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CalmTextPage(
                      text: 'You are loved.',
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            WhiteOutlineButton(
                                text: 'Begin Again',
                                navigateTo: MyHomePage(title: 'Ground Me')),
                            WhiteOutlineButton(
                                text: 'About',
                                navigateTo: MyHomePage(title: 'Ground Me')),
                          ]))
                ]),
              ])),
    );
  }
}
