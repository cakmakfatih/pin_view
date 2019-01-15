import 'package:flutter/material.dart';
import 'package:pin_view/pin_view.dart';

class Example extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      resizeToAvoidBottomPadding: false,
      body: Container (
        padding: EdgeInsets.all(10.0),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible (
              child: Column (
                children: <Widget>[
                  Container(margin: EdgeInsets.symmetric(vertical: 15.0)),
                  Icon(Icons.phonelink_ring, size: 100.0, color: Theme.of(context).primaryColor),
                  Container(margin: EdgeInsets.symmetric(vertical: 15.0)),
                  Container (
                    width: MediaQuery.of(context).size.width * 4/5,
                    child: Text (
                      "Waiting to automatically detect an SMS sent to your mobile number.",
                      textAlign: TextAlign.center,
                      style: TextStyle (
                        fontSize: 17.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.teal
                      ),
                    ),
                  ),
                  Container (
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: PinView (
                      count: 6, // count of the fields, excluding dashes
                      autoFocusFirstField: false,
                      dashPositions: [3], // describes the dash positions (not indexes)
                      sms: SmsListener (
                        // this class is used to receive, format and process an sms
                        from: "6505551212",
                        formatBody: (String body){
                          // incoming message type
                          // from: "6505551212"
                          // body: "Your verification code is: 123-456"
                          // with this function, we format body to only contain
                          // the pin itself
                          String codeRaw = body.split(": ")[1];
                          List<String> code = codeRaw.split("-");
                          return code.join();
                        }
                      ),
                      submit: (String pin){
                        showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog (
                              title: Text("Pin received successfully."),
                              content: Text("Entered pin is: $pin")
                            );
                          }
                        );
                      } // gets triggered when all the fields are filled
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      )
    );
  }

}