//
//  GameScene.swift
//  StayAway
//
//  Created by Nabin Raj Pandey on 4/18/19.
//  Copyright © 2019 Jake Lin. All rights reserved.
//

import SpriteKit



class GameScene: SKScene {
    
    // Background
    //let background = SKSpriteNode(texture:SKTexture(imageNamed: "cloud"))
    
    // Clouds
     var darkNight = SKSpriteNode()
    var mainCloud = SKSpriteNode()
    var cloud1Next = SKSpriteNode()
    
    // Time of last frame
    var lastFrameTime : TimeInterval = 0
    
    // Time since last frame
    var deltaTime : TimeInterval = 0
    
    override func didMove(to view: SKView) {
     //   background.position = CGPoint(x: 0, y: 0)
        
        // Prepare the clouds sprites
        mainCloud = SKSpriteNode(texture:
            SKTexture(imageNamed: "cloud"))
        mainCloud.position = CGPoint(x: 0, y: 0)
        
        cloud1Next = mainCloud.copy() as! SKSpriteNode
        cloud1Next.position =
            CGPoint(x: mainCloud.position.x + mainCloud.size.width,
                    y: mainCloud.position.y)
        
        // Add the sprites to the scene
       // self.addChild(background)
        self.addChild(mainCloud)
        self.addChild(cloud1Next)
    }
    
    func setBlackBackground(){
        
        
        
        self.removeAllChildren()
        
        darkNight = SKSpriteNode(texture:
        SKTexture(imageNamed: "black_background"))
        darkNight.position = CGPoint(x: 0, y: 0)
        
       
        self.addChild(darkNight)
        
    }
    
    func setCloudBackground(){
        
        mainCloud = SKSpriteNode(texture:
            SKTexture(imageNamed: "cloud"))
        mainCloud.position = CGPoint(x: 0, y: 0)
        
        cloud1Next = mainCloud.copy() as! SKSpriteNode
        cloud1Next.position =
            CGPoint(x: mainCloud.position.x + mainCloud.size.width,
                    y: mainCloud.position.y)
        
        // Add the sprites to the scene
        // self.addChild(background)
        self.addChild(mainCloud)
        self.addChild(cloud1Next)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        // First, update the delta time values:
        
        // If we don't have a last frame time value, this is the first frame,
        // so delta time will be zero.
        if lastFrameTime <= 0 {
            lastFrameTime = currentTime
        }
        
        // Update delta time
        deltaTime = currentTime - lastFrameTime
        
        // Set last frame time to current time
        lastFrameTime = currentTime
        
        // Next, move each of the four pairs of sprites.
        // Objects that should appear move slower than foreground objects.
        self.moveSprite(sprite: mainCloud, nextSprite:cloud1Next, speed:100)
    }
    
    // Move a pair of sprites leftward based on a speed value;
    // when either of the sprites goes off-screen, move it to the
    // right so that it appears to be seamless movement
    func moveSprite(sprite : SKSpriteNode,
                    nextSprite : SKSpriteNode, speed : Float) -> Void {
        var newPosition = CGPoint.zero
        
        // For both the sprite and its duplicate:
        for spriteToMove in [sprite, nextSprite] {
            
            // Shift the sprite leftward based on the speed
            newPosition = spriteToMove.position
            newPosition.x -= CGFloat(speed * Float(deltaTime))
            spriteToMove.position = newPosition
            
            // If this sprite is now offscreen (i.e., its rightmost edge is
            // farther left than the scene's leftmost edge):
            if spriteToMove.frame.maxX < self.frame.minX {
                
                // Shift it over so that it's now to the immediate right
                // of the other sprite.
                // This means that the two sprites are effectively
                // leap-frogging each other as they both move.
                spriteToMove.position =
                    CGPoint(x: spriteToMove.position.x +
                        spriteToMove.size.width * 2,
                            y: spriteToMove.position.y)
            }
        }
    }
}
