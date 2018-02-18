//
//  MoonScene.swift
//  TimeForChildrenGame
//
//  Created by Eleanor Meriwether on 12/7/17.
//  Copyright © 2017 Eleanor Meriwether. All rights reserved.
//

import SpriteKit

class MoonScene: SKScene {
    // local variables to keep track of whether instructions are playing
    var instructionsComplete = false
    var reminderComplete = true
    
    // local variable to keep track of whether correct sprite has been touched
    var sceneOver = false
    
    // local variables to keep track of touches for this scene
    var moon_incorrectTouches = 0
    var moon_correctTouches = 0
    var totalTouches = 0
    
    override func didMove(to view: SKView) {
        // remove scene's physics body, so alpha mask on target sprite is accessible
        self.physicsBody = nil
        
        // run the introductory instructions, then flag instructionsComplete as true
        let instructions = SKAction.playSoundFileNamed("instructions_duck", waitForCompletion: true)
        run(instructions, completion: { self.instructionsComplete = true })
        
        /////////////////////////////////
        ////// IDLE REMINDER TIMER //////
        /////////////////////////////////
        let oneSecTimer = SKAction.wait(forDuration: 1.0)
        var timerCount = 1
        var currentTouches = 0
        
        // set up sequence for if the scene has not been touched for 10 seconds: play the idle reminder
        let reminderIfIdle = SKAction.run {
            self.reminderComplete = false
            let moon_reminder = SKAction.playSoundFileNamed("reminder_duck", waitForCompletion: true)
            self.run(moon_reminder, completion: { self.reminderComplete = true} )
        }
        
        // for every one second, do this action:
        let timerAction = SKAction.run {
            // if no touch...
            if (self.totalTouches - currentTouches == 0) {
                // ...timer progresses one second...
                timerCount += 1
            }
                // ... else if a touch...
            else {
                // ... increase touch count...
                currentTouches += 1
                // ... and start timer over...
                timerCount = 1
            }
            // if timer seconds are divisable by 10 ...
            if (timerCount % 10 == 0) {
                // ... play the reminder.
                self.run(reminderIfIdle)
            }
        }
        // set up sequence: run 1s timer, then play action
        let timerActionSequence = SKAction.sequence([oneSecTimer, timerAction])
        // repeat the timer forever
        let repeatTimerActionSequence = SKAction.repeatForever(timerActionSequence)
        run(repeatTimerActionSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // local variable for moon sprite
        let moon = self.childNode(withName: "moon_bw")
        
        // if no instructions are playing
        if (instructionsComplete == true) && (reminderComplete == true) && (sceneOver == false){
            let touch = touches.first!
            
            //If moon sprite's alpha mask is touched...
            if (physicsWorld.body(at: touch.location(in: self)) == moon?.physicsBody) && (sceneOver == false) {
                sceneOver = true
                moon_correctTouches += 1
                
                // if there weren't any incorrect touches, add to game-wide numOfCorrectFirstTry
                if (moon_incorrectTouches == 0) {
                    totalCorrectFT += 1
                    lineCorrectFT += 1
                    twoItemCorrectFT += 1
                    
                    correctFirstTriesArray.append("moon")
                    correctTouchesArray.append("moon")
                    correctSetSize2.append("moon")
                    correctBGLine.append("moon")
                }
                
                // Change sprite to colored duck
                let coloredmoon:SKTexture = SKTexture(imageNamed: "moonScene_moon_colored")
                let changeToColored:SKAction = SKAction.animate(with: [coloredmoon], timePerFrame: 0.0001)
                moon!.run(changeToColored)
            
                //Variables for moon audio
                let nightTime = SKAction.playSoundFileNamed("moon", waitForCompletion: true)

                //Run all actions
                moon!.run(nightTime)
                
                //Variables to switch screens
                let fadeOut = SKAction.fadeOut(withDuration:3)
                let wait2 = SKAction.wait(forDuration: 3)
                let sequenceFade = SKAction.sequence([wait2, fadeOut])
                run(sequenceFade) {
                    let cowScene = SKScene(fileNamed: "CowScene")
                    cowScene?.scaleMode = SKSceneScaleMode.aspectFill
                    self.scene!.view?.presentScene(cowScene!)
                }
            }
            else {
                moon_incorrectTouches += 1
                incorrectTouches += 1
                numIncorrectPerScene["moon"] = numIncorrectPerScene["moon"]! + 1
                
                // Play wrong noise
                let wrong = SKAction.playSoundFileNamed("wrong", waitForCompletion: true)
                moon?.run(wrong)
            }

            // play reminder instructions if user has touched screen 3 times incorrectly
            if (moon_incorrectTouches % 3 == 0) && moon_correctTouches < 1 {
                reminderComplete = false
                let moon_reminder = SKAction.playSoundFileNamed("reminder_duck", waitForCompletion: true)
                run(moon_reminder, completion: { self.reminderComplete = true} )
            }
        }
        // update totalTouches variable for idle reminder
        totalTouches = moon_correctTouches + moon_incorrectTouches
    }
}

