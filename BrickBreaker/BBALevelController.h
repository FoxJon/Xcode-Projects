//
//  BBALevelController.h
//  BrickBreaker
//
//  Created by Jonathan Fox on 4/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBALevelDelegate;

@interface BBALevelController : UIViewController

@property (nonatomic, assign) id<BBALevelDelegate> delegate;

-(void) resetLevel;

@end

@protocol BBALevelDelegate <NSObject>

@optional

-(void)addPoints: (int)points;
-(void)addLives: (int)totalLives;
-(void)gameDone:(int)points;


@end
