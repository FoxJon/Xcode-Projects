//
//  PSSFsNotePlayer.h
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/25/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PSSFsNotePlayer : NSObject <AVAudioPlayerDelegate>

@property (nonatomic) AVAudioPlayer * player;

- (void)playSoundWithName:(NSString *)soundName;

@end
