
# PinView for Flutter
![](https://i.ibb.co/bFxHzXP/Screenshot-1546255213.png)
PinView is a fully configurable package to create pin fields that can also easily be integrated with an SMS verification system.

# Installation
To install PinView, simply add the following to your dependencies in `pubspec.yaml`.
```
    dependencies:
        flutter:
            sdk: flutter
        ...
        pin_view: <latest_version>
```
Then run `flutter packages get` in your project folder from your command line or terminal.

# Usage
### 1. Normal Usage
![](https://i.ibb.co/Jp6cQ33/Screenshot-1546359081.png)
Below example creates a simple PinView.
```
import 'package:flutter/material.dart';
import 'package:pin_view/pin_view.dart';

class Example extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold (
			body: SafeArea (
				child: Container (
					padding: EdgeInsets.all(15.0),
					child: Column (
						children: <Widget> [
							Icon(Icons.sms, size:  100.0, color:  Theme.of(context).primaryColor),
							Container(margin:  EdgeInsets.symmetric(vertical:  5.0)),
							Text (
								"Simple PinView Example",
								style: TextStyle (
									fontSize: 25.0,
									fontWeight: FontWeight.bold,
									color: Theme.of(context).primaryColor
								)
							),
							Container(margin:  EdgeInsets.symmetric(vertical:  5.0)),
							PinView (
								count: 6, // describes the field number
								dashPositions: [2,4], // positions of dashes, you can add multiple
								autoFocusFirstField: false, // defaults to true
								margin: EdgeInsets.all(2.5), // margin between the fields
								obscureText: true, // describes whether the text fields should be obscure or not, defaults to false
								style: TextStyle (
									// style for the fields
									fontSize: 19.0,
									fontWeight: FontWeight.w500
								),
								dashStyle: TextStyle (
									// dash style
									fontSize: 25.0,
									color: Colors.grey
								),
								submit: (String pin) {
									// when all the fields are filled
									// submit function runs with the pin
									print(pin);
								}		
							)
						]
					)
				)
			)
		);
	}
}
```

### 2. Detecting and Processing SMS

**PinView can't listen to messages for  iOS due to it's use of [sms](https://pub.dartlang.org/packages/sms) package which doesn't support iOS yet.**

![](https://i.ibb.co/0fss75F/Screenshot-1546362211.png)

To use PinView with SMS detection, you first need to allow necessary `READ_SMS` and `RECEIVE_SMS` permissions for Android. To accomplish this, add the following lines to your `AndroidManifest.xml` file.

```
<uses-permission android:name="android.permission.READ_SMS"/>
<uses-permission android:name="android.permission.RECEIVE_SMS"/>
``` 
After you provide the necessary permissions, you can try the example below.

1. Create an SmsListener (which comes with the pin_view).
```
SmsListener smsListener = SmsListener (
	from: '6505551212', // address that the message will come from
	formatBody: (String body) {
		// incoming message type
		// from: "6505551212"
		// body: "Your verification code is: 123-456"
		// with this function, we format body to only contain
		// the pin itself
		
		String codeRaw = body.split(": ")[1];
		List<String> code = codeRaw.split("-");
		return code.join(); // 123456
	}
);
```
2. Add your listener to the PinView's sms parameter.
```
Widget pinViewWithSms(BuildContext context) {
	return PinView (
		count: 6,
		dashPositions: [3],
		autoFocusFirstField: false,
		enabled: false, // this makes fields not focusable
		sms: smsListener // listener we created
		submit: (String pin){
			// when the message comes, this function
			// will trigger
			showDialog (
				context: context,
				builder: (BuildContext context) {
					return AlertDialog (
						title: Text("Pin received successfully."),
						content: Text("Entered pin is: $pin")
					);
				}
			);
		}
	);
}
```

3. Use it however you want.
```
import 'package:flutter/material.dart';
import 'package:pin_view/pin_view.dart';

class PinViewWithSmsExample extends StatelessWidget {

	final SmsListener smsListener = SmsListener (
		from: '6505551212', // address that the message will come from
		formatBody: (String body) {
			// incoming message type
			// from: "6505551212"
			// body: "Your verification code is: 123-456"
			// with this function, we format body to only contain
			// the pin itself
				
			String codeRaw = body.split(": ")[1];
			List<String> code = codeRaw.split("-");
			return code.join(); // 341430
		}
	);
	
	Widget pinViewWithSms(BuildContext context) {
		return PinView (
			count: 6,
			dashPositions: [3],
			autoFocusFirstField: false,
			enabled: false, // this makes fields not focusable
			sms: smsListener, // listener we created,
			submit: (String pin){
				// when the message comes, this function
				// will trigger
				showDialog (
					context: context,
					builder: (BuildContext context) {
						return AlertDialog (
							title: Text("Pin received successfully."),
							content: Text("Entered pin is: $pin")
						);
					}
				);
			}
		);
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold (
			body: SafeArea (
				child: Container (
					padding: EdgeInsets.all(15.0),
					child: pinViewWithSms(context)
				)
			)
		);
	}
	
}
```

## Example
You can find a fully working example in `examples/example.dart` in the github repo.

## Dependencies
This package uses the [sms](https://pub.dartlang.org/packages/sms) package to be able to listen to the received messages for pin entries. **Since the [sms](https://pub.dartlang.org/packages/sms) package only works on the Android now, PinView's sms option only works on Android too.**

## Contribute
This is my first Flutter package, it currently seems bugless but feel free to contribute by sending a pull request.

## Author
Feel free to contact me if you have any questions/suggestions.

**Fatih Çakmak**
cakmakfatih@outlook.com.tr