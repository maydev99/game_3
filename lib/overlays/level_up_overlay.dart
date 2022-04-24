import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:layout/game/peep_run.dart';
import 'package:provider/provider.dart';

import '../monetize/ad_helper.dart';


const int maxFailedLoadAttempts = 3;
class LevelUpOverlay extends StatefulWidget {
  static const id = 'LevelUpOverlay';
  final PeepGame gameRef;


  const LevelUpOverlay({Key? key, required this.gameRef}) : super(key: key);

  @override
  _LevelUpOverlayState createState() => _LevelUpOverlayState();
}

class _LevelUpOverlayState extends State<LevelUpOverlay> {
  var box = GetStorage();
  int _interstitialLoadAttempts = 0;
  bool _ads = true;

  InterstitialAd? _interstitialAd;



  void _createInterstitialAd() {
      InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
          _interstitialLoadAttempts += 1;
          if(_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }

        },
      ),
    );
  }

  void _showInterstitialAd() {



    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {



        },
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          //_createInterstitialAd();
          widget.gameRef.resumeEngine();
          //widget.gameRef.spawnEnemies();
          //widget.gameRef.spawnArtifacts();
          widget.gameRef.startGamePlay();
         // widget.gameRef.loadNewLevelBGM();

        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();

          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  @override
  void initState() {
    super.initState();
    _ads = box.read('ads') ?? true;
    if(_ads) {
      _createInterstitialAd();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    int level = box.read('level') ?? 1;
    var gameRef = widget.gameRef;
    return ChangeNotifierProvider.value(
      value: gameRef.gameDataProvider,
      child: Center(
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withOpacity(0.5),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Level $level',
                    style: const TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                        color: Colors.yellow),
                  ),
                  const Text(
                    '-Level Bonus +5 Lives\n-25 Bonus Points',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.yellow),
                  ),

                  MaterialButton(
                    onPressed: () {
                      bool _ads = box.read('ads') ?? true;
                      gameRef.overlays.remove(LevelUpOverlay.id);
                      int curLives = gameRef.gameDataProvider.currentLives;
                      gameRef.gameDataProvider.setLives(curLives + 5);
                      gameRef.gameDataProvider.addBonusPoints(25);
                      gameRef.startGamePlay();

                      if(_ads) {
                        _showInterstitialAd();
                      } else {

                        widget.gameRef.resumeEngine();
                        widget.gameRef.spawnEnemies();
                        widget.gameRef.spawnArtifacts();
                        widget.gameRef.loadNewLevelBGM();
                      }




                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Continue'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
