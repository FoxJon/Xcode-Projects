//
//  PSSPianoViewController.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/25/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSPianoViewController.h"
#import "PSSPlayer.h"
#import "PSSPianoTableView.h"
#import "PSSSettingsView.h"
#import "PSSxView.h"

@interface PSSPianoViewController () 

@property (nonatomic) int playlength;
@property (nonatomic) BOOL gameOn;

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
    UIButton * songsButton;
    UIButton * closeButton;

    
    int noteCount;
    
    UIView * whiteKeyGlow;
    UIView * blackKeyGlow;
    UIView * tableHeaderView;
    UIView * settingsPage;
    UIView * headerFrame;
    UIView * startButtonFrame;
    
    NSArray * notes;
    NSArray * keys;
    NSMutableArray * glowKeys;
    NSMutableArray * gameSongsList;
    NSMutableArray * fullSongsList;
    NSMutableArray * rewardSongsList;
    NSMutableArray * tempSongNotesArray;
    
    PSSPlayer * player;
    UITableView *songTableView;
    
    PSSSettingsView * settingsView;
    UIButton * settingsButton;
    PSSxView * xView;
    UIButton * xButton;
    
//SONGS
    NSDictionary * rewardSequenceArray;
    NSDictionary * endGameSequenceArray;
    
    NSDictionary * twinkleTwinkleGameArray;
    NSDictionary * maryHadALittleLambGameArray;
    NSDictionary * oldMacDonaldGameArray;

    NSDictionary * twinkleTwinkleFullArray;
    NSDictionary * maryHadALittleLambFullArray;
    NSDictionary * oldMacDonaldFullArray;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        self.view.backgroundColor = [UIColor blueColor];
        self.gameOn = NO;
        
        settingsPage = [[UIView alloc]initWithFrame:CGRectMake(0, 0-SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        settingsPage.backgroundColor = [UIColor blueColor];
        [self.view addSubview:settingsPage];
        
        headerFrame = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 30)];
        headerFrame.backgroundColor = [UIColor blueColor];
        [self.view addSubview:headerFrame];
        
        songTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        songTableView.dataSource = self;
        songTableView.delegate = self;
        songTableView.rowHeight = 40;
        songTableView.backgroundColor = [UIColor blueColor];
        songTableView.frame = CGRectMake(SCREEN_WIDTH * .05, 30, 200, 0);
        songTableView.SeparatorColor = [UIColor blueColor];
        songTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.view addSubview:songTableView];
        
        tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .05, 5, 60, 20)];
        tableHeaderView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        tableHeaderView.layer.cornerRadius = 5;
        [headerFrame addSubview:tableHeaderView];
        
        startButtonFrame = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .80+2, 5, 53, 20)];
        startButtonFrame.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        startButtonFrame.layer.cornerRadius = 5;
        [headerFrame addSubview:startButtonFrame];
        
        closeButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .04-4, -5, 80, 40)];
        closeButton.layer.cornerRadius = 5;
        //closeButton.titleLabel.textColor = [UIColor whiteColor];
        closeButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        [closeButton setTitle:@"CLOSE" forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeSongTableView) forControlEvents:UIControlEventTouchUpInside];
        
        settingsView = [[PSSSettingsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .93, -5, 40, 40)];
        settingsView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        [headerFrame addSubview:settingsView];
        
        settingsButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .92, -5, 40, 40)];
        [settingsButton addTarget:self action:@selector(openSettingsPage) forControlEvents:UIControlEventTouchUpInside];
        //settingsButton.backgroundColor = [UIColor redColor];
        [headerFrame addSubview:settingsButton];
        
        xView = [[PSSxView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .93, -5, 40, 40)];
        xView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        
        xButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .92, -5, 40, 40)];
        [xButton addTarget:self action:@selector(closeSettingsPage) forControlEvents:UIControlEventTouchUpInside];
        //settingsButton.backgroundColor = [UIColor redColor];
        
        songsButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .04-4, -5, 80, 40)];
        songsButton.layer.cornerRadius = 5;
        songsButton.titleLabel.textColor = [UIColor whiteColor];
        songsButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        [songsButton setTitle:@"SONGS" forState:UIControlStateNormal];
        songsButton.backgroundColor = [UIColor clearColor];
        [songsButton addTarget:self action:@selector(openSongList) forControlEvents:UIControlEventTouchUpInside];
        [headerFrame addSubview:songsButton];
        
        startButton = [[UIButton alloc]initWithFrame:CGRectMake(-14,-10, 80, 40)];
        startButton.layer.cornerRadius = 5;
        startButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        //startButton.backgroundColor = [UIColor redColor];
        [startButton setTitle:@"START" forState:UIControlStateNormal];
        [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
        [startButtonFrame addSubview:startButton];
        
        rewardSongsList = [@[] mutableCopy];
        gameSongsList = [@[] mutableCopy];
        fullSongsList = [@[] mutableCopy];
        
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
        [rewardSongsList addObject:rewardSequenceArray];
        
        endGameSequenceArray = @{
                                @"tempo":@[@50, @400, @500, @600, @700, @1000, @1300],
                                @"notes":@[@12,  @5,  @11,  @4,   @10,  @9,   @0]
                                };
        [rewardSongsList addObject:endGameSequenceArray];

        
        twinkleTwinkleGameArray = @{
                            @"tempo":@[@50, @400, @700, @1000, @1300, @1600, @1900, @2500, @2800, @3100, @3400, @3700, @4000, @4300],
                            @"notes":@[@0,   @0,   @4,  @4,    @5,    @5,    @4,   @3,    @3,    @2,    @2,    @1,    @1,   @0]
                            };
        [gameSongsList addObject:twinkleTwinkleGameArray];
        
        twinkleTwinkleFullArray = @{
                                    @"tempo":@[@50, @400, @700, @1000, @1300, @1600, @1900, @2500, @2800, @3100, @3400, @3700, @4000, @4300],
                                    @"notes":@[@0,   @0,   @4,  @4,    @5,    @5,    @4,   @3,    @3,    @2,    @2,    @1,    @1,   @0]
                                    };
        [fullSongsList addObject:twinkleTwinkleFullArray];
        
        
        
        maryHadALittleLambGameArray = @{
                            @"tempo":@[@50, @400, @700, @1000, @1300, @1600, @1900, @2500, @2800, @3100, @3700, @4000, @4300],
                            @"notes":@[@2, @1,   @0,   @1,   @2,   @2,    @2,    @1,    @1,   @1,    @2,    @4,    @4]
                               };
        [gameSongsList addObject:maryHadALittleLambGameArray];
        
        maryHadALittleLambFullArray = @{
                                        @"tempo":@[@50, @400, @700, @1000, @1300, @1600, @1900, @2500, @2800, @3100, @3700, @4000, @4300],
                                        @"notes":@[@2, @1,   @0,   @1,   @2,   @2,    @2,    @1,    @1,   @1,    @2,    @4,    @4]
                                        };
        [fullSongsList addObject:maryHadALittleLambFullArray];
        
        oldMacDonaldGameArray = @{
                              @"tempo":@[@50, @400, @700, @1000, @1300, @1600, @1900, @2500, @2800, @3100, @3400, @3700],
                              @"notes":@[@3,   @3,   @3,  @0,    @1,    @1,    @0,   @5,    @5,    @4,    @4,   @3]
                              };
        [gameSongsList addObject:oldMacDonaldGameArray];
        
        oldMacDonaldFullArray = @{
                                  @"tempo":@[@50, @400, @700, @1000, @1300, @1600, @1900, @2500, @2800, @3100, @3400, @3700],
                                  @"notes":@[@3,   @3,   @3,  @0,    @1,    @1,    @0,   @5,    @5,    @4,    @4,   @3]
                                  };
        [fullSongsList addObject:oldMacDonaldFullArray];

        [self playRewardSong:0];
        
        NSLog(@"full songs list %@", fullSongsList);


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
    [cKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [cKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [cKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:cKey];
    [glowKeys addObject:cKey];
    
    dKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*1, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    dKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    dKey.layer.cornerRadius = 15;
    dKey.tag = 1;
    [dKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [dKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [dKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [dKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:dKey];
    [glowKeys addObject:dKey];
    
    eKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*2, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    eKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    eKey.layer.cornerRadius = 15;
    eKey.tag = 2;
    [eKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [eKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [eKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [eKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:eKey];
    [glowKeys addObject:eKey];
    
    fKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*3, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    fKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    fKey.layer.cornerRadius = 15;
    fKey.tag = 3;
    [fKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [fKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [fKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [fKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:fKey];
    [glowKeys addObject:fKey];
    
    gKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*4, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    gKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    gKey.layer.cornerRadius = 15;
    gKey.tag = 4;
    [gKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [gKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [gKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [gKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:gKey];
    [glowKeys addObject:gKey];
    
    aKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*5, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    aKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    aKey.layer.cornerRadius = 15;
    aKey.tag = 5;
    [aKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [aKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [aKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [aKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:aKey];
    [glowKeys addObject:aKey];
    
    bKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*6, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    bKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    bKey.layer.cornerRadius = 15;
    bKey.tag = 6;
    [bKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [bKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [bKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [bKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:bKey];
    [glowKeys addObject:bKey];
    
    c2Key = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*7, -100, SCREEN_WIDTH/8, SCREEN_HEIGHT+100)];
    c2Key.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    c2Key.layer.cornerRadius = 15;
    c2Key.tag = 7;
    [c2Key addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [c2Key addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [c2Key addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [c2Key addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:c2Key];
    [glowKeys addObject:c2Key];
    
    csKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*1-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    csKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    csKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    csKey.tag = 8;
    [csKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [csKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [csKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [csKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:csKey];
    [glowKeys addObject:csKey];
    
    dsKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*2-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    dsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    dsKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    dsKey.tag = 9;
    [dsKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [dsKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [dsKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [dsKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:dsKey];
    [glowKeys addObject:dsKey];
    
    fsKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*4-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    fsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    fsKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    fsKey.tag = 10;
    [fsKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [fsKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [fsKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [fsKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:fsKey];
    [glowKeys addObject:fsKey];
    
    gsKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*5-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    gsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    gsKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    gsKey.tag = 11;
    [gsKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [gsKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [gsKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [gsKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:gsKey];
    [glowKeys addObject:gsKey];
    
    asKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*6-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    asKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    asKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    asKey.tag = 12;
    [asKey addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [asKey addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
//    [asKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [asKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:asKey];
    [glowKeys addObject:asKey];
    
    cs2Key = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*8-(SCREEN_WIDTH/13)/2, SCREEN_HEIGHT-SCREEN_HEIGHT*1.25, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    cs2Key.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    cs2Key.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    cs2Key.tag = 13;
    [cs2Key addTarget:self action:@selector(playNote:) forControlEvents:UIControlEventTouchDown];
    [cs2Key addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchDown];
    //    [asKey addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    //    [asKey addTarget:self action:@selector(touchesCancelled:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:cs2Key];
    [glowKeys addObject:cs2Key];
}

////////////////////////////////////////////////////////////////////////////////
///////////// SONGS PLAYER /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

- (void)playFullSong:(int)indexOfFullSongslist
{
    NSLog(@"playSong");
    
    NSDictionary *currentSong = fullSongsList[indexOfFullSongslist];
    
    for (int i = 0 ; i < [currentSong[@"notes"]count]; i++) {
        int y = [currentSong[@"tempo"][i] intValue];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            int x = [currentSong[@"notes"][i] intValue];
            [player playSoundWithName:notes[x]];
            [self glowKey:x];
        });
    }
}

- (void)playRewardSong:(int)indexOfRewardSongslist
{
    NSLog(@"playSong");

    NSDictionary *currentSong = rewardSongsList[indexOfRewardSongslist];
    
    for (int i = 0 ; i < [currentSong[@"notes"]count]; i++) {
        int y = [currentSong[@"tempo"][i] intValue];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            int x = [currentSong[@"notes"][i] intValue];
            [player playSoundWithName:notes[x]];
            [self glowKey:x];
        });
    }
}

- (void)playSongGame:(int)indexOfGameSongslist
{
    NSLog(@"playSongGame");

    NSDictionary *currentSong = gameSongsList[indexOfGameSongslist];
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
////////////////////////////////////////////////////////////////////////////////

-(void)openSongList
{
    [songsButton removeFromSuperview];
    [self.view addSubview:closeButton];
    songTableView.frame = CGRectMake(SCREEN_WIDTH * .05, 30, 200, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
        tableHeaderView.frame = CGRectMake(SCREEN_WIDTH * .05, 5, 200, 25);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            songTableView.frame = CGRectMake(SCREEN_WIDTH * .05, 30, 200, SCREEN_HEIGHT);
        }completion:^(BOOL finished) {
        }];
    }];
}

-(void)closeSongTableView
{
    [closeButton removeFromSuperview];
    [self.view addSubview:songsButton];
    [UIView animateWithDuration:0.2 animations:^{
        songTableView.frame = CGRectMake(SCREEN_WIDTH * .05, 30, 200, 0);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            tableHeaderView.frame = CGRectMake(SCREEN_WIDTH * .05, 5, 60, 20);
           // songTableView.frame = CGRectMake(SCREEN_WIDTH * .05, 5, 0, 20);
        }completion:^(BOOL finished) {
        }];
    }];
}

-(void)openSettingsPage
{
    NSLog(@"open");
    [UIView animateWithDuration:0.4 animations:^{
        [startButton removeFromSuperview];
        [startButtonFrame removeFromSuperview];
        [tableHeaderView removeFromSuperview];
        [songsButton removeFromSuperview];
    settingsPage.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }completion:^(BOOL finished) {
            [settingsView removeFromSuperview];
            [settingsButton removeFromSuperview];
            [self.view addSubview:xView];
            [self.view addSubview:xButton];
        }];
}

-(void)closeSettingsPage
{
    [UIView animateWithDuration:0.2 animations:^{
        settingsPage.frame =  CGRectMake(0, 0-SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        [xView removeFromSuperview];
        [xButton removeFromSuperview];
        [headerFrame addSubview:tableHeaderView];
        [headerFrame addSubview:startButtonFrame];
        [headerFrame addSubview:settingsView];
        [headerFrame addSubview:settingsButton];
        [headerFrame addSubview:songsButton];
        [startButtonFrame addSubview:startButton];
    }];
}

-(void)startGame
{
    NSLog(@"startGame");
    self.gameOn = YES;

    self.playlength = 0;
    [tempSongNotesArray removeAllObjects];
    noteCount = 0;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [self playSongGame:0];
    });
}

- (void)playGame:(UIButton *)sender
{
    if (self.gameOn) {
        
        NSLog(@"playGame");

        if (notes[sender.tag] == tempSongNotesArray[noteCount])
        {
            if (noteCount == [tempSongNotesArray count])
            {
                [self playRewardSong:0];
                self.gameOn = NO;
                return;
            }else if (noteCount < [tempSongNotesArray count])
            {
                noteCount++;
                if (noteCount == [tempSongNotesArray count])
                    {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1000 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                        [self playSongGame:0];
                    });
                }
            }
            
        }else{
            [self playRewardSong:1];
            self.gameOn = NO;
            return;
        }
    }
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

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [fullSongsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.textLabel.text = fullSongsList[indexPath.row];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
//    cell.textLabel.highlightedTextColor = [UIColor blueColor];
//    
//    
//    UIView *selectionColor = [[UIView alloc] init];
//    selectionColor.backgroundColor = [UIColor clearColor];
//    cell.selectedBackgroundView = selectionColor;
//    
//
//    cell.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.2];
//    cell.layer.cornerRadius = 5;
//    cell.imageView.frame = CGRectMake(10, 10, 200, 20);
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    int selectedSong = (int)indexPath.row;
//
//    [self closeSongTableView];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 500 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
//        [self playFullSong:selectedSong];
//    });
//    
//}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
