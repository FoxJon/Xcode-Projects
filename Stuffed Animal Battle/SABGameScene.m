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
    SKSpriteNode * player2HPBar;
    
    SKSpriteNode * buttonA;
    SKSpriteNode * buttonB;

    SKSpriteNode * dpadUp;
    SKSpriteNode * dpadDown;
    SKSpriteNode * dpadLeft;
    SKSpriteNode * dpadRight;
    
    SKSpriteNode * player1;
    SKSpriteNode * player2;

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
        timerLabel.fontColor = [SKColor whiteColor];
        timerLabel.fontSize = 16.0;
        
        [self addChild:timerLabel];
        
        player1HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 10)];
        player1HPBar.position = CGPointMake(barArea / 2.0 + 10, SCREEN_HEIGHT - 14.0);
        
        [self addChild:player1HPBar];
        
        player2HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 10)];
        player2HPBar.position = CGPointMake((barArea)/2.0 + 315, SCREEN_HEIGHT - 14.0);
        
        [self addChild:player2HPBar];
        
        buttonA = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        buttonA.position = CGPointMake(SCREEN_WIDTH-40, 80);
        [self addChild:buttonA];
        
        buttonB = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        buttonB.position = CGPointMake(SCREEN_WIDTH-80, 40);
        [self addChild:buttonB];
        
        dpadUp = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadUp.position = CGPointMake(80, 110);
        [self addChild:dpadUp];
        
        dpadDown = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadDown.position = CGPointMake(80, 30);
        [self addChild:dpadDown];
        
        dpadLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadLeft.position = CGPointMake(40, 70);
        [self addChild:dpadLeft];
        
        dpadRight = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dpadRight.position = CGPointMake(120, 70);
        [self addChild:dpadRight];
        
        player1 = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(40, 100)];
       
        player1.position = CGPointMake(SCREEN_WIDTH/4.0, 80);
        
        [self addChild:player1];
        
        SKPhysicsBody * playerPhysics = [SKPhysicsBody bodyWithRectangleOfSize:player1.size];
        player1.physicsBody = playerPhysics;
        
        SKSpriteNode * floor = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(SCREEN_WIDTH, 20)];
        
        floor.position = CGPointMake(SCREEN_WIDTH/2, 5);
        
        [self addChild:floor];

        SKPhysicsBody * floorPhysics = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
        
        floorPhysics.affectedByGravity = NO;
        floorPhysics.dynamic = NO;
        
        floor.physicsBody = floorPhysics;
        
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"%@", contact);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [[touches anyObject]locationInNode:self];
    
    [self testButtonsWithLocation:location];
}

-(void)testButtonsWithLocation:(CGPoint)location
{
    NSArray * buttons = @[buttonA, buttonB, dpadUp, dpadDown, dpadLeft, dpadRight];
    
    for (SKNode * button in buttons)
    {
        if ([button containsPoint:location])
        {
            switch ([buttons indexOfObject:button])
            {
                case 0:
                    NSLog(@"punch");
                {
                    SKSpriteNode * fireball = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(10, 10)];
                    fireball.position = player1.position;
                    
                    SKPhysicsBody * fireballPhysics = [SKPhysicsBody bodyWithRectangleOfSize:fireball.size];
                    
                    fireball.physicsBody = fireballPhysics;
                    
                    [self addChild:fireball];
                    
                    [fireball.physicsBody applyImpulse:CGVectorMake(8.0, 2.0)];
                              
                                                       }
                    break;
                case 1:
                    NSLog(@"kick");
                    break;
                case 2:
                {
                    NSLog(@"up");
                    [player1.physicsBody applyImpulse:CGVectorMake(0.0, 100.0)];
//                    static const CGFloat thrust = 0.12;
//                    [player1.physicsBody applyTorque:thrust];
//                    SKAction * jump = [SKAction moveToY:player1.position.y + 200 duration:0.5];
//                    [player1 runAction:jump];
                }
                    break;
                case 3:
                    NSLog(@"down");
                {
                    SKAction * crouch = [SKAction moveToY:player1.position.y - 20 duration:0.1];
                    [player1 runAction:crouch];
                }
                    break;
                case 4:
                {
                    NSLog(@"left");
                    [player1.physicsBody applyImpulse:CGVectorMake(-20.0, 0.0)];
//                    SKAction * moveLeft = [SKAction moveToX:player1.position.x - 5 duration:0.1];
//                    [player1 runAction:moveLeft];
                }
                    break;
                case 5:
                {
                    NSLog(@"right");
                    [player1.physicsBody applyImpulse:CGVectorMake(20.0, 0.0)];
//                    SKAction * moveRight = [SKAction moveToX:player1.position.x + 5 duration:0.1];
//                    [player1 runAction:moveRight];
                }
                    break;
                
            }
        }
    }
}


@end
