import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class ProfileCardPage extends StatelessWidget {
  final String name = "أ / رؤى ممدوح احمد ";
  final String imageUrl =
      "https://avatars.githubusercontent.com/u/9919?s=200&v=4";
  final String facebookUrl = "https://www.facebook.com";
  final String phoneNumber = "+201029938982";

  void _launchFacebook() async {
    final Uri url = Uri.parse(facebookUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'لا يمكن فتح الرابط: $facebookUrl';
    }
  }

  void _launchPhoneCall(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'لايمكن إجراء اتصال';
    }
  }

  Widget _buildProfileCard(BuildContext context, String name, String phone) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, color: Colors.teal),
              SizedBox(width: 6),
              Text(
                phone,
                style: TextStyle(fontSize: 16, color: Colors.teal[700]),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton.icon(
              onPressed: () => _launchPhoneCall(phone),
              icon: Icon(Icons.call),
              label: Text("اتصل الآن"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الدعم الفنى",
        ),
        backgroundColor: Color.fromRGBO(102, 137, 115, 1),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProfileCard(context, name, phoneNumber),
              SizedBox(height: 20),
              _buildProfileCard(context, "أ/ منار حاتم", "+201552169907"),
            ],
          ),
        ),
      ),
    );
  }
}
