import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shortqly/CONSTANTS.dart';
import 'package:url_launcher/url_launcher.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _linkEditingController = TextEditingController();
  String _generatedFdl = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded)),
                    SizedBox(width: 10),
                    Text(
                      'Create',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    controller: _linkEditingController,
                    decoration: InputDecoration(hintText: 'Enter URL here'),
                    keyboardType: TextInputType.url,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _linkEditingController.text.isEmpty
                      ? null
                      : () async {
                          //TODO: Try to create fdl without url yg betul
                          //TODO: Fdl here

                          setState(() => _isLoading = true);
                          DynamicLinkParameters parameters =
                              DynamicLinkParameters(
                            uriPrefix: 'https://$kShortFdl',
                            link: Uri.parse(_linkEditingController.text),
                            googleAnalyticsParameters:
                                GoogleAnalyticsParameters(
                              campaign: 'shorten',
                              medium: 'app',
                              source: 'shortqly',
                            ),
                          );

                          final ShortDynamicLink _shortDynamicLink =
                              await parameters.buildShortLink();
                          final Uri _shortUrl = _shortDynamicLink.shortUrl;

                          setState(() {
                            _isLoading = false;
                            _generatedFdl = _shortUrl.toString();
                          });
                        },
                  child: Text('Shorten link'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Builder(
                    builder: (context) {
                      if (_isLoading) {
                        return JumpingDotsProgressIndicator(
                          fontSize: 30,
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _generatedFdl,
                              style: TextStyle(fontSize: 20),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                              text: _generatedFdl))
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Copied!'),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      });
                                    },
                                    icon: Icon(Icons.copy)),
                                IconButton(
                                    onPressed: () {
                                      Share.share(_generatedFdl,
                                          subject: 'I\'m sharing my link');
                                    },
                                    icon: Icon(Icons.share)),
                                IconButton(
                                    onPressed: () {
                                      launch(_generatedFdl);
                                    },
                                    icon: Icon(Icons.open_in_browser)),
                              ],
                            )
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
