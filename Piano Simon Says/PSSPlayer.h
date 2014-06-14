//
//  PSSANotePlayer.h
//  Piano Says
//
//  Created by Jonathan Fox on 5/25/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PSSPlayer : NSObject <AVAudioPlayerDelegate>

// create an array property
@property (nonatomic) NSMutableArray * players;

- (void)playSoundWithName:(NSString *)soundName;

@end
