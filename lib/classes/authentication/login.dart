import '../../locale.dart';
import 'redirect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'addname.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.loginCallback});
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    Translation translation = Translation.of(context);
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          AuthResult result = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => TabNavigator()));
        } else {
          AuthResult result = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password);
          FirebaseUser user = result.user;
          Firestore.instance.collection('users').document(user.email).setData({
            'uid': user.uid,
            'email': user.email,
            'banned' : false,
          });
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => CreateNamePage()));
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
          FirebaseAuth.instance.setLanguageCode('ro');
          showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text(translation.generalError,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            letterSpacing: -0.5,
                            fontSize: 17.0)),
                    content: Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          _errorMessage ?? '',
                          style: TextStyle(fontFamily: 'Inter', fontSize: 15.0),
                        )),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text(translation.generalRetry,
                            style:
                                TextStyle(fontFamily: 'Inter', fontSize: 17.0)),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ));
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    FirebaseAuth.instance.setLanguageCode('ro');
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return AnimatedContainer(
          duration: Duration(seconds: 2),
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.fastOutSlowIn,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(CupertinoColors.activeGreen),
          )));
    }
    return Container(
      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
      height: 10.0,
      width: 10.0,
    );
  }

  Widget _showForm() {
    return new Container(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
            ],
          ),
        ));
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 80.0,
          child: ClipOval(
            child: Image.network('https://lh3.googleusercontent.com/puERkjc7E2so0PgaamK0NQ3FQvTjiTZlAjekMc7bVr1xvoCugIzEAMo-zUi3bfGcPQ=s180-rw'),
          ),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new CupertinoTextField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(
            color: CupertinoTheme.of(context).primaryContrastingColor,
            fontFamily: 'Roboto',
            fontSize: 20.0),
        prefix: Padding(padding: EdgeInsets.only(left: 10.0)),
        placeholder: Translation.of(context).generalEmail,
        cursorColor: CupertinoColors.activeGreen,
        onChanged: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new CupertinoTextField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: TextStyle(
            color: CupertinoTheme.of(context).primaryContrastingColor,
            fontFamily: 'Roboto',
            fontSize: 20.0),
        prefix: Padding(padding: EdgeInsets.only(left: 10.0)),
        placeholder: Translation.of(context).generalPassword,
        cursorColor: CupertinoColors.activeGreen,
        onChanged: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new CupertinoButton(
        child: new Text(
            _isLoginForm
                ? Translation.of(context).hermesNoAccount
                : Translation.of(context).hermesYesAccount,
            style: new TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.green)),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Container(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 50.0,
          child: new CupertinoButton(
            color: Colors.green,
            child: new Text(_isLoginForm ? Translation.of(context).hermesLogin : Translation.of(context).hermesCreateAccount,
                style: new TextStyle(
                    fontSize: 19.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
}
