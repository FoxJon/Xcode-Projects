//
//  SABGameScene.m
//  Stuffed Animal Battle
//
//  Created by Jonathan Fox on 5/15/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SABGameScene.h"

@interface SABGameScene () <SKPhysicsContactDelegate>

@end

@implementation SABGameScene
{
    SKLabelNode * timerLabel;
    SKSpriteNode * player1HPBar;
    SKSpriteNode * player1Health;
    SKSpriteNode * player2HPBar;
    SKSpriteNode * player2Health;

    
//    SKSpriteNode * buttonA;
//    SKSpriteNode * buttonB;
//
//    SKSpriteNode * dpadUp;
//    SKSpriteNode * dpadDown;
//    SKSpriteNode * dpadLeft;
//    SKSpriteNode * dpadRight;
    
    SKSpriteNode * player1;
    SKSpriteNode * player2;
    
    SKTextureAtlas * charAtlas;
    SKTextureAtlas * danceAtlas;


}

-(instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self)
    {
        
        SKPhysicsBody * scenePhysics = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, size.width,     size.height)];
        
        self.physicsBody = scenePhysics;
        
        float barArea = ((SCREEN_WIDTH - 20) / 2.0) - 35;
        
        timerLabel = [SKLabelNode node];
        timerLabel.position = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT-20);
        timerLabel.text = @"00:00";
        timerLabel.fontColor = [SKColor blueColor];
        timerLabel.fontSize = 16.0;
        
        [self addChild:timerLabel];
        
        player1HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 10)];
        player1HPBar.position = CGPointMake(barArea / 2.0 + 10, SCREEN_HEIGHT - 14.0);
       
        player1Health = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(barArea, 10)];
        player1Health.position = CGPointMake(129.5, SCREEN_HEIGHT - 14.0);
        
        [self addChild:player1HPBar];
        [self addChild:player1Health];

        
        player2HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 10)];
        player2HPBar.position = CGPointMake((barArea)/2.0 + 315, SCREEN_HEIGHT - 14.0);
        
        player2Health = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(barArea, 10)];
        player2Health.position = CGPointMake(434.5, SCREEN_HEIGHT - 14.0);
        
        [self addChild:player2HPBar];
        [self addChild:player2Health];

        
//        buttonA = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
//        buttonA.position = CGPointMake(SCREEN_WIDTH-40, 80);
//        [self addChild:buttonA];
        
//        buttonB = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
//        buttonB.position = CGPointMake(SCREEN_WIDTH-80, 40);
//        [self addChild:buttonB];
        
//        dpadUp = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
//        dpadUp.position = CGPointMake(80, 110);
//        [self addChild:dpadUp];
//        
//        dpadDown = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
//        dpadDown.position = CGPointMake(80, 30);
//        [self addChild:dpadDown];
//        
//        dpadLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
//        dpadLeft.position = CGPointMake(40, 70);
//        [self addChild:dpadLeft];
//        
//        dpadRight = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
//        dpadRight.position = CGPointMake(120, 70);
//        [self addChild:dpadRight];
        
        charAtlas = [SKTextureAtlas atlasNamed:@"char"];
        danceAtlas = [SKTextureAtlas atlasNamed:@"dance"];
        
        player1 = [SKSpriteNode spriteNodeWithImageNamed:charAtlas.textureNames[0]];
        
        //player1 = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(40, 100)];
       
        player1.position = CGPointMake(SCREEN_WIDTH/4.0, 80);
        
        [self addChild:player1];
        
        SKPhysicsBody * playerPhysics = [SKPhysicsBody bodyWithRectangleOfSize:player1.size];
        
        player1.physicsBody = playerPhysics;
        
        NSMutableArray * textures = [@[]mutableCopy];
        
        for (int i = 1; i < danceAtlas.textureNames.count + 1; i++)
        {
            [textures addObject:[danceAtlas textureNamed:[NSString stringWithFormat:@"dance%d", i]]];
        }
        
        SKAction * dance = [SKAction animateWithTextures:textures timePerFrame:0.2];
        
        SKAction * danceAllNight = [SKAction repeatActionForever:dance];

        [player1 runAction:danceAllNight];
        
        
        player1.userData = [@{@"type":@"player1"}mutableCopy];
        
        SKSpriteNode * floor = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(SCREEN_WIDTH, 20)];
        
        floor.physicsBody.collisionBitMask = 2;
        
        floor.position = CGPointMake(SCREEN_WIDTH/2, 5);
        
        [self addChild:floor];

        SKPhysicsBody * floorPhysics = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
        
        floorPhysics.affectedByGravity = NO;
        floorPhysics.dynamic = NO;
        
        floor.physicsBody = floorPhysics;
        
        self.physicsWorld.contactDelegate = self;
        
        player2 = [SKSpriteNode spriteNodeWithColor:[SKColor purpleColor] size:CGSizeMake(40, 100)];
        
        player2.position = CGPointMake(SCREEN_WIDTH * 0.75, 80);
        
        [self addChild:player2];
        
        SKPhysicsBody * player2Physics = [SKPhysicsBody bodyWithRectangleOfSize:player2.size];
        player1.physicsBody = playerPhysics;
        
        player2.physicsBody = player2Physics;
        
        player2.userData = [@{@"type":@"player2"}mutableCopy];
        
        player2. physicsBody.collisionBitMask = 1;
        
        
//        SKSpriteNode *beaver = [SKSpriteNode spriteNodeWithImageNamed:@"char_frame1.png"];
//        beaver.position = CGPointMake(0,0);
//        [player1 addChild: beaver];
        
        SKSpriteNode *dino = [SKSpriteNode spriteNodeWithImageNamed:@"Dino"];
        dino.position = CGPointMake(0,0);
        [player2 addChild: dino];
    }
    return self;
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    
    NSMutableArray * nodes = [@[]mutableCopy];
    
    if (contact.bodyA.node != nil) [nodes addObject:contact.bodyA.node];
    if (contact.bodyB.node != nil) [nodes addObject:contact.bodyB.node];
    
    for (SKNode * node in nodes) {
        
        if ([node.userData[@"type"]isEqualToString:@"fireball"])
        {
            [self runAction:[SKAction playSoundFileNamed:@"Explo.wav" waitForCompletion:NO]];
            
            [node removeFromParent];
            
            NSString *myParticlePath = [[NSBundle mainBundle]pathForResource:@"Explosion" ofType:@"sks"];
            
            SKEmitterNode * explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
            
            explosion.position = contact.contactPoint;
            
            explosion.numParticlesToEmit = 50;
            
            [self addChild:explosion];
            
        }else if ([node.userData[@"type"]isEqualToString:@"player1"]){
            [self runAction:[SKAction playSoundFileNamed:@"Feet.wav" waitForCompletion:NO]];
        }
    }
}

-(void)fire:(UIButton *)sender
{
    [self runAction:[SKAction playSoundFileNamed:@"FireballShot.wav" waitForCompletion:NO]];
    
    NSString *myParticlePath = [[NSBundle mainBundle]pathForResource:@"Fireball" ofType:@"sks"];
    
    SKEmitterNode * fireball = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    
    fireball.position = CGPointMake(player1.position.x + 36.0, player1.position.y);
    
    //  fireball.position = player1.position;
    
    SKPhysicsBody * fireballPhysics = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
    
    fireballPhysics.affectedByGravity = NO;
    
    fireball.physicsBody = fireballPhysics;
    
    fireball.physicsBody.contactTestBitMask = 1;
    
    fireball.userData = [@{@"type":@"fireball"}mutableCopy];
    
    [self addChild:fireball];
    
    [fireball.physicsBody applyImpulse:CGVectorMake(9.0, 0.3)];
}

-(void)power:(UIButton *)sender
{
    [self runAction:[SKAction playSoundFileNamed:@"FireballShot.wav" waitForCompletion:NO]];
    
    NSString *myParticlePath = [[NSBundle mainBundle]pathForResource:@"powerUp" ofType:@"sks"];
    
    SKEmitterNode * fireball = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    
    fireball.position = CGPointMake(player1.position.x + 36.0, player1.position.y);
    
    //  fireball.position = player1.position;
    
    SKPhysicsBody * fireballPhysics = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
    
    fireballPhysics.affectedByGravity = NO;
    
    fireball.physicsBody = fireballPhysics;
    
    fireball.physicsBody.contactTestBitMask = 1;
    
    fireball.userData = [@{@"type":@"fireball"}mutableCopy];
    
    [self addChild:fireball];
    
    [fireball.physicsBody applyImpulse:CGVectorMake(11.0, 0.3)];
}

-(void)up:(UIButton *)sender
{
    [player1.physicsBody applyImpulse:CGVectorMake(0.0, 100.0)];
    
    for (NSString * textureName in charAtlas.textureNames) {
        NSLog(@"%@", textureName);
    }
    
    NSMutableArray * textures = [@[]mutableCopy];
    
    for (int i = 1; i < charAtlas.textureNames.count + 1; i++)
    {
        [textures addObject:[charAtlas textureNamed:[NSString stringWithFormat:@"charframe%d", i]]];
    }
    
    SKAction * setFrame2 = [SKAction animateWithTextures:textures timePerFrame:0.17];
    [player1 runAction:setFrame2];
    
//    static const CGFloat thrust = 0.12;
//    [player1.physicsBody applyTorque:thrust];
//    SKAction * jump = [SKAction moveToY:player1.position.y + 200 duration:0.5];
//    [player1 runAction:jump];

}

-(void)down:(UIButton *)sender
{
    SKAction * crouch = [SKAction moveToY:player1.position.y - 20 duration:0.1];
    [player1 runAction:crouch];
}

-(void)left:(UIButton *)sender
{
    [player1.physicsBody applyImpulse:CGVectorMake(-20.0, 0.0)];
    SKAction * moveLeft = [SKAction moveToX:player1.position.x - 5 duration:0.1];
    [player1 runAction:moveLeft];
}

-(void)right:(UIButton *)sender
{
    NSLog(@"right");
    [player1.physicsBody applyImpulse:CGVectorMake(20.0, 0.0)];
    SKAction * moveRight = [SKAction moveToX:player1.position.x + 5 duration:0.1];
    [player1 runAction:moveRight];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //UITouch* touch = [touches anyObject];
//    
//    CGPoint location = [[touches anyObject]locationInNode:self];
//    
//    [self testButtonsWithLocation:location];
//}


//-(void)testButtonsWithLocation:(CGPoint)location
//{
//    NSArray * buttons = @[buttonA, buttonB, dpadUp, dpadDown, dpadLeft, dpadRight];
//    
//    for (SKNode * button in buttons)
//    {
//        if ([button containsPoint:location])
//        {
//            switch ([buttons indexOfObject:button])
//            {
//                case 0:
//                    NSLog(@"Fireball");
//                    break;
//                case 1:
//                    NSLog(@"kick");
//                    break;
//                case 2:
//                {
//                    NSLog(@"up");
//                                    }
//                    break;
//                case 3:
//                    NSLog(@"down");
//                {
//                    
//                }
//                    break;
//                case 4:
//                {
//                    NSLog(@"left");
//                    
//                }
//                    break;
//                case 5:
//                {
//                   
//                }
//                    break;
//                
//            }
//        }
//    }
//}
//

@end
