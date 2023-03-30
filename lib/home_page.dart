import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voiceassistant/BoxItem.dart';
import 'package:voiceassistant/openai_services.dart';
import 'package:voiceassistant/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final OpenAIServices openAIService = OpenAIServices();
  String speech = "";
  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    print(result);
    setState(() {
      speech = result.recognizedWords;
    });
    print(speech);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Assistant'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Column(children: [
        Stack(
          children: [
            Center(
              child: Container(
                height: 120,
                width: 120,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    shape: BoxShape.circle),
              ),
            ),
            Container(
              height: 123,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png'))),
            )
          ],
        ),
        //Chat Bubble
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
          ).copyWith(top: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Pallete.borderColor),
              borderRadius:
                  BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Good Morning, What task can I do for you?",
              style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontFamily: 'Cera-Pro'),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10, left: 22),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Here are a few features",
            style: TextStyle(
                fontFamily: 'Sera-Pro',
                color: Pallete.mainFontColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: const [
            BoxItem(
                color: Pallete.firstSuggestionBoxColor,
                title: "ChatGPT",
                description:
                    "A smarter way to stay organized and informed with ChatGPT"),
            BoxItem(
                color: Pallete.secondSuggestionBoxColor,
                title: "Dall-E",
                description:
                    "Get inspired and stay creative with your personal assistant powered by Dall-E"),
            BoxItem(
                color: Pallete.thirdSuggestionBoxColor,
                title: "Smart Voice Assistant",
                description:
                    "Get the best of both worlds with a voice assisntant powered by Dall-E and ChatGPT")
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            print('speech dfsd $speech');
            final finalSpeech = await openAIService.isArtPromptAPI(speech);
            print(finalSpeech);
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        backgroundColor: Pallete.firstSuggestionBoxColor,
        tooltip: "Listen",
        child: const Icon(Icons.mic),
      ),
    );
  }
}
