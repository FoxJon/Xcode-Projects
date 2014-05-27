//
//  PSSANotePlayer.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/25/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSPlayer.h"

@implementation PSSPlayer

-(id)init
{
    self = [super init];
    if (self) {
        self.players = [@[]mutableCopy];
    }
    return self;
}

- (void)playSoundWithName:(NSString *)soundName
{
    NSData *fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:soundName ofType:@"mp3"]];
    
    AVAudioPlayer * player = [[AVAudioPlayer alloc]initWithData:fileData error:nil];
    
    player.delegate = self;
    
    [self.players addObject:player];
    
    //player.numberOfLoops = 0;
    
    [player play];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.players removeObjectIdenticalTo:player];
   // NSLog(@"number of players %d", (int)[self.players count]);
}

@end
