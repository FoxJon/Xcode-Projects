//
//  CBACrystalBall.h
//  CystalBall
//
//  Created by Jonathan Fox on 4/2/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBACrystalBall : NSObject{
    NSArray *_predictions;
}

@ property (strong, nonatomic, readonly) NSArray *predictions;
- (NSString *)randomPrediction;

@end
