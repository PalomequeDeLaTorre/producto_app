import 'package:flutter/material.dart';

class FondoLogin extends StatelessWidget {

  final Widget child;

  const FondoLogin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: const Color.fromARGB(255, 224, 15, 0),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              child:  Icon(
                Icons.person_pin, 
                color: Colors.white, 
                size: 100,),
            ),
          ),
          this.child,
        ],
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  //const _PurpleBox({super.key});

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      //color: Colors.indigo,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 82, 235, 1),
            Color.fromRGBO(0, 13, 196, 0.369),
          ]
        )
      ),
      child: Stack(
        children: [
          Positioned(
           child: _Esfera(),
           top:90,
           left:30,
           ),
          Positioned(
           child: _Esfera(),
           top:90,
           left:300,
           ),
          Positioned(
           child: _Esfera(),
           top:200,
           left:30,
           ),
          Positioned(
           child: _Esfera(),
           top:200,
           left:300,
           ),
        ],
      )
    );
  }
}

class _Esfera extends StatelessWidget {
  //const _Esfera({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}