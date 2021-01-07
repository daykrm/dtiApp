import 'package:dtiapp/constants.dart';
import 'package:flutter/material.dart';

class CalculateDTI extends StatefulWidget {
  final title;

  const CalculateDTI({Key key, this.title}) : super(key: key);
  @override
  _CalculateDTIState createState() => _CalculateDTIState();
}

class _CalculateDTIState extends State<CalculateDTI> {
  var _income = TextEditingController();
  var _creditCard = TextEditingController();
  var _creditCar = TextEditingController();
  var _creditOther = TextEditingController();

  double dti = 0;

  final _formKey = GlobalKey<FormState>();

  void calDTI() {
    int income = int.parse(_income.text.split('.')[0].replaceAll(RegExp('-'), ''));
    int card = int.parse(_creditCard.text.split('.')[0].replaceAll(RegExp('-'), ''));
    int car = int.parse(_creditCar.text.split('.')[0].replaceAll(RegExp('-'), ''));
    int other = int.parse(_creditOther.text.split('.')[0].replaceAll(RegExp('-'), ''));

    if(income != 0) {
      var result = (card + car + other)/(income/12) * 100;
      dti = result;
      print(dti);
      setState(() {});
    }
  }

  void reset() {
    dti = 0;
    _income.clear();
    _creditCard.clear();
    _creditCar.clear();
    _creditOther.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('อัตราหนี้สินต่อรายได้',style: TextStyle(fontSize: 36),),
                  SizedBox(height: 20),
                  (dti.toStringAsFixed(1).split('.')[1] == '0') ? Text('DTI : ${dti.toString().split('.')[0]} %') : Text('${dti.toStringAsFixed(1)} %'),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InputBox(controller: _income, errorText: 'กรุณาระบุรายได้ต่อปี', labelText: 'รายได้/ปี',),
                        InputBox(controller: _creditCard, errorText: 'กรุณาระบุยอดชำระเครดิตการ์ดขั้นต่ำต่อเดือน', labelText: 'ยอดชำระบัตรเครดิต/เดือน',),
                        InputBox(controller: _creditCar, errorText: 'กรุณาระบุยอดชำระสินเชื่อรถยนต์ต่อเดือน', labelText: 'ยอดชำระสินเชื่อรถยนต์/เดือน',),
                        InputBox(controller: _creditOther, errorText: 'กรุณาระบุยอดชำระสินเชื่ออื่นต่อเดือน', labelText: 'ยอดชำระสินเชื่ออื่น/เดือน',inputAction: TextInputAction.done,),
                        SizedBox(height: 30),
                        Container(
                          width: size.width * 0.4,
                          height: 50,
                          child: RaisedButton(
                            color: kBackgroundColor,
                            elevation: 4,
                            onPressed: (){
                              reset();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.refresh_sharp,color: kPrimaryColor,),
                                SizedBox(width: 10),
                                Text('รีเซ็ต',style: TextStyle(fontSize: 28, color: kPrimaryColor),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: size.width * 0.4,
                          height: 50,
                          child: RaisedButton(
                            color: kPrimaryColor,
                            elevation: 4,
                            onPressed: (){
                              if(_formKey.currentState.validate()){
                                calDTI();
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.scatter_plot,color: kPrimaryFontColor,),
                                SizedBox(width: 10),
                                Text('คำนวณ',style: TextStyle(fontSize: 28, color: kPrimaryFontColor),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  const InputBox({
    Key key,
    @required TextEditingController controller, this.errorText = '', this.labelText = '', this.inputAction = TextInputAction.next,
  }) : _controller = controller, super(key: key);

  final TextEditingController _controller;

  final errorText;

  final labelText;

  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: TextFormField(
        textInputAction: inputAction,
        keyboardType: TextInputType.number,
        controller: _controller,
        validator: (val) => val.isEmpty ? errorText : null,
        decoration: InputDecoration(
          isDense: true,
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 24),
          fillColor: kBackgroundColor,
          prefixIcon: Container(child: Icon(Icons.attach_money)),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          )
        ),
      ),
    );
  }
}
