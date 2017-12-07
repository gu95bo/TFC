//
//  CookieScene.swift
//  DuckColoringGame
//
//  Created by Eleanor Meriwether on 11/4/17.
//  Copyright © 2017 Eleanor Meriwether. All rights reserved.
//

import SpriteKit
import GameplayKit

class CookieScene: SKScene {
    // local variable for cookie sprite
    let cookie = SKSpriteNode(imageNamed: "Chocolate-Chip_BW")
    
    // local variables to keep track of whether instructions are playing
    var instructionsComplete:Bool = false
    var reminderComplete:Bool = true
    
    // local variables to keep track of touches for this scene
    var cookie_incorrectTouches = 0
    var cookie_correctTouches = 0
    
    
    override func didMove(to view: SKView) {
        // place the cookie sprite on the page
        cookie.position = CGPoint(x: -320, y: 160)
        cookie.setScale(2)
        cookie.zPosition = 2
        self.addChild(cookie)
        
        // run the introductory instructions
        let instructions = SKAction.playSoundFileNamed("CookieInstructions", waitForCompletion: true)
        run(instructions, completion: { self.instructionsComplete = true })
        
        // if the scene has not been touched for 10 seconds, play the reminder instructions; repeat forever
        let timer = SKAction.wait(forDuration: 10.0)
        let reminderIfIdle = SKAction.run {
            if self.cookie_correctTouches == 0 && self.cookie_incorrectTouches == 0 {
                self.reminderComplete = false
                let cookie_reminder = SKAction.playSoundFileNamed("listenCarefully_Cookie", waitForCompletion: true)
                self.run(cookie_reminder, completion: { self.reminderComplete = true} )
            }
        }
        let idleSequence = SKAction.sequence([timer, reminderIfIdle])
        let repeatIdleSequence = SKAction.repeatForever(idleSequence)
        run(repeatIdleSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // if no instructions are playing
        if (instructionsComplete == true) && (reminderComplete == true) {
            let touch = touches.first!
        
            //If duck sprite is touched...
            if cookie.contains(touch.location(in: self)) {
                cookie_correctTouches += 1
                correctTouches += 1
            
                // Color cookie, play crunch noise
                cookie.texture = SKTexture(imageNamed: "Chocolate-Chip")
                let crunch = SKAction.playSoundFileNamed("crunch", waitForCompletion: true)
                cookie.run(crunch)

                //Variables to switch screens
                let fadeOut = SKAction.fadeOut(withDuration:2)
                let wait2 = SKAction.wait(forDuration: 2)
                let sequenceFade = SKAction.sequence([wait2, fadeOut])
                run(sequenceFade) {
                    let airplaneScene = SKScene(fileNamed: "AirplaneScene")
                    airplaneScene?.scaleMode = SKSceneScaleMode.aspectFill
                    self.scene!.view?.presentScene(airplaneScene!)
                }
            }
            else {
                cookie_incorrectTouches += 1
                incorrectTouches += 1
            }
            
            // play reminder instructions if user has touched screen 3 times incorrectly
            if cookie_incorrectTouches == 3 && cookie_correctTouches < 1 {
                reminderComplete = false
                let cookie_reminder = SKAction.playSoundFileNamed("listenCarefully_Cookie", waitForCompletion: true)
                run(cookie_reminder, completion: { self.reminderComplete = true} )
            }
        }
    }
}

