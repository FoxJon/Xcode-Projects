//
//  PSSPianoViewController.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/25/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSPianoViewController.h"
#import "PSSPlayer.h"

@interface PSSPianoViewController ()

@property (nonatomic) int playlength;

@end

@implementation PSSPianoViewController
{
    UIButton * cKey;
    UIButton * csKey;
    UIButton * dKey;
    UIButton * dsKey;
    UIButton * eKey;
    UIButton * fKey;
    UIButton * fsKey;
    UIButton * gKey;
    UIButton * gsKey;
    UIButton * aKey;
    UIButton * asKey;
    UIButton * bKey;
    UIButton * c2Key;
    UIButton * cs2Key;
    UIButton * startButton;
    
    int noteCount;
    
    UIView * whiteKeyGlow;
    UIView * blackKeyGlow;
    
    NSArray * notes;
    NSArray * keys;
    NSMutableArray * glowKeys;
    NSMutableArray * songList;
    NSMutableArray * tempSongNotesArray;
    
    PSSPlayer * player;
    
    BOOL gameOn;

//SONGS
    NSDictionary * rewardSequenceArray;
    NSDictionary * endGameSequenceArray;
    NSDictionary * twinkleTwinkleArray;
    NSDictionary * maryHadALittleLambArray;
    NSDictionary * oldMacDonaldArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blueColor];
        
        gameOn = NO;
        
        UIView * frame = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 30)];
        frame.backgroundColor = [UIColor blueColor];
        [self.view addSubview:frame];
        
        startButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .85, 5, 50, 20)];
        startButton.layer.cornerRadius = 5;
        startButton.titleLabel.text = @"Start";
        startButton.titleLabel.textColor = [UIColor whiteColor];
        startButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        [startButton setTitle:@"START" forState:UIControlStateNormal];
        startButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
        [frame addSubview:startButton];
        
        songList = [@[] mutableCopy];
        tempSongNotesArray = [@[]mutableCopy];

        notes = @[@"cNote", @"dNote", @"eNote", @"fNote", @"gNote", @"aNote", @"bNote", @"c2Note", @"csNote", @"dsNote", @"fsNote", @"gsNote", @"asNote", @"cs2Note"];
        
        keys = @[@"cKey", @"dKey", @"eKey", @"fKey", @"gKey", @"aKey", @"bKey", @"c2Key", @"csKey", @"dsKey", @"fsKey", @"gsKey", @"asKey", @"cs2Key"];
        
        player = [[PSSPlayer alloc]init];
        
        whiteKeyGlow = [[UIButton alloc]initWithFrame:CGRectMake(0, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
        whiteKeyGlow.layer.cornerRadius = 15;

        blackKeyGlow= [[UIButton alloc]initWithFrame:CGRectMake(0, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
        blackKeyGlow.layer.cornerRadius = 15;

////////////////////////////////////////////////////////////////////////////////
///////////// SONGS ARRAYS /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
        
        rewardSequenceArray = @{
                            @"tempo":@[@50, @300, @400, @500, @600, @700],
                            @"notes":@[@7, @1, @2, @4, @7, @0]
                            };
        [songList addObject:rewardSequenceArray];
        
        endGameSequenceArray = @{
                                @"tempo":@[@50, @60, @275, @280, @500, @800, @900, @1000, @1100, @1400, @1700],
                                @"notes":@[@0, @8,   @0,   @8,   @12,  @5,  @11,  @4,   @10,    @9,    @0]
                                };
        
        twinkleTwinkleArray = @{
                            @"tempo":@[@50, @400, @700, @1000, @1300, @1600, @1900, @2500, @2800, @3100, @3400, @3700, @4000, @4300],
                            @"notes":@[@0,   @0,   @4,  @4,    @5,    @5,    @4,   @3,    @3,    @2,    @2,    @1,    @1,   @0]
                            };
        [songList addObject:twinkleTwinkleArray];
        
        maryHadALittleLambArray = @{
                            @"tempo":@[@50, @400, @700, @1000, @1300, @1600, @1900, @2500, @2800, @3100, @3700, @4000, @4300],
                            @"notes":@[@2, @1,   @0,   @1,   @2,   @2,    @2,    @1,    @1,   @1,    @2,    @4,    @4]
                               };
        [songList addObject:maryHadALittleLambArray];
        
        oldMacDonaldArray = @{
                              @"tempo":@[@50, @400, @700, @1000, @1300, @1600, @1900, @2500, @2800, @3100, @3400, @3700],
                              @"notes":@[@3,   @3,   @3,  @0,    @1,    @1,    @0,   @5,    @5,    @4,    @4,   @3]
                              };
        [songList addObject:oldMacDonaldArray];

        [self introSong];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    glowKeys = [@[] mutableCopy];
    
    cKey = [[UIButton alloc]initWithFrame:CGRectMake(0, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    cKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    cKey.layer.cornerRadius = 15;
    cKey.tag = 0;
    [cKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [cKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [cKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:cKey];
    [glowKeys addObject:cKey];
    
    dKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*1, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    dKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    dKey.layer.cornerRadius = 15;
    dKey.tag = 1;
    [dKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    
//    [dKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [dKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:dKey];
    [glowKeys addObject:dKey];
    
    eKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*2, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    eKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    eKey.layer.cornerRadius = 15;
    eKey.tag = 2;
    [eKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [eKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [eKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:eKey];
    [glowKeys addObject:eKey];
    
    fKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*3, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    fKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    fKey.layer.cornerRadius = 15;
    fKey.tag = 3;
    [fKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [fKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [fKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:fKey];
    [glowKeys addObject:fKey];
    
    gKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*4, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    gKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    gKey.layer.cornerRadius = 15;
    gKey.tag = 4;
    [gKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [gKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [gKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:gKey];
    [glowKeys addObject:gKey];
    
    aKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*5, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    aKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    aKey.layer.cornerRadius = 15;
    aKey.tag = 5;
    [aKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [aKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [aKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:aKey];
    [glowKeys addObject:aKey];
    
    bKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*6, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    bKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    bKey.layer.cornerRadius = 15;
    bKey.tag = 6;
    [bKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [bKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [bKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:bKey];
    [glowKeys addObject:bKey];
    
    c2Key = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*7, -100, SCREEN_WIDTH/8, SCREEN_HEIGHT+100)];
    c2Key.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    c2Key.layer.cornerRadius = 15;
    c2Key.tag = 7;
    [c2Key addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [c2Key addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [c2Key addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:c2Key];
    [glowKeys addObject:c2Key];
    
    csKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*1-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    csKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    csKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    csKey.tag = 8;
    [csKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [csKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [csKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:csKey];
    [glowKeys addObject:csKey];
    
    dsKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*2-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    dsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    dsKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    dsKey.tag = 9;
    [dsKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [dsKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [dsKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:dsKey];
    [glowKeys addObject:dsKey];
    
    fsKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*4-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    fsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    fsKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    fsKey.tag = 10;
    [fsKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [fsKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [fsKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:fsKey];
    [glowKeys addObject:fsKey];
    
    gsKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*5-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    gsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    gsKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    gsKey.tag = 11;
    [gsKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [gsKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [gsKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:gsKey];
    [glowKeys addObject:gsKey];
    
    asKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*6-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    asKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    asKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    asKey.tag = 12;
    [asKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
//    [asKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [asKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:asKey];
    [glowKeys addObject:asKey];
    
    cs2Key = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*8-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    cs2Key.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    cs2Key.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    cs2Key.tag = 13;
    [cs2Key addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    //    [asKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    //    [asKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:cs2Key];
    [glowKeys addObject:cs2Key];
}

////////////////////////////////////////////////////////////////////////////////
///////////// SONGS PLAYER /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

-(void)introSong
{
    for (int i = 0 ; i < [rewardSequenceArray[@"notes"]count]; i++) {
        int y = [rewardSequenceArray[@"tempo"][i] intValue];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            int x = [rewardSequenceArray[@"notes"][i] intValue];
            [player playSoundWithName:notes[x]];
            [self glowKey:x];
        });
    }
}

-(void)endGame
{
    for (int i = 0 ; i < [endGameSequenceArray[@"notes"]count]; i++) {
        int y = [endGameSequenceArray[@"tempo"][i] intValue];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            int x = [endGameSequenceArray[@"notes"][i] intValue];
            [player playSoundWithName:notes[x]];
            [self glowKey:x];
        });
    }
}


- (void)playSong:(int)indexOfSonglist
{
    NSDictionary *currentSong = songList[indexOfSonglist];
    self.playlength++;
    NSLog(@"%d", self.playlength);
    
    for (int i = 0 ; i < ([currentSong[@"notes"]count]-[currentSong[@"notes"]count])+self.playlength; i++) {
        int y = [currentSong[@"tempo"][i] intValue];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            int x = [currentSong[@"notes"][i] intValue];
            [player playSoundWithName:notes[x]];
            [tempSongNotesArray addObject:notes[x]];
            [self glowKey:x];
        });
    }
}
///////////////////////////////////////////////////////////////////////////////

-(void)startGame
{
    self.playlength = 0;
    NSLog(@"%@", tempSongNotesArray);
    [tempSongNotesArray removeAllObjects];
    NSLog(@"%@", tempSongNotesArray);

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1000 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [self playSong:1];
    });
    
    [self resetButtons];
}

- (void)playGame:(UIButton *)sender
{
    if (notes[sender.tag] == tempSongNotesArray[noteCount])
    {
        if (noteCount < [tempSongNotesArray count])
        {
            noteCount++;
            if (noteCount == [tempSongNotesArray count])
                {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1000 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                    [self playSong:1];
                });
            }
        }
    }else{
        [self endGame];
        return;
    }
}

- (void) resetButtons
{
    [cKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [dKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [eKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [fKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [gKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [aKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [bKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [c2Key addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [csKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [dsKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [fsKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [gsKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [asKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    [cs2Key addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
}


- (void)glowKey:(int)indexOfKeyView
{
    UIView * currentGlowKey = glowKeys[indexOfKeyView];
    currentGlowKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        currentGlowKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:^(BOOL finished) {
    }];
}


-(void)playNote:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        sender.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:^(BOOL finished) {
    }];
    
    [player playSoundWithName:notes[sender.tag]];
    
    NSString * key = keys[sender.tag];
    NSLog(@"key %@", key);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
