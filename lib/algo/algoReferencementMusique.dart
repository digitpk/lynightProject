import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lynight/services/crud.dart';
import 'package:lynight/nightCubPage/nightClubProfile.dart';

/*class AlgoMusicReference extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AlgoMusicReference();
  }
}*/

class AlgoMusicReference {
  CrudMethods crudObj = new CrudMethods();
  Stream club;
  final user;
  Map<dynamic, dynamic> mapOfUserMusics;
  bool electro = false;
  bool rap = false;
  bool rnb = false;
  bool populaire = false;
  bool rock = false;
  bool trans = false;

  List<DocumentSnapshot> dataClubFromBDD;


  AlgoMusicReference({
    this.user,
    this.mapOfUserMusics
  });

  Map<dynamic, dynamic> test = {} ;

  getUserMusic(){
     crudObj.getDataFromUserFromDocument().then((value){ // correspond à await Firestore.instance.collection('user').document(user.uid).get();
      Map<String,dynamic> dataMap = value.data; // retourne la Map des données de l'utilisateur correspondant à uid passé dans la methode venant du cruObj

      print('---------mmmmmmmm-----------------------------------------');
      print(dataMap['music']);
      print('-----------mmmmmm---------------------------------------');
      Map<dynamic, dynamic> userMusic = dataMap['music'];
      test.addAll(userMusic);
      return userMusic;

    });
  }

  getClubMusic(){
    crudObj.getDataFromClubFromDocument().then((value){ // correspond à await Firestore.instance.collection('user').document(user.uid).get();
      dataClubFromBDD = value.documents;


    });

    var listClubFromDatabase = [];

    for(int i=0; i<= 2; i++) {
      if (dataClubFromBDD != null) {
        var clubI = dataClubFromBDD[i].data;
        //print('--------------------------------------------------');
        //print(clubI);
        //print(clubMap);
        /*print('--------------------------------------------------');
        //print(clubI);
        print('--------------------------------------------------');
        print('Club i : ');*/
        //print(clubI);
        listClubFromDatabase.add(clubI);
        //print(clubI[i]);
        //print(listClubFromDatabase);
      }
    }
    print(listClubFromDatabase.length);
    return listClubFromDatabase;
  }

  getMusicsOfClubMap(){
    var listMapMusicClub = [];
    Map<dynamic, dynamic> clubMap;
    if(getClubMusic() != null) {
      for (int i = 0; i < getClubMusic().length; i++) {
        print('Valur de ghetClubMusic');
        print(getClubMusic());
        List clubMusicList = getClubMusic();
        var club1 = clubMusicList[i];
        print(clubMusicList[i]);
        //print('valeur club1 vide en theorie');
        //print(club1);
        print('******************');
        print('nom du club traité');
        print(club1['name']);
        //print(club1);
        clubMap = club1['musics'];
        print('Club Map : ');
        print(clubMap);
        //print('++++++++++++++');
        listMapMusicClub.add(clubMap);
      }
      print('valeur de retrou de getLMusqicsofClubMap');
      print(listMapMusicClub);
      return listMapMusicClub;

    }
  }

  getClubName(){
    List<String> listNameClub = [];
    if(getClubMusic() != null){
      var clubNameForReal;
      for(int i=0; i<getClubMusic().length; i++){
        var clubName;
        clubName = getClubMusic()[i];
        clubNameForReal = clubName['name'];
        //print('nom du club');
        //print(clubNameForReal);
        listNameClub.add(clubNameForReal);
        print('Liste des noms 1 par 1 enb théorie');
        print(listNameClub[i]);
      }
      print('Affichage de la liste dans getClubName');
      print(listNameClub);
      return listNameClub;

    }
  }






  List<String> compareMusic() {
    final List<String> bestClub = []; //club retenu pour la liste à retourner

    print('==================');
    print('Valru de getMusic : ');
    print(getMusicsOfClubMap());
    List<dynamic> getMusic = [{populaire: true, rap: false, rock: true, electro: false, rnb: false, trans: true}, {populaire: false, rap: false, rock: false, electro: true, rnb : true, trans: true}, {populaire: false, rap: true, rock: true, electro: true, rnb: true, trans: false}];
    getMusic = getMusicsOfClubMap();
    print(getMusic);
    print('==================');


    for (int i = 0; i < 3 ; i++) {
      print('getMusic for');
      print(getMusic);

      if (getMusic != null) {
        print('GetMusic if');
        print(getMusic);
        Map<dynamic, dynamic> mapOfMusicFromList = getMusic[i];
        List<String> nameOfClubList = getClubName();
        print(nameOfClubList[0]);
        print('Liste des noms de club : ');
        print(nameOfClubList);
        print('1 par 1 le retour de getMusicOfClubMap en theorie');
        print(mapOfMusicFromList);
        print('--------------------------------------------------');
        print('Valeur de user : ');
        print(mapOfUserMusics);
        print('--------------------------------------------------');
        print('getMusicofClubMap');
        print(getMusic);

        if ( (mapOfUserMusics['populaire'] == mapOfMusicFromList['populaire']) && (mapOfUserMusics['populaire'] == true) ) {
          print('debut de la boucle de verif de style de music');
          print('*********************');
          print('Les deux il kiffe populaire');
          bestClub.add(nameOfClubList[i]);
          print('Valur après ajout de populaire');
          print(bestClub);
          //return bestClub;
        } else {
          if((mapOfUserMusics['electro'] == mapOfMusicFromList['electro']) && (mapOfUserMusics['electro'] == true)){
            print('*****************');
            print('ils aiment le electro tout les 2 ');
            bestClub.add(nameOfClubList[i]);
            print('Valur après ajout de electro');
            print(bestClub);
          }else{
            print('Valeur de bestclub quoi quil arrive');
            print(bestClub);
            print('il aime ni electro ni populaire');
          }
        }
        print('--------------------------------------------------');

      }

    }
    return bestClub;

  }
}
