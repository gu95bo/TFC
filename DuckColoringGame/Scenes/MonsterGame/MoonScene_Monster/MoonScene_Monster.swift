//
//  MoonScene_Monster.swift
//  DuckColoringGame
//
//  Created by Gustavo C Figueroa on 3/11/18.
//  Copyright © 2018 Eleanor Meriwether. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoonScene_Monster: SKScene {
    //Timer Variables
    var gameTimer: Timer!
    var gameCounter = 0
    
    //Variables for food and monster nodes
    private var foodNode1:SKNode?
    private var foodNode2:SKNode?
    private var foodNode3:SKNode?
    private var foodNode4:SKNode?
    private var monsterNode:SKNode?
    
    //Variables for position reset
    private var node1Position:CGPoint?
    private var node2Position:CGPoint?
    private var node3Position:CGPoint?
    private var node4Position:CGPoint?
    
    //Variables for node dragging and tracking
    private var selectedNode:SKNode?
    private var nodeIsSelected:Bool?
    
    //Score tracking Variables
    var moon_incorrectTouches = 0
    var moon_correctTouches = 0
    var firstFeedTracked = false
    var totalTouches = 0
    
    //Audio Tracking Variables
    var instructionsComplete:Bool = false
    var feedbackComplete:Bool = true
    
    //Scene Completion Variable
    var sceneOver = false
    
    override func didMove(to view: SKView) {
        foodNode1 = self.childNode(withName: "cloud")
        foodNode2 = self.childNode(withName: "butter")
        foodNode3 = self.childNode(withName: "moon")
        foodNode4 = self.childNode(withName: "glasses")
        node1Position = foodNode1?.position
        node2Position = foodNode2?.position
        node3Position = foodNode3?.position
        node4Position = foodNode4?.position
        monsterNode = self.childNode(withName: "Monster")
        playInstructionsWithName(audioName: "instructions_moon_monster")
        
    }
    
    ////////////////////////////
    /////Helper Functions///////
    ////////////////////////////
    @objc func runTimedCode(){
        if gameCounter == 60{
            nextScene(sceneName: "DishScene")
        } else if gameCounter%20 == 0 && gameCounter != 0{
            playFeedbackWithName(audioName: "reminder_moon_monster")
            gameCounter = gameCounter + 1
        }else{
            gameCounter = gameCounter + 1
        }
    }
    
    func playInstructionsWithName(audioName:String){
        instructionsComplete = false
        let instructions = SKAction.playSoundFileNamed(audioName, waitForCompletion: true)
        self.run(instructions, completion: {
            self.instructionsComplete = true
            self.gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: true)
            
        })
    }
    
    func playFeedbackWithName(audioName:String){
        feedbackComplete = false
        let instructions = SKAction.playSoundFileNamed(audioName, waitForCompletion: true)
        monsterNode!.run(instructions, completion: { self.feedbackComplete = true })
    }
    
    func animateMonster(withAudio:String) {
        let openMouth = SKTexture(imageNamed: "monsterScene_stillMonster")
        let closedMouth = SKTexture(imageNamed: "monsterScene_chewingMonster")
        let animation = SKAction.animate(with: [openMouth, closedMouth], timePerFrame: 0.2)
        let openMouthAction = SKAction.repeat(animation, count: 10)
        monsterNode!.run(openMouthAction)
        playFeedbackWithName(audioName: withAudio)
    }
    
    func animateMonster_incorrect(){
        let openMouth = SKTexture(imageNamed: "monsterScene_stillMonster")
        let sadMouth = SKTexture(imageNamed: "monsterScene_sadMonster")
        let sadAnimate = SKAction.animate(with: [sadMouth, openMouth], timePerFrame: 2)
        //let reset = SKAction.animate(with: [openMouth], timePerFrame: 0.5)
        monsterNode!.run(sadAnimate)
    }
    
    func nextScene(sceneName:String){
        let fadeOut = SKAction.fadeOut(withDuration:1)
        let wait2 = SKAction.wait(forDuration: 1)
        let sequenceFade = SKAction.sequence([wait2, fadeOut])
        run(sequenceFade) {
            let sceneToLoad = SKScene(fileNamed: sceneName)
            sceneToLoad?.scaleMode = SKSceneScaleMode.aspectFill
            self.scene!.view?.presentScene(sceneToLoad!)}
    }
    ////////////////////////////
    ////////////////////////////
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (instructionsComplete == true) && (feedbackComplete == true) && (sceneOver == false){
            let touch = touches.first!
            let touchLocation = touch.location(in: self)
            if (self.atPoint(touchLocation).name == "cloud"){
                selectedNode = foodNode1
                nodeIsSelected = true
                moon_incorrectTouches += 1
            } else if (self.atPoint(touchLocation).name == "butter"){
                selectedNode = foodNode2
                nodeIsSelected = true
                moon_incorrectTouches += 1
            }else if (self.atPoint(touchLocation).name == "moon"){
                selectedNode = foodNode3
                nodeIsSelected = true
                if (totalTouches == 0){
                    monster_totalCorrectFT += 1
                    monster_fourItemCorrectFT += 1
                    monster_correctFirstTries["moonScene"] = true
                    moon_correctTouches += 1
                }
            }else if (self.atPoint(touchLocation).name == "glasses"){
                selectedNode = foodNode4
                nodeIsSelected = true
                moon_incorrectTouches += 1
            }else{
                playFeedbackWithName(audioName: "wrong")
                selectedNode = nil
                nodeIsSelected = false
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if  (instructionsComplete == true) && (sceneOver == false) && (nodeIsSelected == true) && (feedbackComplete == true) {
            for touch in touches{
                let location = touch.location(in: self)
                selectedNode?.position = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (instructionsComplete == true) && (sceneOver == false) && (nodeIsSelected == true) && (feedbackComplete == true){
            let touch = touches.first!
            let touchLocation = touch.location(in: self)
            
            for items in self.nodes(at: touchLocation){
                if items.name == "Monster"{
                    if (selectedNode?.name == "moon"){
                        if (firstFeedTracked == false){
                            monster_correctFirstFeed["moonScene"] = true
                            monster_totalCorrectFF += 1
                            monster_fourItemCorrectFF += 1
                            firstFeedTracked = true
                        }
                        monster_numCorrectPerScene["moonScene"]! += 1
                        selectedNode?.removeFromParent()
                        sceneOver = true
                        animateMonster(withAudio: "Sound_Munching")
                        nextScene(sceneName: "DishScene")
                    }else{
                        playFeedbackWithName(audioName: "wrong")
                        animateMonster_incorrect()
                        if selectedNode == foodNode1{
                            foodNode1?.position = node1Position!
                        }else if selectedNode == foodNode2{
                            foodNode2?.position = node2Position!
                        }else{
                            foodNode4?.position = node4Position!
                        }
                        moon_incorrectTouches += 1
                        monster_numIncorrectPerScene["appleScene"]! += 1
                        if moon_incorrectTouches > 15{
                            sceneOver = true
                            nextScene(sceneName: "DishScene")
                        }
                    }
                }
            }
            selectedNode = nil
            nodeIsSelected = false
        }
        totalTouches = moon_correctTouches + moon_incorrectTouches
    }
}


