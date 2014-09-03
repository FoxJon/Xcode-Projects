//
//  CystalBallTests.m
//  CystalBallTests
//
//  Created by Jonathan Fox on 4/1/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CBACrystalBall.h"

@interface CystalBallTests : XCTestCase
@property (nonatomic) CBACrystalBall * crystalBall;

@end

@implementation CystalBallTests

- (void)setUp
{
    [super setUp];
    self.crystalBall = [CBACrystalBall new];
}

- (void)tearDown
{
    self.crystalBall = nil;
    [super tearDown];
}

-(void)testCrystalBallNotNil {
    XCTAssertNotNil(self.crystalBall, @"crystalBall model was nil");
}

-(void)testPredictionsNotNil {
    XCTAssertNotNil(self.crystalBall.predictions, @"predictions array was nil");
}

-(void)testRandomPredictionsNotNil {
    XCTAssertNotNil(self.crystalBall.randomPrediction, @"RandomPredictions array was nil");
}

-(void)testRandomPredictionIsString {
    id prediction = self.crystalBall.randomPrediction;
    XCTAssertTrue([prediction isKindOfClass:[NSString class]], @"prediction is of class %@", [prediction class]);
}

@end
