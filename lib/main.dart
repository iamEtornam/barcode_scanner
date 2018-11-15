import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Barcode Scanner',
      theme: new ThemeData(
  
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String result = "Welcome to Barcode Scanner";

Future _scanQR() async{
  try{
    String qrResult = await BarcodeScanner.scan();
    setState(() {
          result = qrResult;
        });
  }on PlatformException catch(ex){
    if(ex.code == BarcodeScanner.CameraAccessDenied)
{
setState(() {
   result = "Camera permission was Denied"; 
});
}
else{
  setState(() {
      result = "Unknown Error $ex";
    });
} 
 }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Barcode Scanner"),
      leading: Icon(Icons.camera),),
      body: Center(
        child: Text(
          result,
        style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}
