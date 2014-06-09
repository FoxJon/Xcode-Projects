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
#import "PSSTableViewCell.h"
#import "PSSInstTableView.h"
#import "PSSSettingsView.h"
#import "PSSxView.h"

@interface PSSPianoViewController () 

@property (nonatomic) int playlength;
@property (nonatomic) int songSelector;

@property (nonatomic) BOOL gameOn;
@property (nonatomic) BOOL randomMode;
@property (nonatomic) BOOL expertMode;
@property (nonatomic) BOOL stopPlaying;
@property (nonatomic) BOOL isPlaying;

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
    UIButton * stopButton;
    UIButton * songsButton;
    UIButton * instButton;
    UIButton * closeSongTableButton;
    UIButton * closeInstTableButton;

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
    UIView * songsTableHeaderView;
    UIView * instTableHeaderView;
    UIView * settingsPage;
    UIView * headerFrame;
    UIView * startButtonFrame;
    
    NSArray * keys;
    NSArray * fullSongsTitles;
    NSArray * instrumentList;
    NSArray * keyNameLabels;
    NSArray * solfegeLabels;

    NSMutableArray * glowKeys;
    NSMutableArray * gameSongsList;
    NSMutableArray * fullSongsList;
    NSMutableArray * rewardSongsList;
    NSMutableArray * tempSongNotesArray;
    
    PSSPlayer * player;
    UITableView *songTableView;
    UITableView *instTableView;
    
    PSSSettingsView * settingsView;
    UIButton * settingsButton;
    PSSxView * xView;
    UIButton * xButton;
    
    NSString * instrument;
    
    UISegmentedControl * keyLabelSegmentedControl;
    UISegmentedControl * randomModeSegmentedControl;
    UISegmentedControl * expertModeSegmentedControl;
    
//SONGS
    NSDictionary * rewardSequenceArray;
    NSDictionary * endGameSequenceArray;
    
    NSDictionary * notes;
    NSDictionary * aTisketATasketGameArray;
    NSDictionary * goodMorningToYouGameArray;
    NSDictionary * hickoryDickoryDockGameArray;
    NSDictionary * itsRainingItsPouringGameArray;
    NSDictionary * lightlyRowGameArray;
    NSDictionary * londonBridgeGameArray;
    NSDictionary * maryHadALittleLambGameArray;
    NSDictionary * muffinManGameArray;
    NSDictionary * oldMacDonaldGameArray;
    NSDictionary * ringAroundTheRosyGameArray;
    NSDictionary * rowRowRowGameArray;
    NSDictionary * thisOldManGameArray;
    NSDictionary * threeBlindMiceGameArray;
    NSDictionary * twinkleTwinkleGameArray;
    NSMutableDictionary * randomNotesDict;
    
    NSDictionary * aTisketATasketFullArray;
    NSDictionary * goodMorningToYouFullArray;
    NSDictionary * hickoryDickoryDockFullArray;
    NSDictionary * itsRainingItsPouringFullArray;
    NSDictionary * lightlyRowFullArray;
    NSDictionary * londonBridgeFullArray;
    NSDictionary * maryHadALittleLambFullArray;
    NSDictionary * muffinManFullArray;
    NSDictionary * oldMacDonaldFullArray;
    NSDictionary * ringAroundTheRosyFullArray;
    NSDictionary * rowRowRowFullArray;
    NSDictionary * thisOldManFullArray;
    NSDictionary * threeBlindMiceFullArray;
    NSDictionary * twinkleTwinkleFullArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
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
        
        songsTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .05, 5, 60, 20)];
        songsTableHeaderView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        songsTableHeaderView.layer.cornerRadius = 5;
        [headerFrame addSubview:songsTableHeaderView];
        
        instTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        instTableView.dataSource = self;
        instTableView.delegate = self;
        instTableView.rowHeight = 40;
        instTableView.backgroundColor = [UIColor blueColor];
        instTableView.frame = CGRectMake(SCREEN_WIDTH/2-55, 30, 200, 0);
        instTableView.SeparatorColor = [UIColor blueColor];
        instTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.view addSubview:instTableView];
        
        instTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-55, 5, 110, 20)];
        instTableHeaderView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        instTableHeaderView.layer.cornerRadius = 5;
        [headerFrame addSubview:instTableHeaderView];
        
        startButtonFrame = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .80+2, 5, 53, 20)];
        startButtonFrame.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        startButtonFrame.layer.cornerRadius = 5;
        [headerFrame addSubview:startButtonFrame];
        
        closeSongTableButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .04-4, -5, 80, 40)];
        closeSongTableButton.layer.cornerRadius = 5;
        //closeButton.titleLabel.textColor = [UIColor whiteColor];
        closeSongTableButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        [closeSongTableButton setTitle:@"CLOSE" forState:UIControlStateNormal];
        [closeSongTableButton addTarget:self action:@selector(closeSongTableView) forControlEvents:UIControlEventTouchUpInside];
        
        closeInstTableButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-64, -5, 80, 40)];
        closeInstTableButton.layer.cornerRadius = 5;
        closeInstTableButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        [closeInstTableButton setTitle:@"CLOSE" forState:UIControlStateNormal];
        [closeInstTableButton addTarget:self action:@selector(closeInstTableView) forControlEvents:UIControlEventTouchUpInside];
        
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
        
        instButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-55, -5, 110, 40)];
        instButton.layer.cornerRadius = 5;
        instButton.titleLabel.textColor = [UIColor whiteColor];
        instButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        [instButton setTitle:@"INSTRUMENTS" forState:UIControlStateNormal];
        instButton.backgroundColor = [UIColor clearColor];
        [instButton addTarget:self action:@selector(openInstList) forControlEvents:UIControlEventTouchUpInside];
        [headerFrame addSubview:instButton];

        stopButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .04-4, -5, 80, 40)];
        stopButton.layer.cornerRadius = 5;
        stopButton.titleLabel.textColor = [UIColor whiteColor];
        stopButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        [stopButton setTitle:@"STOP" forState:UIControlStateNormal];
        stopButton.backgroundColor = [UIColor clearColor];
        [stopButton addTarget:self action:@selector(stopSong) forControlEvents:UIControlEventTouchUpInside];
        
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
        keyLabelSegmentedControl.frame = CGRectMake(35, SCREEN_HEIGHT * 0.2, 185, 40);
        keyLabelSegmentedControl.selectedSegmentIndex = [[defaults objectForKey:@"keyLabel"] intValue];
        [keyLabelSegmentedControl addTarget:self action:@selector(labelKeys:)forControlEvents:UIControlEventValueChanged];
        [self labelKeys:keyLabelSegmentedControl];
        
        UILabel * labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,-25, 500, 20)];
        labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
        labelTitle.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        labelTitle.text = @"Labels";
        [keyLabelSegmentedControl addSubview:labelTitle];
        
        NSArray * expertModeArray = @[@"Off", @"On"];
        expertModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:expertModeArray];
        expertModeSegmentedControl.frame = CGRectMake(35, SCREEN_HEIGHT * 0.8, 185, 40);
        expertModeSegmentedControl.selectedSegmentIndex = [[defaults objectForKey:@"expertMode"] intValue];;
        [expertModeSegmentedControl addTarget:self action:@selector(setGameMode:)forControlEvents:UIControlEventValueChanged];
        [self setGameMode:expertModeSegmentedControl];
        
        UILabel * expertModeTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,-25, 500, 20)];
        expertModeTitle.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
        expertModeTitle.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        expertModeTitle.text = @"Expert Mode - Labels off. All keys in random notes mode.";
        [expertModeSegmentedControl addSubview:expertModeTitle];

        NSArray * gameModeArray = @[@"Songs", @"Random Notes"];
        randomModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:gameModeArray];
        randomModeSegmentedControl.frame = CGRectMake(35, SCREEN_HEIGHT * 0.5, 185, 40);
        randomModeSegmentedControl.selectedSegmentIndex = [[defaults objectForKey:@"randomMode"] intValue];
        [randomModeSegmentedControl addTarget:self action:@selector(setGameMode:)forControlEvents:UIControlEventValueChanged];
        [self setGameMode:randomModeSegmentedControl];
        
        UILabel * gameModeTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,-25, 500, 20)];
        gameModeTitle.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
        gameModeTitle.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        gameModeTitle.text = @"Game Mode";
        [randomModeSegmentedControl addSubview:gameModeTitle];
        
        rewardSongsList = [@[] mutableCopy];
        gameSongsList = [@[] mutableCopy];
        fullSongsList = [@[] mutableCopy];
        instrumentList = [@[] mutableCopy];

        tempSongNotesArray = [@[]mutableCopy];
        
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
        
        [self loadListItems];
    
        if (self.titleItems == nil) {
            NSLog(@"NIL");
            self.titleItems = [
                           @[
                             [@{
                                 @"title":@"A-Tisket A-Tasket",
                                 @"locked":@"No"}mutableCopy],
                             [@{
                                 @"title":@"Good Morning To You",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"Hickory Dickory Dock",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"It’s Raining It’s Pouring",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"Lightly Row",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"London Bridge",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"Mary Had A Little Lamb",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"Muffin Man",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"Old MacDonald",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"Ring Around the Rosy",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"Row, Row, Row Your Boat",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"This Old Man",
                                 @"locked":@"Yes"}mutableCopy],

                             [@{
                                 @"title":@"Three Blind Mice",
                                 @"locked":@"Yes"} mutableCopy],
                             [@{
                                 @"title":@"Twinkle Twinkle",
                                 @"locked":@"Yes"} mutableCopy],
                             ]mutableCopy];
        }
                
        //NSLog(@"%@", [self.titleItems[1]objectForKey:@"locked"]);
       // NSLog(@"%@", self.titleItems);
        
        //[self.titleItems[1] setObject:@"No" forKey:@"locked"];
        
        //NSLog(@"%@", self.titleItems);


       // [self.titleItems[1] removeObjectForKey:@"locked"];

//        NSLog(@"%@", self.titleItems);
//        NSLog(@"%lu", (unsigned long)[self.titleItems count]);
        
        
        instrumentList = @[@"Piano1",@"Piano2",@"Piano3",@"Marimba",@"Xylophone"];
        
        int userInstrument = [[defaults objectForKey:@"instrument"] intValue];
        
        [self loadInst:userInstrument];
        
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
        
        
        aTisketATasketFullArray = @{
                                    @"tempo":@[qn,en,dqn,qn,en,dqn,qn,en,qn,en,qn,en,dqn,qn,en,qn,en,qn,en,qn,en,qn,en,qn,en,qn,en,dqn],
                                    @"notes":@[@5,@4,@2,@5,@4,@2,@3,@4,@4,@2,@5,@4,@2,@2,@3,@3,@1,@1,@3,@3,@1,@1,@4,@3,@2,@1,@2,@0]
                                    };
        [fullSongsList addObject:aTisketATasketFullArray];
        
        goodMorningToYouFullArray = @{
                                      @"tempo":@[qn,qn,qn,qn,qn,hn,qn,qn,qn,qn,hn,qn,qn,qn,qn,qn,qn,qn,qn,qn,qn],
                                      @"notes":@[@0,@1,@0,@3,@2,@0,@1,@0,@4,@3,@0,@7,@5,@3,@2,@1,@12,@5,@3,@4,@3]
                                    };
        [fullSongsList addObject:goodMorningToYouFullArray];
        
        hickoryDickoryDockFullArray = @{
                                        @"tempo":@[qn,en,en,en,en,en,en,dhn,en,qn,en,qn,en,dhn,en,qn,en,qn,en,qn,en,dqn,en,en,en,en,en,en],
                                        @"notes":@[@2,@3,@4,@3,@2,@1,@2,@2,@2,@4,@3,@1,@2,@2,@2,@2,@4,@4,@3,@3,@5,@4,@5,@4,@3,@2,@1,@0]
                                      };
        [fullSongsList addObject:hickoryDickoryDockFullArray];
        
        itsRainingItsPouringFullArray = @{
                                          @"tempo":@[qn,qn,hn,qn,qn,hn,qn,qn,qn,qn,qn,qn,hn,qn,qn,qn,qn,qn,qn,qn,qn,qn,qn,qn,qn,qn,qn,hn],
                                          @"notes":@[@5,@4,@2,@5,@4,@2,@3,@4,@4,@2,@5,@4,@2,@2,@3,@3,@1,@1,@3,@3,@1,@1,@4,@3,@2,@1,@2,@0]
                                        };
        [fullSongsList addObject:itsRainingItsPouringFullArray];
        
        lightlyRowFullArray = @{
                                @"tempo":@[qn,qn,qn,hn,qn,qn,hn,qn,qn,qn,qn,qn,qn,hn,qn,qn,hn,qn,qn,hn,qn,qn,qn,qn],
                                @"notes":@[@4,@2,@2,@3,@1,@1,@0,@1,@2,@3,@4,@4,@4,@4,@2,@2,@3,@1,@1,@0,@2,@4,@4,@2]
                                };
        [fullSongsList addObject:lightlyRowFullArray];
        
        londonBridgeFullArray = @{
                               @"tempo":@[qn,dqn,en,qn,qn,qn,qn,hn,qn,qn,hn,qn,qn,hn,dqn,en,qn,qn,qn,qn,hn,hn,hn,qn],
                               @"notes":@[@4,@5,@4,@3,@2,@3,@4,@1,@2,@3,@2,@3,@4,@4,@5,@4,@3,@2,@3,@4,@1,@4,@2,@0]
                               };
        [fullSongsList addObject:londonBridgeFullArray];
        
        maryHadALittleLambFullArray = @{
                                        @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, hn, qn, qn, hn, qn, qn, qn, qn, qn, qn, qn, qn, qn, qn, qn, qn],
                                        @"notes":@[@2, @1, @0, @1, @2, @2, @2, @1, @1, @1, @2, @4, @4, @2, @1,  @0, @1, @2, @2, @2, @2, @1, @1, @2, @1, @0]
                                        };
        [fullSongsList addObject:maryHadALittleLambFullArray];
        
        muffinManFullArray = @{
                               @"tempo":@[qn,qn,qn,dqn,en,qn,qn,dqn,en,qn,qn,dqn,en,qn,qn,hn,qn,qn,dqn,en,qn,qn,qn,qn,qn,qn,qn,qn],
                               @"notes":@[@0,@3,@3,@4,@5,@3,@3,@2,@1,@4,@4,@3,@2,@0,@0,@0,@3,@3,@4,@5,@3,@3,@3,@4,@4,@0,@0,@3]
                               };
        [fullSongsList addObject:muffinManFullArray];
        
        oldMacDonaldFullArray = @{
                                  @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, dhn, qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, dhn, en, en, qn, qn, qn, en, en, qn, qn, hn, en, en, qn, en, en, qn, en, en, en, en, qn, qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn],
                                  @"notes":@[@3, @3, @3, @0, @1, @1, @0, @5, @5, @4, @4, @3, @0, @3, @3, @3, @0, @1, @1, @0, @5, @5, @4, @4, @3, @0, @0, @3, @3, @3, @0, @0, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @3, @0, @1, @1, @0, @5, @5, @4, @4, @3]
                                  };
        [fullSongsList addObject:oldMacDonaldFullArray];
        
        ringAroundTheRosyFullArray = @{
                                       @"tempo":@[qn,qn,en,qn,en,dqn,qn,en,qn,en,qn,en,dqn,dqn,dqn,dqn,dqn,qn,en,dqn,dqn],
                                       @"notes":@[@4,@4,@2,@5,@4,@2,@3,@4,@4,@2,@5,@4,@2,@3,@1,@3,@1,@1,@4,@4,@0]
                                       };
        [fullSongsList addObject:ringAroundTheRosyFullArray];
        
        rowRowRowFullArray = @{
                               @"tempo":@[qn, dqn, dqn, qn, en, dqn, qn, en, qn, en, dhn, en, en, en, en, en, en, en, en, en, en, en, en, qn, en, qn, en],
                               @"notes":@[@0, @0, @0, @1, @2, @2, @1, @2, @3, @4, @7, @7, @7, @4, @4, @4, @2, @2, @2, @0, @0, @0, @4, @3, @2, @1, @0]
                               };
        [fullSongsList addObject:rowRowRowFullArray];
        
        thisOldManFullArray = @{
                                @"tempo":@[qn,qn,qn,hn,qn,qn,hn,qn,qn,qn,qn,qn,qn,qn,en,en,qn,qn,en,en,qn,en,en,en,en,hn,qn,qn,qn,qn,qn,qn],
                                @"notes":@[@4,@2,@4,@4,@2,@4,@5,@4,@3,@2,@1,@2,@3,@2,@3,@4,@0,@0,@0,@0,@0,@1,@2,@3,@4,@4,@1,@1,@3,@2,@1,@0]
                                };
        [fullSongsList addObject:thisOldManFullArray];
        
        threeBlindMiceFullArray = @{
                                    @"tempo":@[qn,dqn,dqn,dhn,dqn,dqn,dhn,dqn,qn,en,dhn,dqn,qn,en,dhn,en,qn,en,en,en,en,qn,en,qn,en,qn,en,en,en,en,qn,en,qn,en,qn,en,en,en,en,qn,en,qn,en,dqn,dqn,dhn,dqn,dqn],
                                    @"notes":@[@2,@1,@0,@2,@1,@0,@4,@3,@3,@2,@4,@3,@3,@2,@4,@7,@7,@6,@5,@6,@7,@4,@4,@4,@7,@7,@6,@5,@6,@7,@4,@4,@4,@7,@7,@6,@5,@6,@7,@4,@4,@3,@2,@1,@0,@2,@1,@0]
                                    };
        [fullSongsList addObject:threeBlindMiceFullArray];
        
        twinkleTwinkleFullArray = @{
                                    @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn],
                                    @"notes":@[@0, @0, @4, @4, @5, @5, @4, @3, @3, @2, @2, @1, @1, @0, @4, @4,@3, @3, @2, @2, @1, @4, @4, @3, @3, @2, @2, @1, @0, @0, @4, @4, @5, @5,   @4, @3, @3, @2, @2, @1, @1, @0]
                                    };
        [fullSongsList addObject:twinkleTwinkleFullArray];
        
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
    
    aTisketATasketGameArray = @{
                                @"tempo":@[qn,en,dqn,qn,en,dqn,qn,en,qn,en,qn,en,dqn],
                                @"notes":@[@5,@4,@2,@5,@4,@2,@3,@4,@4,@2,@5,@4,@2]
                                };
    [gameSongsList addObject:aTisketATasketGameArray];
    
    goodMorningToYouGameArray = @{
                                  @"tempo":@[qn,qn,qn,qn,qn,hn,qn,qn,qn,qn],
                                  @"notes":@[@0,@1,@0,@3,@2,@0,@1,@0,@4,@3]
                                  };
    [gameSongsList addObject:goodMorningToYouGameArray];
    
    hickoryDickoryDockGameArray = @{
                                    @"tempo":@[qn,en,en,en,en,en,en,dhn,en,qn,en,qn,en],
                                    @"notes":@[@2,@3,@4,@3,@2,@1,@2,@2,@2,@4,@3,@1,@2]
                                    };
    [gameSongsList addObject:hickoryDickoryDockGameArray];
    
    itsRainingItsPouringGameArray = @{
                                      @"tempo":@[qn,qn,hn,qn,qn,hn,qn,qn,qn,qn,qn,qn,hn],
                                      @"notes":@[@5,@4,@2,@5,@4,@2,@3,@4,@4,@2,@5,@4,@2]
                                      };
    [gameSongsList addObject:itsRainingItsPouringGameArray];
    
    lightlyRowGameArray = @{
                            @"tempo":@[qn,qn,qn,hn,qn,qn,hn,qn,qn,qn,qn,qn,qn],
                            @"notes":@[@4,@2,@2,@3,@1,@1,@0,@1,@2,@3,@4,@4,@4]
                            };
    [gameSongsList addObject:lightlyRowGameArray];
    
    londonBridgeGameArray = @{
                              @"tempo":@[qn,dqn,en,qn,qn,qn,qn,hn,qn,qn,hn,qn,qn],
                              @"notes":@[@4,@5,@4,@3,@2,@3,@4,@1,@2,@3,@2,@3,@4]
                              };
    [gameSongsList addObject:londonBridgeGameArray];
    
    maryHadALittleLambGameArray = @{
                                    @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, hn, qn, qn],
                                    @"notes":@[@2, @1, @0, @1, @2, @2, @2, @1, @1, @1, @2, @4, @4]
                                    };
    [gameSongsList addObject:maryHadALittleLambGameArray];
    
    muffinManGameArray = @{
                           @"tempo":@[qn,qn,qn,dqn,en,qn,qn,dqn,en,qn,qn,dqn,en,qn,qn],
                           @"notes":@[@0,@3,@3,@4,@5,@3,@3,@2,@1,@4,@4,@3,@2,@0,@0]
                           };
    [gameSongsList addObject:muffinManGameArray];
    
    oldMacDonaldGameArray = @{
                              @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn],
                              @"notes":@[@3, @3, @3, @0, @1, @1, @0, @5, @5, @4, @4, @3]
                              };
    [gameSongsList addObject:oldMacDonaldGameArray];
    
    ringAroundTheRosyGameArray = @{
                                   @"tempo":@[qn,qn,en,qn,en,dqn,qn,en,qn,en,qn,en,dqn],
                                   @"notes":@[@4,@4,@2,@5,@4,@2,@3,@4,@4,@2,@5,@4,@2]
                                   };
    [gameSongsList addObject:ringAroundTheRosyGameArray];
    
    rowRowRowGameArray = @{
                           @"tempo":@[qn, dqn, dqn, qn, en, dqn, qn, en, qn, en],
                           @"notes":@[@0, @0, @0, @1, @2, @2, @1, @2, @3, @4]
                           };
    [gameSongsList addObject:rowRowRowGameArray];
    
    thisOldManGameArray = @{
                            @"tempo":@[qn,qn,qn,hn,qn,qn,hn,qn,qn,qn,qn,qn,qn],
                            @"notes":@[@4,@2,@4,@4,@2,@4,@5,@4,@3,@2,@1,@2,@3]
                            };
    [gameSongsList addObject:thisOldManGameArray];
    
    threeBlindMiceGameArray = @{
                                @"tempo":@[qn,dqn,dqn,dhn,dqn,dqn,dhn,dqn,qn,en,dhn,dqn,qn,en],
                                @"notes":@[@2,@1,@0,@2,@1,@0,@4,@3,@3,@2,@4,@3,@3,@2]
                                };
    [gameSongsList addObject:threeBlindMiceGameArray];
    
    twinkleTwinkleGameArray = @{
                                @"tempo":@[qn, qn, qn, qn, qn, qn, qn, hn, qn, qn, qn, qn, qn, qn],
                                @"notes":@[@0, @0, @4, @4, @5, @5, @4, @3, @3, @2, @2, @1, @1, @0]
                                };
    [gameSongsList addObject:twinkleTwinkleGameArray];
    
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
//    cLabel.text = @"DO";
    cLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    cLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    cLabel.textAlignment = 1;
    cLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:cLabel];
    
    dLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*1+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    dLabel.layer.cornerRadius = circleWidth/2;
    dLabel.layer.masksToBounds = YES;
//    dLabel.text = @"RE";
    dLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    dLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    dLabel.textAlignment = 1;
    dLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:dLabel];
    
    eLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*2+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    eLabel.layer.cornerRadius = circleWidth/2;
    eLabel.layer.masksToBounds = YES;
//    eLabel.text = @"MI";
    eLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    eLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    eLabel.textAlignment = 1;
    eLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:eLabel];
    
    fLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*3+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    fLabel.layer.cornerRadius = circleWidth/2;
    fLabel.layer.masksToBounds = YES;
//    fLabel.text = @"FA";
    fLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    fLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    fLabel.textAlignment = 1;
    fLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:fLabel];
    
    gLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*4+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    gLabel.layer.cornerRadius = circleWidth/2;
    gLabel.layer.masksToBounds = YES;
//    gLabel.text = @"SO";
    gLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    gLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    gLabel.textAlignment = 1;
    gLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:gLabel];
    
    aLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*5+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    aLabel.layer.cornerRadius = circleWidth/2;
    aLabel.layer.masksToBounds = YES;
//    aLabel.text = @"LA";
    aLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    aLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    aLabel.textAlignment = 1;
    aLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:aLabel];
    
    bLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*6+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    bLabel.layer.cornerRadius = circleWidth/2;
    bLabel.layer.masksToBounds = YES;
//    bLabel.text = @"TI";
    bLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    bLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    bLabel.textAlignment = 1;
    bLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    [self.view addSubview:bLabel];
    
    c2Label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*7+5, SCREEN_HEIGHT * 0.7, circleWidth, circleWidth)];
    c2Label.layer.cornerRadius = circleWidth/2;
    c2Label.layer.masksToBounds = YES;
//    c2Label.text = @"DO";
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
    if (self.gameOn) {
        [stopButton removeFromSuperview];
        [songsTableHeaderView removeFromSuperview];
        [instTableHeaderView removeFromSuperview];
        return;
    }
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
    self.isPlaying = YES;
    if (self.stopPlaying) {
        return;
    }
    if (self.gameOn) {
        [stopButton removeFromSuperview];
        [songsTableHeaderView removeFromSuperview];
        return;
    }else{
    
        int y = [currentSong[@"tempo"][note] intValue];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            int x = [currentSong[@"notes"][note] intValue];
            [player playSoundWithName:notes[instrument][x]];
            [self glowKey:x];
            
            if([currentSong[@"notes"] count] - 1 > note)
            {
                [self playSong:currentSong withNote:note + 1];
            }else{
                [stopButton removeFromSuperview];
                [headerFrame addSubview:songsTableHeaderView];
                [headerFrame addSubview:songsButton];
                [headerFrame addSubview:instTableHeaderView];
                [headerFrame addSubview:instButton];
                self.isPlaying = NO;
            }
        });
    }
}

-(void)prePlaySongGame:(int)indexOfGameSongslist
{
    if (self.gameOn == NO) {
        return;
    }
    score = 0;
    NSDictionary *currentSong = gameSongsList[indexOfGameSongslist];
    self.playlength++;
    
    if (self.currentTempo > 0.2) {
        self.currentTempo = self.currentTempo - 0.049;
    }
    [self setGameSongTempos:self.currentTempo];
    
    if (self.playlength > [currentSong[@"notes"]count])
    {
        self.gameOn = NO;
        [self setGameSongTempos:0.9];
        [self playRewardSong:0];
        [displayWindow removeFromSuperview];
        [headerFrame addSubview:settingsView];
        [headerFrame addSubview:settingsButton];
       // NSLog(@"%@", [self.titleItems[1]objectForKey:@"locked"]);
        if ([[self.titleItems[indexOfGameSongslist]objectForKey:@"locked"] isEqualToString: @"Yes"]) {
            [self.titleItems[indexOfGameSongslist] removeObjectForKey:@"locked"];
            [self rewardDisplay:1000 withIndex:indexOfGameSongslist];
        }else{
            [self rewardDisplay:0 withIndex:0];
        }
        
        return;
    }
    [self playSongGame:(NSDictionary *)currentSong withNote:0];
}

- (void)playSongGame:(NSDictionary *)currentSong withNote:(int)note
{
    if (self.gameOn == NO) {
        return;
    }
    int y = [currentSong[@"tempo"][note] intValue];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            int x = [currentSong[@"notes"][note] intValue];
            [player playSoundWithName:notes[instrument][x]];
            [tempSongNotesArray addObject:notes[instrument][x]];
            [self glowKey:x];
            
        if(note < self.playlength-1)
        {
            [self playSongGame:currentSong withNote:note + 1];
        }
    });
}

-(void)prePlayRandomNoteGame
{
    if (self.gameOn == NO) {
        return;
    }
    NSNumber * randomNumber;
    if (self.expertMode) {
         randomNumber = [NSNumber numberWithInt:arc4random_uniform(13)];
    }else{
        randomNumber = [NSNumber numberWithInt:arc4random_uniform(7)];
    }
    
    NSMutableArray* currentNotes = randomNotesDict[@"notes"];
    currentNotes[[currentNotes count]] = randomNumber;
    
    score = 0;
    NSDictionary *currentSong = randomNotesDict;
    
    self.playlength++;

    if (self.currentTempo > 0.25) {
        self.currentTempo = self.currentTempo - 0.049;
    }
    NSLog(@"%f", self.currentTempo);

    [self setGameSongTempos:self.currentTempo];


    [self playRandomNoteGame:(NSDictionary *)currentSong withNote:0];
}

- (void)playRandomNoteGame:(NSDictionary *)currentSong withNote:(int)note
{
    if (self.gameOn == NO) {
        return;
    }
    int y = [currentSong[@"tempo"] intValue];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, y * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        int x = [currentSong[@"notes"][note] intValue];
        [player playSoundWithName:notes[instrument][x]];
        [tempSongNotesArray addObject:notes[instrument][x]];
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
    //if song is playing..
    if (self.isPlaying) {
        
        //stop playing and run this method again.
        if (self.isPlaying) {
            self.isPlaying = NO;
            self.gameOn = YES;
            [songsButton removeFromSuperview];
            [stopButton removeFromSuperview];
            [songsTableHeaderView removeFromSuperview];
            [instButton removeFromSuperview];
            [instTableHeaderView removeFromSuperview];
            [self closeInstTableView];
            [settingsButton removeFromSuperview];
            [settingsView removeFromSuperview];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 600 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                [self startGame];
                });
            }
            //self.isPlaying = NO;
        
        }else{
            
            // if song table is open, close it
            if (songTableView.frame.size.height > 100) {
                [self closeSongTableView];
                }
            if (instTableView.frame.size.height > 100) {
                [self closeInstTableView];
            }
            self.gameOn = YES;
            randomNotesDict = [@{
                                 @"tempo":@[],
                                 @"notes":[@[] mutableCopy]
                                 }mutableCopy];
            
            [headerFrame addSubview:displayWindow];
            displayWindow.text = [NSString stringWithFormat:@"0"];
            
            [songsButton removeFromSuperview];
            [stopButton removeFromSuperview];
            [songsTableHeaderView removeFromSuperview];
            [instButton removeFromSuperview];
            [instTableHeaderView removeFromSuperview];
            [settingsButton removeFromSuperview];
            [settingsView removeFromSuperview];
            
            self.currentTempo = 0.9;

            self.playlength = 0;
            [tempSongNotesArray removeAllObjects];
            noteCount = 0;
        
            // if game is in random mode
        if (self.randomMode) {
            maxScore = 0;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                [self prePlayRandomNoteGame];
            });
        }else{
            
            //if game is in song mode
            int songNumber = (int)[gameSongsList count];
            self.songSelector = arc4random_uniform(songNumber);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                [self prePlaySongGame:self.songSelector];
            });
        }
    }
}

- (void)playGame:(UIButton *)sender
{
    if (self.gameOn){
        if (noteCount == [tempSongNotesArray count]) {
            self.gameOn = NO;
            [self endGame];
            NSLog(@"END");
            return;
            }else{
            if (notes[instrument][sender.tag] == tempSongNotesArray[noteCount]){
                score++;
                displayWindow.text = [NSString stringWithFormat:@"%d", score];
                if (score > maxScore) {
                    maxScore = score;
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
                [self endGame];
            }
        }
    }
}
-(void)endGame
{
    if (self.randomMode) {
        displayWindow.text = @"0";
        [displayWindow removeFromSuperview];
        [self rewardDisplay:maxScore withIndex:0];
        [self playRewardSong:0];
        [headerFrame addSubview:settingsView];
        [headerFrame addSubview:settingsButton];
        return;
    }
    self.gameOn = NO;
    [self playRewardSong:1];
    [displayWindow removeFromSuperview];
    [headerFrame addSubview:songsTableHeaderView];
    [headerFrame addSubview:songsButton];
    [headerFrame addSubview:instTableHeaderView];
    [headerFrame addSubview:instButton];
    [headerFrame addSubview:settingsView];
    [headerFrame addSubview:settingsButton];
    
    UIView * rewardDisplayView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-50, SCREEN_WIDTH, 100)];
    rewardDisplayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rewardDisplayView];
    
    UILabel * rewardDisplayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, rewardDisplayView.frame.size.height)];
    rewardDisplayLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    rewardDisplayLabel.text = @"Try Again!";
    rewardDisplayLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    rewardDisplayLabel.textAlignment = 1;
    [rewardDisplayView addSubview:rewardDisplayLabel];
    
    [UIView animateWithDuration:3.0 animations:^{
        rewardDisplayView.frame = CGRectMake(0, SCREEN_HEIGHT/2-125, SCREEN_WIDTH, 100);
        rewardDisplayView.alpha = 0;
    }completion:^(BOOL finished) {
        [rewardDisplayView removeFromSuperview];
    }];
    
    return;
}

- (void)loadInst:(int)indexOfInstList
{
    instrument = instrumentList[indexOfInstList];
    
    if (indexOfInstList == 0) {
        notes = @{
                  instrument:@[@"cNote", @"dNote", @"eNote", @"fNote", @"gNote", @"aNote", @"bNote", @"c2Note", @"csNote", @"dsNote", @"fsNote", @"gsNote", @"asNote", @"cs2Note"]
                  };
    }else if (indexOfInstList == 1) {
        notes = @{
                  instrument:@[@"cPiano4", @"dPiano4", @"ePiano4", @"fPiano4", @"gPiano4", @"aPiano4", @"bPiano4", @"c2Piano4", @"csPiano4", @"dsPiano4", @"fsPiano4", @"gsPiano4", @"asPiano4", @"cs2Piano4"]
                  };
    }else if (indexOfInstList == 2) {
        notes = @{
                  instrument:@[@"cPiano5", @"dPiano5", @"ePiano5", @"fPiano5", @"gPiano5", @"aPiano5", @"bPiano5", @"c2Piano5", @"csPiano5", @"dsPiano5", @"fsPiano5", @"gsPiano5", @"asPiano5", @"cs2Piano5"]
                  };
    }else if (indexOfInstList == 3) {
        notes = @{
                  instrument:@[@"cMarimba", @"dMarimba", @"eMarimba", @"fMarimba", @"gMarimba", @"aMarimba", @"bMarimba", @"c2Marimba", @"csMarimba", @"dsMarimba", @"fsMarimba", @"gsMarimba", @"asMarimba", @"cs2Marimba"]
                  };
    }else if (indexOfInstList == 4) {
        notes = @{
                  instrument:@[@"cXylo", @"dXylo", @"eXylo", @"fXylo", @"gXylo", @"aXylo", @"bXylo", @"c2Xylo", @"csXylo", @"dsXylo", @"fsXylo", @"gsXylo", @"asXylo", @"cs2Xylo"]
                  };
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSNumber numberWithInteger:indexOfInstList] forKey:@"instrument"];
	[defaults synchronize];
}

-(void)openSongList
{
    [songsButton removeFromSuperview];
    [self.view addSubview:closeSongTableButton];
    songTableView.frame = CGRectMake(SCREEN_WIDTH * .05, 30, 200, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
        songsTableHeaderView.frame = CGRectMake(SCREEN_WIDTH * .05, 5, 200, 25);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            songTableView.frame = CGRectMake(SCREEN_WIDTH * .05, 30, 200, SCREEN_HEIGHT-40);
        }completion:^(BOOL finished) {
        }];
    }];
}

-(void)openInstList
{
    [instButton removeFromSuperview];
    [self.view addSubview:closeInstTableButton];
  //  songTableView.frame = CGRectMake(SCREEN_WIDTH/2-55, 30, 200, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
        instTableHeaderView.frame = CGRectMake(SCREEN_WIDTH/2-55, 5, 200, 25);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            instTableView.frame = CGRectMake(SCREEN_WIDTH/2-55, 30, 200, 200);
        }completion:^(BOOL finished) {
        }];
    }];
}

-(void)closeSongTableView
{
    self.stopPlaying = NO;
    [closeSongTableButton removeFromSuperview];
    if (songTableView.frame.size.height > 100 && self.isPlaying) {
        [headerFrame addSubview:stopButton];
    }else{
        [headerFrame addSubview:songsTableHeaderView];
        [headerFrame addSubview:songsButton];
    }
    [UIView animateWithDuration:0.2 animations:^{
        songTableView.frame = CGRectMake(SCREEN_WIDTH * .05, 30, 200, 0);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            songsTableHeaderView.frame = CGRectMake(SCREEN_WIDTH * .05, 5, 60, 20);
        }completion:^(BOOL finished) {
        }];
    }];
}

-(void)closeInstTableView
{
    [closeInstTableButton removeFromSuperview];
    if (self.gameOn == NO) {
        [headerFrame addSubview:instTableHeaderView];
        [headerFrame addSubview:instButton];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        instTableView.frame = CGRectMake(SCREEN_WIDTH/2-55, 30, 200, 0);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            instTableHeaderView.frame = CGRectMake(SCREEN_WIDTH/2-55, 5, 110, 20);
        }completion:^(BOOL finished) {
        }];
    }];
}

-(void)openSettingsPage
{
    [self closeSongTableView];
    [self closeInstTableView];
    [songsButton removeFromSuperview];
    [stopButton removeFromSuperview];
    [instButton removeFromSuperview];

    [UIView animateWithDuration:0.4 animations:^{
        [startButton removeFromSuperview];
        [startButtonFrame removeFromSuperview];
        [songsTableHeaderView removeFromSuperview];
        [instButton removeFromSuperview];
        [instTableHeaderView removeFromSuperview];
        [displayWindow removeFromSuperview];
        [songsButton removeFromSuperview];
        settingsPage.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        [settingsView removeFromSuperview];
        [settingsButton removeFromSuperview];
        [self.view addSubview:xView];
        [self.view addSubview:xButton];
        [settingsPage addSubview:keyLabelSegmentedControl];
        [settingsPage addSubview:randomModeSegmentedControl];
        [settingsPage addSubview:expertModeSegmentedControl];
    }];
}

-(void)closeSettingsPage
{
    [UIView animateWithDuration:0.2 animations:^{
        settingsPage.frame =  CGRectMake(0, 0-SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        [xView removeFromSuperview];
        [xButton removeFromSuperview];
        [headerFrame addSubview:songsTableHeaderView];
        [headerFrame addSubview:startButtonFrame];
        [headerFrame addSubview:instTableHeaderView];
        [headerFrame addSubview:instButton];
        [headerFrame addSubview:settingsView];
        [headerFrame addSubview:settingsButton];
        [headerFrame addSubview:songsButton];
        [startButtonFrame addSubview:startButton];
        if (self.gameOn) {
            [headerFrame addSubview:displayWindow];
            [stopButton removeFromSuperview];
            [songsButton removeFromSuperview];
            [songsTableHeaderView removeFromSuperview];
            [instButton removeFromSuperview];
            [instTableHeaderView removeFromSuperview];
        }
    }];
}

-(void)stopSong
{
    self.stopPlaying = YES;
    [stopButton removeFromSuperview];
    [self.view addSubview:songsButton];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 800 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        self.stopPlaying = NO;
        NSLog(@"PLAYON");
    });
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
    
    [player playSoundWithName:notes[instrument][sender.tag]];
    
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
    [cLabel setAlpha:1.0];
    [dLabel setAlpha:1.0];
    [eLabel setAlpha:1.0];
    [fLabel setAlpha:1.0];
    [gLabel setAlpha:1.0];
    [aLabel setAlpha:1.0];
    [bLabel setAlpha:1.0];
    [c2Label setAlpha:1.0];
    
    cLabel.text = @"DO";
    dLabel.text = @"RE";
    eLabel.text = @"MI";
    fLabel.text = @"FA";
    gLabel.text = @"SO";
    aLabel.text = @"LA";
    bLabel.text = @"TI";
    c2Label.text = @"DO";
}

-(void)addkeyNameLabels
{
    [cLabel setAlpha:1.0];
    [dLabel setAlpha:1.0];
    [eLabel setAlpha:1.0];
    [fLabel setAlpha:1.0];
    [gLabel setAlpha:1.0];
    [aLabel setAlpha:1.0];
    [bLabel setAlpha:1.0];
    [c2Label setAlpha:1.0];
    
    cLabel.text = @"C";
    dLabel.text = @"D";
    eLabel.text = @"E";
    fLabel.text = @"F";
    gLabel.text = @"G";
    aLabel.text = @"A";
    bLabel.text = @"B";
    c2Label.text = @"C";
}

-(void)removeLabels
{
    [cLabel setAlpha:0.0];
    [dLabel setAlpha:0.0];
    [eLabel setAlpha:0.0];
    [fLabel setAlpha:0.0];
    [gLabel setAlpha:0.0];
    [aLabel setAlpha:0.0];
    [bLabel setAlpha:0.0];
    [c2Label setAlpha:0.0];
}

-(void) labelKeys:(id)sender{
    if (self.expertMode == NO) {
        UISegmentedControl *control = (UISegmentedControl *)sender;
        NSString * label = [control titleForSegmentAtIndex: [control selectedSegmentIndex]];
        if ([label  isEqual: @"Do-Re-Mi"]) {
            [self addSolfegeLabels];
        }else{
            [self addkeyNameLabels];
        }
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSNumber numberWithInteger:[keyLabelSegmentedControl selectedSegmentIndex]] forKey:@"keyLabel"];
	[defaults synchronize];
}

-(void) setGameMode:(id)sender{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    NSString * label = [control titleForSegmentAtIndex: [control selectedSegmentIndex]];
    if ([label  isEqual: @"Random Notes"]) {
        self.randomMode = YES;
    }else if ([label  isEqual: @"Songs"]){
        self.randomMode = NO;
    }
    if ([label  isEqual: @"On"]) {
        self.expertMode = YES;
        [self removeLabels];
    }else if([label  isEqual: @"Off"]){
        self.expertMode = NO;
        [self labelKeys:keyLabelSegmentedControl];
        
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInteger:[expertModeSegmentedControl selectedSegmentIndex]] forKey:@"expertMode"];
	[defaults setObject:[NSNumber numberWithInteger:[randomModeSegmentedControl selectedSegmentIndex]] forKey:@"randomMode"];
	[defaults synchronize];
}

-(void)rewardDisplay:(int)totalScore withIndex:(int)indexOfGameSongslist
{
    [headerFrame addSubview:songsTableHeaderView];
    [headerFrame addSubview:songsButton];
    [headerFrame addSubview:instTableHeaderView];
    [headerFrame addSubview:instButton];
    self.gameOn = NO;
    
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
    }else if (totalScore == 1000)
    {
        rewardDisplayLabel.text = @"YOU'VE UNLOCKED A NEW SONG!";
        [self.titleItems[indexOfGameSongslist] setObject:@"No" forKey:@"locked"];
        [self saveData];
    }else{
        rewardDisplayLabel.text = @"PERFECT!";
    }
    
    [UIView animateWithDuration:2.5 animations:^{
        rewardDisplayView.frame = CGRectMake(0, SCREEN_HEIGHT/2-125, SCREEN_WIDTH, 100);
        rewardDisplayView.alpha = 0;
    }completion:^(BOOL finished) {
        [rewardDisplayView removeFromSuperview];
    }];
}


#pragma mark UITableViewDelegate



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == songTableView)
    {
        return [self.titleItems count];

    }else if(tableView == instTableView)
    {
        return 5;
    }
    else return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == songTableView)
    {
        PSSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[PSSTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        UIView *selectionColor = [[UIView alloc] init];
        selectionColor.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = selectionColor;

        cell.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.2];
        cell.layer.cornerRadius = 5;
        cell.imageView.frame = CGRectMake(10, 10, 200, 20);
        
        cell.songInfo = self.titleItems[indexPath.row];
        
        return cell;
        
    }else if(tableView == instTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        cell.textLabel.text = instrumentList[indexPath.row];
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
    }else{
    return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == songTableView)
    {
        if([self.titleItems[indexPath.row][@"locked"] isEqual: @"No"])
        {
            self.isPlaying = YES;
            
            int selectedSong = (int)indexPath.row;

            [self closeSongTableView];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 500 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                [self playFullSong:selectedSong];
            });
        }else{
            return;
        }
    }else if(tableView == instTableView)
    {
        self.isPlaying = YES;
        
        int selectedInst = (int)indexPath.row;
        
        [self loadInst:selectedInst];
        
        [self closeInstTableView];
        
    }
}

- (void)saveData{
    NSString * path = [self listArchivePath];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.titleItems];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}

-(NSString *)listArchivePath{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = documentDirectories[0];
    return [documentDirectory stringByAppendingPathComponent:@"listdata.data"];
}

- (void) loadListItems{
    NSString * path = [self listArchivePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        self.titleItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
