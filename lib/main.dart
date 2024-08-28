import 'package:flutter/material.dart';
import 'calender.dart';
import 'diary.dart';
import 'exercisewidget.dart';
import 'landing_page.dart';
import 'sleeptarcker.dart';
import 'qoute_widget.dart'; 
import 'weather_widget.dart';
import 'todolist.dart';
import 'todolist2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailySync',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(), 
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _notificationsEnabled = true; // Variable to store the state of notifications

  static final List<Widget> _widgetOptions = <Widget>[
    CustomHomePageLayout(),
    DiaryWidget(),
    ExerciseLogWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
    // You can add code here to enable/disable actual notifications in your app
  }

  void _showPopupDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DailySync',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(13, 21, 60, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 22, 31, 58),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 13, 21, 58),
              ),
              child: Text(
                'Dashboard',
                style: TextStyle(
                  color: Color.fromARGB(255,255, 255, 255),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Personal Tasks', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToDoListPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.white),
              title: const Text('Academic Tasks', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToDoListPage2()),
                );
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Settings', style: TextStyle(color: Colors.white)),
              children: <Widget>[
                ListTile(
                  title: Text('Notifications', style: TextStyle(color: Colors.white)),
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: _toggleNotifications, // Handle toggle
                  ),
                ),
                ListTile(
                  title: const Text('Log Out', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.help, color: Colors.white),
              title: const Text('Help & Feedback', style: TextStyle(color: Colors.white)),
              children: <Widget>[
                ListTile(
                  title: const Text('Contact Information', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('For support, contact us at support@DailySync.com\n+91 836-2232XXX', style: TextStyle(color: Colors.white70)),
                ),
                ListTile(
                  title: const Text('Feedback', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Feedback'),
                          content:const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter your feedback here...',
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Submit'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Feedback submitted!')),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text('About', style: TextStyle(color: Colors.white)),
              children: <Widget>[
                ListTile(
                  title: const Text('Terms & Conditions', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    _showPopupDialog(
                      context,
                      'Terms & Conditions',
                      'Here are the general terms and conditions for using the DailySync app. By using this app, you agree to our terms of service, including data privacy, user responsibilities, and acceptable use policies.',
                    );
                  },
                ),
                ListTile(
                  title: const Text('Privacy Policies', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    _showPopupDialog(
                      context,
                      'Privacy Policies',
                      'DailySync values your privacy. This policy outlines how we collect, use, and protect your personal data. Your data is used solely for improving your app experience and will not be shared with third parties.',
                    );
                  },
                ),
                ListTile(
                  title: const Text('Version', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('1.0.0', style: TextStyle(color: Colors.white70)),
                ),
                ListTile(
                  title: const Text('Updates', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    _showPopupDialog(
                      context,
                      'Updates',
                      'DailySync is regularly updated to improve performance and add new features. Please check for updates to ensure you are using the latest version of the app.',
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Diary',  
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cyclone_outlined),
            label: 'Exercise Log',  
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color.fromRGBO(13, 21, 60, 1),
        onTap: _onItemTapped,
      ),
      backgroundColor: Color.fromRGBO(13, 21, 60, 1),
    );
  }
}

class ToDoListPage3 {
}

class CustomHomePageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  color: const Color.fromARGB(255, 244, 191, 79),
                  child: Center(
                    child: QuoteWidget(),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 200,
                  color: Color.fromRGBO(239, 74, 104, 1),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.sunny_snowing,
                          size: 100.0,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: WeatherWidget(city: "Bangalore"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 270,
                  color: Colors.purpleAccent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Steps",style: TextStyle(
                          color:Colors.white,
                          fontSize:36,
                        ),),
                        Icon(
                          Icons.directions_walk,
                          size: 60, 
                          color: Colors.white,
                        ),
                        SizedBox(height: 8), 
                        Text(
                          '2000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 270,
                  color: Color.fromARGB(255, 53, 92, 102),
                  child: Center(
                    child: SleepPatternWidget()
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 380,
                  child: Center(
                    child: CalendarWidget()
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
