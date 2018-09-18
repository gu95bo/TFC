//
//  ScoreScene_Monster.swift
//  DuckColoringGame
//
//  Created by Gustavo C Figueroa on 8/31/18.
//  Copyright © 2018 Eleanor Meriwether. All rights reserved.
//

import SpriteKit

class ScoreScene_Monster: SKScene {
    // LOCAL VARIABLES FOR LABELS
    let totalCorrectFTLabel = SKLabelNode(fontNamed:"Montserrat-SemiBold")
    let totalCorrectFFLabel = SKLabelNode(fontNamed: "Montserrat-SemiBold")
    
    let setSize2Label = SKLabelNode(fontNamed: "Montserrat-Regular")
    let setSize3Label = SKLabelNode(fontNamed: "Montserrat-Regular")
    let setSize4Label = SKLabelNode(fontNamed: "Montserrat-Regular")
    let simpleBGLabel = SKLabelNode(fontNamed: "Montserrat-Regular")
    let lineBGLabel = SKLabelNode(fontNamed: "Montserrat-Regular")
    let sceneBGLabel = SKLabelNode(fontNamed: "Montserrat-Regular")
    
    let twoItemAccuracyLabel = SKLabelNode(fontNamed: "Montserrat-Regular")
    let threeItemAccuracyLabel = SKLabelNode(fontNamed: "Montserrat-Regular")
    let fourItemAccuracyLabel = SKLabelNode(fontNamed: "Montserrat-Regular")
    let simpleAccuracyLabel = SKLabelNode(fontNamed: "Montserrat-Regular")
    let lineAccuracyLabel = SKLabelNode(fontNamed: "Montserrat-Regular")
    let sceneAccuracyLabel = SKLabelNode(fontNamed: "Montserrat-Regular")
    
    let nameLabel = SKLabelNode(fontNamed:"Montserrat-Regular")
    let ageLabel = SKLabelNode(fontNamed:"Montserrat-Regular")
    
    override func didMove(to view: SKView) {
        ////////////////////////////////////////////////////////////////////////////////////////////
        // CALCULATE ACCURACY FOR EACH SCENE
        for (item, _) in monster_accuracyPerScene { calculateAccuracy_monster(currentScene: self, scene: item) }
        ////////////////////////////////////////////////////////////////////////////////////////////
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////
        // PLACE NAME & AGE LABELS
        printLabel (scene: self, label: nameLabel, words: "\(userName)", xCoord: 164, yCoord: -469.413, fontSize: 28)
        printLabel (scene: self, label: ageLabel, words: "\(userAge)", xCoord: 540, yCoord: -469.413, fontSize: 28)
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        // PLACE TOTAL-CORRECT-FT LABEL
        let totalCorrectFtText = "\(monster_totalCorrectFT) / 18"
        printLabel(scene: self, label: totalCorrectFTLabel, words: totalCorrectFtText, xCoord: 150, yCoord: 211, fontSize: 150)
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        // PLACE 2-ITEM-CORRECT-FT LABEL
        let setSize2String = "\(monster_twoItemCorrectFT) / 6"
        printLabel(scene: self, label: setSize2Label, words: setSize2String, xCoord: 136, yCoord: -14.482, fontSize: 28)
        
        // PLACE 3-ITEM-CORRECT-FT LABEL
        let setSize3String = "\(threeItemCorrectFT) / 6"
        printLabel(scene: self, label: setSize3Label, words: setSize3String, xCoord: 136, yCoord: -48.659, fontSize: 28)
        
        // PLACE 4-ITEM-CORRECT-FT LABEL
        let setSize4String = "\(fourItemCorrectFT) / 6"
        printLabel(scene: self, label: setSize4Label, words: setSize4String, xCoord: 136, yCoord: -83.483, fontSize: 28)
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        // PLACE SIMPLE-BG-CORRECT-FT LABEL
        let simpleBGString = "\(simpleCorrectFT)/6"
        printLabel(scene: self, label: simpleBGLabel, words: simpleBGString, xCoord: 217, yCoord: -166.828, fontSize: 28)
        
        // PLACE LINE-BG-CORRECT-FT LABEL
        let lineBGString = "\(lineCorrectFT)/6"
        printLabel(scene: self, label: lineBGLabel, words: lineBGString, xCoord: 217, yCoord: -200.828, fontSize: 28)
        
        // PLACE SCENE-BG-CORRECT-FT LABEL
        let sceneBGString = "\(sceneCorrectFT)/6"
        printLabel(scene: self, label: sceneBGLabel, words: sceneBGString, xCoord: 217, yCoord: -235.829, fontSize: 28)
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        // PLACE TOTAL-CORRECT-FF LABEL
        let totalCorrectFfText = "\(monster_totalCorrectFF) / 18"
        printLabel(scene: self, label: totalCorrectFFLabel, words: totalCorrectFfText, xCoord: -475, yCoord: 211, fontSize: 150)
//        for (scene, accuracy) in monster_accuracyPerScene {
//            if (monster_accuracyPerScene[scene]! > 0) {
//                monster_totalAccuracy += accuracy
//                monster_numOfScenesCompleted += 1
//            }
//        }
//        _ = "Fix this part right here for FF"
//        monster_totalAccuracy = monster_totalAccuracy / monster_numOfScenesCompleted
//        var totalAccuracyString:String
//        if (monster_totalAccuracy > 0.0 ) {
//            totalAccuracyString = "\(Int(round(monster_totalAccuracy)))%"
//        } else {
//            totalAccuracyString = "0%"
//        }
//        printLabel(scene: self, label: totalCorrectFFLabel, words: totalAccuracyString, xCoord: -475, yCoord: 211, fontSize: 150)
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        // CALCULATE AND PLACE 2-ITEM ACCURACY LABEL
//        let twoItemArray: [String] = ["candyScene","orangeScene", "toothScene", "flowerScene", "cupScene", "penScene"]
//        for item in twoItemArray {
//            print(String(item) + "  ", monster_accuracyPerScene[item]!)
//            if monster_accuracyPerScene[item]! > 0.0 {
//                monster_twoItemAccuracy += monster_accuracyPerScene[item]!
//                monster_twoItemCompleted += 1
//            }
//        }
        monster_twoItemAccuracy = monster_twoItemAccuracy / monster_twoItemCompleted
        let twoItemAccuracyText:String = "\(monster_twoItemCorrectFF) / 6"
//        if monster_twoItemCompleted > 0 {
//            twoItemAccuracyText = "\(Int(round(monster_twoItemAccuracy)))%"
//        } else {
//            twoItemAccuracyText = "none completed"
//        }
        printLabel(scene: self, label: twoItemAccuracyLabel, words: twoItemAccuracyText, xCoord: -490, yCoord: -14.482, fontSize: 28)
        
        // CALCULATE AND PLACE 3-ITEM ACCURACY LABEL
        let threeItemArray: [String] = ["cat", "lion", "cow", "trash", "toast", "hat"]
        for item in threeItemArray {
            if accuracyPerScene[item]! > 0.0 {
                threeItemAccuracy += accuracyPerScene[item]!
                threeItemCompleted += 1
            }
        }
        threeItemAccuracy = threeItemAccuracy / threeItemCompleted
        var threeItemAccuracyText:String
        if threeItemCompleted > 0 {
            threeItemAccuracyText = "\(Int(round(threeItemAccuracy)))%"
        } else {
            threeItemAccuracyText = "none completed"
        }
        printLabel(scene: self, label: threeItemAccuracyLabel, words: threeItemAccuracyText, xCoord: -490, yCoord: -48.659, fontSize: 28)
        
        // CALCULATE AND PLACE 4-ITEM ACCURACY LABEL
        let fourItemArray: [String] = ["hand", "rain", "airplane", "shoes", "cookie", "mouse"]
        for item in fourItemArray {
            if accuracyPerScene[item]! > 0.0 {
                fourItemAccuracy += accuracyPerScene[item]!
                fourItemCompleted += 1
            }
        }
        fourItemAccuracy = fourItemAccuracy / fourItemCompleted
        var fourItemAccuracyText:String
        if fourItemCompleted > 0 {
            fourItemAccuracyText = "\(Int(round(fourItemAccuracy)))%"
        } else {
            fourItemAccuracyText = "none completed"
        }
        printLabel(scene: self, label: fourItemAccuracyLabel, words: fourItemAccuracyText, xCoord: -490, yCoord: -83.483, fontSize: 28)
        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        // CALCULATE AND PLACE SIMPLE-BG ACCURACY LABEL
        let simpleBgArray: [String] = ["rock", "lamp", "cat", "shoes", "lion", "hand"]
        for item in simpleBgArray {
            if accuracyPerScene[item]! > 0.0 {
                simpleAccuracy += accuracyPerScene[item]!
                simplebgCompleted += 1
            }
        }
        simpleAccuracy = simpleAccuracy / simplebgCompleted
        var simpleAccuracyText:String
        if simplebgCompleted > 0 {
            simpleAccuracyText = "\(Int(round(simpleAccuracy)))%"
        } else {
            simpleAccuracyText = "none completed"
        }
        printLabel(scene: self, label: simpleAccuracyLabel, words: simpleAccuracyText, xCoord: -404, yCoord: -166.828, fontSize: 28)
        
        // CALCULATE AND PLACE LINE-BG ACCURACY LABEL
        let lineBgArray: [String] = ["duck", "moon", "cow", "trash", "airplane", "shoes"]
        for item in lineBgArray {
            if accuracyPerScene[item]! > 0.0 {
                lineAccuracy += accuracyPerScene[item]!
                linebgCompleted += 1
            }
        }
        lineAccuracy = lineAccuracy / linebgCompleted
        var lineAccuracyText:String
        if linebgCompleted > 0 {
            lineAccuracyText = "\(Int(round(lineAccuracy)))%"
        } else {
            lineAccuracyText = "none completed"
        }
        printLabel(scene: self, label: lineAccuracyLabel, words: lineAccuracyText, xCoord: -404, yCoord: -200.828, fontSize: 28)
        
        // CALCULATE AND PLACE SCENE-BG ACCURACY LABEL
        let sceneBgArray: [String] = ["cake", "stroller", "toast", "hat", "cookie", "mouse"]
        for item in sceneBgArray {
            if accuracyPerScene[item]! > 0.0 {
                sceneAccuracy += accuracyPerScene[item]!
                scenebgCompleted += 1
            }
        }
        sceneAccuracy = sceneAccuracy / scenebgCompleted
        var sceneAccuracyText:String
        if scenebgCompleted > 0 {
            sceneAccuracyText = "\(Int(round(sceneAccuracy)))%"
        } else {
            sceneAccuracyText = "none completed"
        }
        printLabel(scene: self, label: sceneAccuracyLabel, words: sceneAccuracyText, xCoord: -404, yCoord: -235.829, fontSize: 28)
        ////////////////////////////////////////////////////////////////////////////////////////////
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // variable for buttons
        let nextButton = self.childNode(withName: "view scene breakdown")
        let playAgainButton = self.childNode(withName: "playagain")
        
        // variable to keep track of touch
        let touch = touches.first!
        
        // if next button is touched
        if nextButton!.contains(touch.location(in:self)){
            transitionScene (currentScene: self, sceneString: "ScoreScene2", waitTime: 0, fadeTime: 0)
        }
        
        // if retry button is touched
        if playAgainButton!.contains(touch.location(in: self)) {
            resetAllGameStats_monster()
            transitionScene (currentScene: self, sceneString: "StartScene", waitTime: 1, fadeTime: 0)
        }
    }
}
