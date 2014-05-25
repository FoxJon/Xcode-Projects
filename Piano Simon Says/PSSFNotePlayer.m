//
//  PSSFNotePlayer.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/25/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSFNotePlayer.h"

@implementation PSSFNotePlayer

- (void)playSoundWithName:(NSString *)soundName
{
    NSData *fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:soundName ofType:@"mp3"]];
    
    self.player = [[AVAudioPlayer alloc]initWithData:fileData error:nil];
    
    self.player.numberOfLoops = 0;
    
    [self.player play];
}

@end
