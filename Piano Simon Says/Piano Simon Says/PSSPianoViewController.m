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
@property (nonatomic) int songSelector;

@property (nonatomic) BOOL gameOn;
@property (nonatomic) BOOL randomMode;

@property (nonatomic) float currentTempo;


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
    
    UILabel * keyLabel;
    UILabel * cLabel;
    UILabel * dLabel;
    UILabel * eLabel;
    UILabel * fLabel;
    UILabel * gLabel;
    UILabel * aLabel;
    UILabel * bLabel;
    UILabel * c2Label;
    UILabel * displayWindow;
    
    int noteCount;
    int score;
    int maxScore;
    
    NSNumber * sn;  //sixteenth note
    NSNumber * en;  //eighth note
    NSNumber * qn;  //quarter note
    NSNumber * dqn; //dotted quarter note
    NSNumber * hn;  // half note
    NSNumber * dhn; //dotted half note
    
    UIView * whiteKeyGlow;
    UIView * blackKeyGlow;
    UIView * tableHeaderView;
    UIView * settingsPage;
    UIView * headerFrame;
    UIView * startButtonFrame;
    
    NSArray * notes;
    NSArray * keys;
    NSArray * fullSongsTitles;
    NSArray * keyNameLabels;
    NSArray * solfegeLabels;

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
    NSDictionary * rowRowRowGameArray;
    NSMutableDictionary * randomNotesDict;

    NSDictionary * twinkleTwinkleFullArray;
    NSDictionary * maryHadALittleLambFullArray;
    NSDictionary * oldMacDonaldFullArray;
    NSDictionary * rowRowRowFullArray;
    
    UISegmentedControl * keyLabelSegmentedControl;
    UISegmentedControl * randomModeSegmentedControl;

    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.currentTempo = 0.9;

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
        
        displayWindow = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-20, headerFrame.frame.size.height/2-14, 40, 28)];
        displayWindow.text = @"0";
        displayWindow.font = [UIFont fontWithName:@"HelveticaNeue-light" size:26];
        displayWindow.textColor = [UIColor colorWithWhite:1.0 alpha:0.7];
        displayWindow.textAlignment = 1;
        displayWindow.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        
        NSArray * labelArray = @[@"Note Names", @"Do-Re-Mi"];
        keyLabelSegmentedControl = [[UISegmentedControl alloc] initWithItems:labelArray];
        keyLabelSegmentedControl.frame = CGRectMake(35, SCREEN_HEIGHT * 0.1, 185, 40);
        keyLabelSegmentedControl.selectedSegmentIndex = 1;
        [keyLabelSegmentedControl addTarget:self action:@selector(labelKeys:)forControlEvents:UIControlEventValueChanged];
        
        NSArray * gameModeArray = @[@"Songs", @"Random Notes"];
        randomModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:gameModeArray];
        randomModeSegmentedControl.frame = CGRectMake(35, SCREEN_HEIGHT * 0.3, 185, 40);
        randomModeSegmentedControl.selectedSegmentIndex = 1;
        [randomModeSegmentedControl addTarget:self action:@selector(setGameMode:)forControlEvents:UIControlEventValueChanged];
        
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
//                          LOAD SONGS                                        //
////////////////////////////////////////////////////////////////////////////////
        
        float tempoMultiplier = 0.9;

        dhn = [NSNumber numberWithFloat:875 * tempoMultiplier];
        hn = [NSNumber numberWithFloat:700 * tempoMultiplier];
        dqn = [NSNumber numberWithFloat:525 * tempoMultiplier];
        qn = [NSNumber numberWithFloat:350 * tempoMultiplier];
        en = [NSNumber numberWithFloat:175 * tempoMultiplier];
        sn = [NSNumber numberWithFloat:87.5 * tempoMultiplier];
        
        [self setGameSongTempos:0.9];
        
        fullSongsTitles = @[@"Twinkle Twinkle", @"Mary Had A Little Lamb", @"Old MacDonald", @"Row, Row, Row"];
        
        rewardSequenceArray = @{
                                @"tempo":@[qn, en, sn, sn, sn, sn],
                                @"notes":@[@7, @1, @2, @4, @7, @0]
                                };
        [rewardSongsList addObject:rewardSequenceArray];
        
        endGameSequenceArray = @{
                                 @"tempo":@[qn, qn, sn, sn, sn, qn, qn],
                                 @"notes":@[@12, @5, @11, @4, @10, @9, @0]
                                 };
        [rewardSongsList addObject:endGameSequenceArray];
        
        
        
        twinkleTwinkleFullArray = @{
                                    @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn],
                                    @"notes":@[@0, @0, @4, @4, @5, @5, @4, @3, @3, @2, @2, @1, @1, @0, @4, @4,@3, @3, @2, @2, @1, @4, @4, @3, @3, @2, @2, @1, @0, @0, @4, @4, @5, @5,   @4, @3, @3, @2, @2, @1, @1, @0]
                                    };
        [fullSongsList addObject:twinkleTwinkleFullArray];
        
        
        
        maryHadALittleLambFullArray = @{
                                        @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, hn, qn, qn, hn, qn, qn, qn, qn, qn, qn, qn, qn, qn, qn, qn, qn],
                                        @"notes":@[@2, @1, @0, @1, @2, @2, @2, @1, @1, @1, @2, @4, @4, @2, @1,  @0, @1, @2, @2, @2, @2, @1, @1, @2, @1, @0]
                                        };
        [fullSongsList addObject:maryHadALittleLambFullArray];
        
        
        
        oldMacDonaldFullArray = @{
                                  @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, dhn, qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, dhn, en, en, qn, qn, qn, en, en, qn, qn, hn, en, en, qn, en, en, qn, en, en, en, en, qn, qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn],
                                  @"notes":@[@3, @3, @3, @0, @1, @1, @0, @5, @5, @4, @4, @3, @0, @3, @3, @3, @0, @1, @1, @0, @5, @5, @4, @4, @3, @0, @0, @3, @3, @3, @0, @0, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @0, @1, @1, @0, @5, @5, @4, @4, @3]
                                  };
        [fullSongsList addObject:oldMacDonaldFullArray];
        
        
        rowRowRowFullArray = @{
                               @"tempo":@[qn, dqn, dqn, qn, en, dqn, qn, en, qn, en, dhn, en, en, en, en, en, en, en, en, en, en, en, en, qn, en, qn, en],
                               @"notes":@[@0, @0, @0, @1, @2, @2, @1, @2, @3, @4, @7, @7, @7, @4, @4, @4, @2, @2, @2, @0, @0, @0, @4, @3, @2, @1, @0, ]
                               };
        [fullSongsList addObject:rowRowRowFullArray];
        
        randomNotesDict = [@{
                             @"tempo":@[],
                             @"notes":[@[] mutableCopy]
                             }mutableCopy];

        [self playRewardSong:0];
    }
    return self;
}

- (void)setGameSongTempos:(float)tempo
{
    [gameSongsList removeAllObjects];
    
    float tempoMultiplier = tempo;
    
    dhn = [NSNumber numberWithFloat:875 * tempoMultiplier];
    hn = [NSNumber numberWithFloat:700 * tempoMultiplier];
    dqn = [NSNumber numberWithFloat:525 * tempoMultiplier];
    qn = [NSNumber numberWithFloat:350 * tempoMultiplier];
    en = [NSNumber numberWithFloat:175 * tempoMultiplier];
    sn = [NSNumber numberWithFloat:87.5 * tempoMultiplier];
    
    twinkleTwinkleGameArray = @{
                                @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn],
                                @"notes":@[@0, @0, @4, @4, @5, @5, @4, @3, @3, @2, @2, @1, @1, @0]
                                };
    [gameSongsList addObject:twinkleTwinkleGameArray];
    
    maryHadALittleLambGameArray = @{
                                    @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, hn, qn, qn],
                                    @"notes":@[@2, @1, @0, @1, @2, @2, @2, @1, @1, @1, @2, @4, @4]
                                    };
    [gameSongsList addObject:maryHadALittleLambGameArray];
    
    
    oldMacDonaldGameArray = @{
                              @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn],
                              @"notes":@[@3, @3, @3, @0, @1, @1, @0, @5, @5, @4, @4, @3]
                              };
    [gameSongsList addObject:oldMacDonaldGameArray];

    
    rowRowRowGameArray = @{
                           @"tempo":@[qn, dqn, dqn, qn, en, dqn, qn, en, qn, en],
                           @"notes":@[@0, @0, @0, @1, @2, @2, @1, @2, @3, @4]
                           };
    [gameSongsList addObject:rowRowRowGameArray];
    
    [randomNotesDict setObject:qn forKey:@"tempo"];
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
    
    int circleWidth = SCREEN_WIDTH/8-10;
    
    cLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    cLabel.layer.cornerRadius = circleWidth/2;
    cLabel.layer.masksToBounds = YES;
    cLabel.text = @"DO";
    cLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    cLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    cLabel.textAlignment = 1;
    cLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:cLabel];
    
    dLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*1+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    dLabel.layer.cornerRadius = circleWidth/2;
    dLabel.layer.masksToBounds = YES;
    dLabel.text = @"RE";
    dLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    dLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    dLabel.textAlignment = 1;
    dLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:dLabel];
    
    eLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*2+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    eLabel.layer.cornerRadius = circleWidth/2;
    eLabel.layer.masksToBounds = YES;
    eLabel.text = @"MI";
    eLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    eLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    eLabel.textAlignment = 1;
    eLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:eLabel];
    
    fLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*3+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    fLabel.layer.cornerRadius = circleWidth/2;
    fLabel.layer.masksToBounds = YES;
    fLabel.text = @"FA";
    fLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    fLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    fLabel.textAlignment = 1;
    fLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:fLabel];
    
    gLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*4+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    gLabel.layer.cornerRadius = circleWidth/2;
    gLabel.layer.masksToBounds = YES;
    gLabel.text = @"SO";
    gLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    gLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    gLabel.textAlignment = 1;
    gLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:gLabel];
    
    aLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*5+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    aLabel.layer.cornerRadius = circleWidth/2;
    aLabel.layer.masksToBounds = YES;
    aLabel.text = @"LA";
    aLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    aLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    aLabel.textAlignment = 1;
    aLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:aLabel];
    
    bLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*6+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    bLabel.layer.cornerRadius = circleWidth/2;
    bLabel.layer.masksToBounds = YES;
    bLabel.text = @"TI";
    bLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    bLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    bLabel.textAlignment = 1;
    bLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:bLabel];
    
    c2Label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*7+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    c2Label.layer.cornerRadius = circleWidth/2;
    c2Label.layer.masksToBounds = YES;
    c2Label.text = @"DO";
    c2Label.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    c2Label.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    c2Label.textAlignment = 1;
    c2Label.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:c2Label];
}

////////////////////////////////////////////////////////////////////////////////
///////////// SONGS PLAYER /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

- (void)playFullSong:(int)indexOfFullSongslist
{
    NSDictionary *currentSong = fullSongsList[indexOfFullSongslist];
    
    [self playSong:currentSong withNote:0];
}

- (void)playRewardSong:(int)indexOfRewardSongslist
{
    NSDictionary *currentSong = rewardSongsList[indexOfRewardSongslist];
    
    [self playSong:currentSong withNote:0];
}

- (void)playSong:(NSDictionary *)currentSong withNote:(int)note
{
    int y = [currentSong[@"tempo"][note] intValue];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        
        int x = [currentSong[@"notes"][note] intValue];
        [player playSoundWithName:notes[x]];
        [self glowKey:x];
        
        if([currentSong[@"notes"] count] - 1 > note) [self playSong:currentSong withNote:note + 1];
    });
}

-(void)prePlaySongGame:(int)indexOfGameSongslist
{
    score = 0;
    NSDictionary *currentSong = gameSongsList[indexOfGameSongslist];
    self.playlength++;
    
    self.currentTempo = self.currentTempo - 0.05;
    
    [self setGameSongTempos:self.currentTempo];
    
    if (self.playlength > [currentSong[@"notes"]count])
    {
        [self setGameSongTempos:0.9];
        [self playRewardSong:0];
        [self rewardDisplay:0];
        [displayWindow removeFromSuperview];
        [self rewardDisplay:0];
        self.gameOn = NO;
        return;
    }
    [self playSongGame:(NSDictionary *)currentSong withNote:0];
}

- (void)playSongGame:(NSDictionary *)currentSong withNote:(int)note
{
    int y = [currentSong[@"tempo"][note] intValue];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            int x = [currentSong[@"notes"][note] intValue];
            [player playSoundWithName:notes[x]];
            [tempSongNotesArray addObject:notes[x]];
            [self glowKey:x];
            
        if(note < self.playlength-1)
        {
            [self playSongGame:currentSong withNote:note + 1];
        }
    });
}

-(void)prePlayRandomNoteGame
{
    NSNumber * randomNumber = [NSNumber numberWithInt:arc4random_uniform(7)];
    
    NSMutableArray* currentNotes = randomNotesDict[@"notes"];
    currentNotes[[currentNotes count]] = randomNumber;
    
    score = 0;
    NSDictionary *currentSong = randomNotesDict;
    
    self.playlength++;

    if (self.currentTempo > 0.3) {
        self.currentTempo = self.currentTempo - 0.05;
    }
    NSLog(@"%f", self.currentTempo);

    [self setGameSongTempos:self.currentTempo];


    [self playRandomNoteGame:(NSDictionary *)currentSong withNote:0];
}

- (void)playRandomNoteGame:(NSDictionary *)currentSong withNote:(int)note
{
    int y = [currentSong[@"tempo"] intValue];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        int x = [currentSong[@"notes"][note] intValue];
        [player playSoundWithName:notes[x]];
        [tempSongNotesArray addObject:notes[x]];
        [self glowKey:x];

        if(note < self.playlength-1)
        {
            [self playRandomNoteGame:currentSong withNote:note + 1];
        }
    });
}
///////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

-(void)startGame
{
    [self closeSongTableView];
    self.gameOn = YES;
    randomNotesDict = [@{
                         @"tempo":@[],
                         @"notes":[@[] mutableCopy]
                         }mutableCopy];
    
    [headerFrame addSubview:displayWindow];
    displayWindow.text = [NSString stringWithFormat:@"0"];
    self.currentTempo = 0.9;

    self.playlength = 0;
    [tempSongNotesArray removeAllObjects];
    noteCount = 0;
    
    if (self.randomMode) {
        maxScore = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            [self prePlayRandomNoteGame];
        });
    }else{
        int songNumber = (int)[gameSongsList count];
        self.songSelector = arc4random_uniform(songNumber);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            [self prePlaySongGame:self.songSelector];
        });
    }
}

- (void)playGame:(UIButton *)sender
{
    if (self.gameOn){
        
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                    CRASHES HERE IF YOU PRESS TOO MANY NOTES
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

        if (notes[sender.tag] == tempSongNotesArray[noteCount]){
            score++;
            displayWindow.text = [NSString stringWithFormat:@"%d", score];
            NSLog(@"score: %d", score);
            NSLog(@"BF max score: %d", maxScore);
            if (score > maxScore) {
                maxScore = score;
                NSLog(@"max score: %d", maxScore);
            }
            if (noteCount < [tempSongNotesArray count]){
                noteCount++;
                
                if (noteCount == [tempSongNotesArray count]){
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1000 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                        if (self.randomMode) {
                            [self prePlayRandomNoteGame];
                        }else{
                            [self prePlaySongGame:self.songSelector];
                        }
                    });
                }
            }
        }else{
            if (self.randomMode) {
                displayWindow.text = @"0";
                [self rewardDisplay:maxScore];
                [self playRewardSong:0];
                return;
            }
            [self playRewardSong:1];
            [displayWindow removeFromSuperview];
            self.gameOn = NO;
            return;
        }
    }
}

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
    [self closeSongTableView];
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
        [settingsPage addSubview:keyLabelSegmentedControl];
        [settingsPage addSubview:randomModeSegmentedControl];

        
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

-(void)addSolfegeLabels
{
    cLabel.text = @"DO";
    dLabel.text = @"RE";
    eLabel.text = @"MI";
    fLabel.text = @"FA";
    gLabel.text = @"SA";
    aLabel.text = @"LA";
    bLabel.text = @"TI";
    c2Label.text = @"DO";
}

-(void)addkeyNameLabels
{
    cLabel.text = @"C";
    dLabel.text = @"D";
    eLabel.text = @"E";
    fLabel.text = @"F";
    gLabel.text = @"G";
    aLabel.text = @"A";
    bLabel.text = @"B";
    c2Label.text = @"C";
}

-(void) labelKeys:(id)sender{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    NSString * label = [control titleForSegmentAtIndex: [control selectedSegmentIndex]];
    if ([label  isEqual: @"Do-Re-Mi"]) {
        [self addSolfegeLabels];
    }else{
        [self addkeyNameLabels];
    }
}

-(void) setGameMode:(id)sender{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    NSString * label = [control titleForSegmentAtIndex: [control selectedSegmentIndex]];
    if ([label  isEqual: @"Random Notes"]) {
        self.randomMode = YES;
    }else{
        self.randomMode = NO;
    }
}

-(void)rewardDisplay:(int)totalScore
{
    UIView * rewardDisplayView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-50, SCREEN_WIDTH, 100)];
    rewardDisplayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rewardDisplayView];
    
    UILabel * rewardDisplayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, rewardDisplayView.frame.size.height)];
    rewardDisplayLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    rewardDisplayLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    rewardDisplayLabel.textAlignment = 1;
    [rewardDisplayView addSubview:rewardDisplayLabel];
    if (self.randomMode) {
        NSArray * phrase;
        int random = arc4random_uniform(3);
        if (totalScore <=3) {
            rewardDisplayLabel.text = [NSString stringWithFormat:@"%d in a row.", totalScore];
        }else if (totalScore <=7) {
            phrase = @[@"TERRIFIC!", @"GOOD JOB!", @"WAY TO GO!"];
            rewardDisplayLabel.text = [NSString stringWithFormat:@"%d in a row! %@", totalScore, phrase[random]];
        }else if (totalScore <=15){
            phrase = @[@"FANTASTIC!", @"EXCELLENT!", @"OUTSTANDING!"];
            rewardDisplayLabel.text = [NSString stringWithFormat:@"%d in a row! %@", totalScore, phrase[random]];
        }else if (totalScore >15){
            phrase = @[@"DYNAMITE!", @"AMAZING!", @"INCREDIBLE!"];
            rewardDisplayLabel.text = [NSString stringWithFormat:@"%d in a row! %@", totalScore, phrase[random]];
        }
    }else{
    rewardDisplayLabel.text = @"PERFECT!";
    }
    
    [UIView animateWithDuration:2.5 animations:^{
        rewardDisplayView.frame = CGRectMake(0, SCREEN_HEIGHT/2-125, SCREEN_WIDTH, 100);
        rewardDisplayView.alpha = 0;
    }completion:^(BOOL finished) {
        [rewardDisplayView removeFromSuperview];
    }];
    self.gameOn = NO;
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

    cell.textLabel.text = fullSongsTitles[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
    cell.textLabel.highlightedTextColor = [UIColor blueColor];
    
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectionColor;
    

    cell.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.2];
    cell.layer.cornerRadius = 5;
    cell.imageView.frame = CGRectMake(10, 10, 200, 20);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    int selectedSong = (int)indexPath.row;

    [self closeSongTableView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 500 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [self playFullSong:selectedSong];
    });
    
}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
