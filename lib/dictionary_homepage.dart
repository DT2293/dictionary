import 'package:flutter/material.dart';
import 'dictionary_model.dart';
import 'login_page.dart';
import 'services.dart';

class DictionaryHomePage extends StatefulWidget {
  const DictionaryHomePage({Key? key});

  @override
  State<DictionaryHomePage> createState() => _DictionaryHomePageState();
}

class _DictionaryHomePageState extends State<DictionaryHomePage> {
  DictionaryModel? myDictionaryModel;
  bool isLoading = false;
  String noDataFound = "Now You Can Search";

  Future<void> searchContain(String word) async {
    setState(() {
      isLoading = true;
    });
    try {
      myDictionaryModel = await APIservices.fetchData(word);
      setState(() {});
    } catch (e) {
      myDictionaryModel = null;
      noDataFound = "Meaning can't be found";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Dictionary")),
      ),

      //------ Drawers --------------------------------
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DictionaryHomePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Navigate to Profile page (not created yet)
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to Settings page (not created yet)
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),


      // ------ end drawer ----------------------------------------------------------------

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Search bar widget
            TextField(
              decoration: InputDecoration(
                hintText: "Search the word here",
              ),
              onSubmitted: (value) {
                searchContain(value);
              },
            ),

          //--- text field ----------------------------------------------------------------

            const SizedBox(height: 10),
            // Show loading indicator when loading data
            if (isLoading)
              const LinearProgressIndicator()
            // Show data when available
            else if (myDictionaryModel != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      myDictionaryModel!.word,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      myDictionaryModel!.phonetics.isNotEmpty
                          ? myDictionaryModel!.phonetics[0].text ?? ""
                          : "",
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: myDictionaryModel!.meanings.length,
                        itemBuilder: (context, index) {
                          return showMeaning(myDictionaryModel!.meanings[index]);
                        },
                      ),
                    ),
                  ],
                ),
              )
            // Show message when no data found
            else
              Center(
                child: Text(
                  noDataFound,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget showMeaning(Meaning meaning) {
    String wordDefinition = "";
    for (var element in meaning.definitions) {
      int index = meaning.definitions.indexOf(element);
      wordDefinition += "\n${index + 1}.${element.definition}\n";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meaning.partOfSpeech,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Definitions : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                wordDefinition,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1,
                ),
              ),
              wordRelation("Synonyms", meaning.synonyms),
              wordRelation("Antonyms", meaning.antonyms),
            ],
          ),
        ),
      ),
    );
  }

  Widget wordRelation(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      String words = setList!.join(", ");
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            words,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
