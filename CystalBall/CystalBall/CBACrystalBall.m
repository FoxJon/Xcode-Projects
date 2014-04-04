//
//  CBACrystalBall.m
//  CystalBall
//
//  Created by Jonathan Fox on 4/2/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "CBACrystalBall.h"

@implementation CBACrystalBall

- (NSArray *)predictions{
    if (_predictions == nil) {
        _predictions = @[@"It is certain",
                        @"It is decidedly so",
                        @"All signs say YES",
                        @"The stars are not aligned",
                        @"My reply is NO",
                        @"It is doubtful",
                        @"Better not tell anyone",
                        @"Concentrate and ask again",
                        @"Unable to answer now"];
    }
    return _predictions;
}

- (NSString *)randomPrediction{
    int random = arc4random_uniform(self.predictions.count);
    return [self.predictions objectAtIndex:random];
}

@end
