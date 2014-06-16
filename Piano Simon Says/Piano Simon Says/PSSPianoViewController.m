//
//  PSSPianoViewController.m
//  Piano Says
//
//  Created by Jonathan Fox on 5/25/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSPianoViewController.h"
#import "PSSPlayer.h"
#import "PSSPianoTableView.h"
#import "PSSTableViewCell.h"
#import "PSSInstTableView.h"
#import "PSSBlackDot.h"
#import "PSSxView.h"
#import <Crashlytics/Crashlytics.h>
#import <Accelerate/Accelerate.h>

@interface PSSPianoViewController () 

@property (nonatomic) int playlength;
@property (nonatomic) int songSelector;

@property (nonatomic) BOOL gameOn;
@property (nonatomic) BOOL randomMode;
@property (nonatomic) BOOL expertMode;
@property (nonatomic) BOOL proMode;
@property (nonatomic) BOOL stopPlaying;
@property (nonatomic) BOOL isPlaying;

@property (nonatomic) float currentTempo;

@property (nonatomic) NSMutableArray * touchArray1;
@property (nonatomic) NSMutableArray * touchArray2;
@property (nonatomic) NSMutableArray * touchArray3;

@property (nonatomic) NSMutableArray * touchCount;

@property(nonatomic, getter=isMultipleTouchEnabled) BOOL multipleTouchEnabled;

@end

@implementation PSSPianoViewController
{
    UIView * cKey;
    UIView * csKey;
    UIView * dKey;
    UIView * dsKey;
    UIView * eKey;
    UIView * fKey;
    UIView * fsKey;
    UIView * gKey;
    UIView * gsKey;
    UIView * aKey;
    UIView * asKey;
    UIView * bKey;
    UIView * c2Key;
    UIView * cs2Key;
    UIView * cKeyBottomLayer;
    UIView * dKeyBottomLayer;
    UIView * eKeyBottomLayer;
    UIView * fKeyBottomLayer;
    UIView * gKeyBottomLayer;
    UIView * aKeyBottomLayer;
    UIView * bKeyBottomLayer;
    UIView * c2KeyBottomLayer;
    
    UIView * headerView;
    
    UIButton * startButton;
    UIButton * stopButton;
    UIButton * songsButton;
    UIButton * instButton;
    UIButton * closeSongTableButton;
    UIButton * closeInstTableButton;

    UILabel * cLabel;
    UILabel * dLabel;
    UILabel * eLabel;
    UILabel * fLabel;
    UILabel * gLabel;
    UILabel * aLabel;
    UILabel * bLabel;
    UILabel * c2Label;
    UILabel * displayWindow;
    UILabel * scoreLabel;
    UILabel * titleLabel;
    
    UIView * circlesView;
    
    int noteCount;
    int score;
    int maxScore;
    float keyWidth;
    
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
    
    PSSBlackDot * blackDot1;
    PSSBlackDot * blackDot2;
    PSSBlackDot * blackDot3;
    PSSBlackDot * blackDot4;
    PSSBlackDot * blackDot5;
    PSSBlackDot * blackDot6;
    UIButton * settingsButton;
    PSSxView * xView;
    UIButton * xButton;
    
    NSString * instrument;
    
    UISegmentedControl * keyLabelSegmentedControl;
    UISegmentedControl * gameModeSegmentedControl;
    UISegmentedControl * expertModeSegmentedControl;
    UISegmentedControl * proModeSegmentedControl;

    NSDictionary * rewardSequenceArray;
    NSDictionary * endGameSequenceArray;
    NSDictionary * notes;
    NSMutableDictionary * randomNotesDict;

    //SONGS
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
    
    UITouch *finger1;
    UITouch *finger2;
    UITouch *finger3;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.multipleTouchEnabled = YES;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        keyWidth = (SCREEN_WIDTH-22)/8;
        
        self.touchArray1 = [@[]mutableCopy];
        self.touchArray2 = [@[@100]mutableCopy];
        self.touchArray3 = [@[@100]mutableCopy];
        self.touchCount = [@[]mutableCopy];
        
        self.currentTempo = 0.9;

        self.view.backgroundColor = [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f];
        
        self.gameOn = NO;
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 5, 200, 24)];
        titleLabel.text = @"piano ♪ says";
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-thin" size:22];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = 1;
        [self.view addSubview:titleLabel];
        
        settingsPage = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH*.40, SCREEN_HEIGHT)];
        settingsPage.clipsToBounds = YES;
        settingsPage.alpha = 1;
        UIImageView *settingsBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*.40, SCREEN_HEIGHT)];
        settingsBackground.image = [self blurView];
        [settingsPage addSubview:settingsBackground];
 
        
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [self.view addSubview:headerView];
        
        
        if (SCREEN_WIDTH < 500) {
            settingsButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .86, 0, 70, 40)];
        }else{
            settingsButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * .87, 0, 70, 40)];
        }
        [settingsButton addTarget:self action:@selector(openSettingsPage) forControlEvents:UIControlEventTouchUpInside];
        settingsButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        [settingsButton setTitle:@"settings" forState:UIControlStateNormal];
        [headerView addSubview:settingsButton];
        
        xView = [[PSSxView alloc]initWithFrame:CGRectMake(settingsPage.frame.size.width*.81, 0, 40, 40)];
        xView.backgroundColor = [UIColor clearColor];
        
        xButton = [[UIButton alloc]initWithFrame:CGRectMake(-5, -5, 40, 40)];
        [xButton addTarget:self action:@selector(closeSettingsPage) forControlEvents:UIControlEventTouchUpInside];
        
        if (SCREEN_WIDTH < 500) {
            songsButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.74, 0, 60, 40)];
        }else{
            songsButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.77, 0, 60, 40)];
        }
        songsButton.titleLabel.textColor = [UIColor whiteColor];
        songsButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        [songsButton setTitle:@"songs" forState:UIControlStateNormal];
        songsButton.backgroundColor = [UIColor clearColor];
        [songsButton addTarget:self action:@selector(openSongList) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:songsButton];
        
        if (SCREEN_WIDTH < 500) {
            instButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.095, 0, 90, 40)];
        }else{
            instButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.095, 0, 90, 40)];
        }
        instButton.layer.cornerRadius = 5;
        instButton.titleLabel.textColor = [UIColor whiteColor];
        instButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        [instButton setTitle:@"instruments" forState:UIControlStateNormal];
        instButton.backgroundColor = [UIColor clearColor];
        [instButton addTarget:self action:@selector(openInstList) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:instButton];
        
        if (SCREEN_WIDTH < 500) {
            stopButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.74, 0, 60, 40)];
        }else{
            stopButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.77, 0, 60, 40)];
        }
        stopButton.layer.cornerRadius = 5;
        stopButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        [stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [stopButton setTitle:@"stop" forState:UIControlStateNormal];
        stopButton.backgroundColor = [UIColor clearColor];
        [stopButton addTarget:self action:@selector(stopSong) forControlEvents:UIControlEventTouchUpInside];
        
        if (SCREEN_WIDTH < 500) {
            startButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * -0.005,0, 50, 40)];
        }else{
            startButton = [[UIButton alloc]initWithFrame:CGRectMake(4,0, 50, 40)];
        }
        startButton.layer.cornerRadius = 5;
        startButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        [startButton setTitle:@"start" forState:UIControlStateNormal];
        [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:startButton];
        
        if (SCREEN_WIDTH < 500) {
            scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.74, 0, 60, 40)];
        }else{
            scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.77, 0, 60, 40)];
        }
        scoreLabel.text = @"score: ";
        scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.textAlignment = 1;
        
        circlesView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 40)];
        [self.view addSubview:circlesView];
        
        songsTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH*.40, 40)];
        songsTableHeaderView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        [self.view addSubview:songsTableHeaderView];
        
        songTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        songTableView.dataSource = self;
        songTableView.delegate = self;
        songTableView.rowHeight = 40;
        songTableView.backgroundColor = [UIColor clearColor];
        songTableView.frame = CGRectMake(SCREEN_WIDTH, 40, SCREEN_WIDTH*.40, SCREEN_HEIGHT-40);
        songTableView.SeparatorColor = [UIColor blackColor];
        songTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        songTableView.clipsToBounds = YES;
        songTableView.alpha = 1;
        
        UIImageView *songTablebackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*.40, SCREEN_HEIGHT)];
        songTablebackground.image = [self blurView];
        
        [songsTableHeaderView addSubview:songTablebackground];
        
        [self.view addSubview:songTableView];
        
        instTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(-210,0, 210, 40)];
        instTableHeaderView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        [self.view addSubview:instTableHeaderView];
        
        instTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        instTableView.dataSource = self;
        instTableView.delegate = self;
        instTableView.rowHeight = 40;
        instTableView.backgroundColor = [UIColor clearColor];
        instTableView.frame = CGRectMake(-210,40, 210, SCREEN_HEIGHT-40);
        instTableView.SeparatorColor = [UIColor blackColor];
        instTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        instTableView.clipsToBounds = YES;
        instTableView.alpha = 1;
        
        UIImageView *tableViewbackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210, SCREEN_HEIGHT)];
        tableViewbackground.image = [self blurView];
        
        [instTableHeaderView addSubview:tableViewbackground];
        
        [self.view addSubview:instTableView];
        
        closeSongTableButton = [[UIButton alloc]initWithFrame:CGRectMake(songsTableHeaderView.frame.size.width-65, 1, 80, 40)];
        closeSongTableButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        [closeSongTableButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [closeSongTableButton setTitle:@"close" forState:UIControlStateNormal];
        [closeSongTableButton addTarget:self action:@selector(closeSongTableView) forControlEvents:UIControlEventTouchUpInside];
        
        closeInstTableButton = [[UIButton alloc]initWithFrame:CGRectMake(-10, 1, 80, 40)];
        closeInstTableButton.layer.cornerRadius = 5;
        closeInstTableButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        [closeInstTableButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [closeInstTableButton setTitle:@"close" forState:UIControlStateNormal];
        [closeInstTableButton addTarget:self action:@selector(closeInstTableView) forControlEvents:UIControlEventTouchUpInside];
        
        blackDot1 = [[PSSBlackDot alloc]initWithFrame:CGRectMake(csKey.frame.size.width/2-5, 10, 10.5, 10.5)];
        blackDot1.backgroundColor = [UIColor whiteColor];
        [csKey addSubview:blackDot1];
        
        blackDot2 = [[PSSBlackDot alloc]initWithFrame:CGRectMake(csKey.frame.size.width/2-5, 10, 10.5, 10.5)];
        blackDot2.backgroundColor = [UIColor whiteColor];
        [dsKey addSubview:blackDot2];
        
        blackDot3 = [[PSSBlackDot alloc]initWithFrame:CGRectMake(csKey.frame.size.width/2-5, 10, 10.5, 10.5)];
        blackDot3.backgroundColor = [UIColor whiteColor];
        [fsKey addSubview:blackDot3];
        
        blackDot4 = [[PSSBlackDot alloc]initWithFrame:CGRectMake(csKey.frame.size.width/2-5, 10, 10.5, 10.5)];
        blackDot4.backgroundColor = [UIColor whiteColor];
        [gsKey addSubview:blackDot4];
        
        blackDot5 = [[PSSBlackDot alloc]initWithFrame:CGRectMake(csKey.frame.size.width/2-5, 10, 10.5, 10.5)];
        blackDot5.backgroundColor = [UIColor whiteColor];
        [asKey addSubview:blackDot5];
        
        blackDot6 = [[PSSBlackDot alloc]initWithFrame:CGRectMake(csKey.frame.size.width/2-5, 10, 10.5, 10.5)];
        blackDot6.backgroundColor = [UIColor whiteColor];
        [cs2Key addSubview:blackDot6];
        
        
        
        if (SCREEN_WIDTH < 500) {
        displayWindow = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 6, 40, 28)];
        }else{
            displayWindow = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 6, 40, 28)];
        }
        displayWindow.text = @"0";
        displayWindow.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
        displayWindow.textColor = [UIColor whiteColor];
        displayWindow.layer.cornerRadius = 5;
        displayWindow.layer.masksToBounds = YES;
        displayWindow.textAlignment = 1;
        displayWindow.backgroundColor = [UIColor clearColor];
        
        NSArray * labelArray = @[@"note names", @"do-re-mi"];
        keyLabelSegmentedControl = [[UISegmentedControl alloc] initWithItems:labelArray];
        keyLabelSegmentedControl.frame = CGRectMake(settingsPage.frame.size.width/2-92.5, SCREEN_HEIGHT * 0.11, 185, 40);
        keyLabelSegmentedControl.selectedSegmentIndex = [[defaults objectForKey:@"keyLabel"] intValue];
        keyLabelSegmentedControl.tintColor = [UIColor blackColor];
        [keyLabelSegmentedControl addTarget:self action:@selector(labelKeys:)forControlEvents:UIControlEventValueChanged];
        [self labelKeys:keyLabelSegmentedControl];
        
        UILabel * labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,-25, 500, 20)];
        labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.text = @"labels";
        [keyLabelSegmentedControl addSubview:labelTitle];
        
        NSArray * expertModeArray = @[@"expert off", @"expert on"];
        expertModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:expertModeArray];
        expertModeSegmentedControl.frame = CGRectMake(settingsPage.frame.size.width/2-92.5, SCREEN_HEIGHT * 0.59, 185, 40);
        expertModeSegmentedControl.selectedSegmentIndex = [[defaults objectForKey:@"expertMode"] intValue];

        expertModeSegmentedControl.tintColor = [UIColor blackColor];
        [expertModeSegmentedControl addTarget:self action:@selector(setGameMode:)forControlEvents:UIControlEventValueChanged];
        
        UILabel * expertModeTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,-25, 500, 20)];
        expertModeTitle.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
        expertModeTitle.textColor = [UIColor blackColor];
        expertModeTitle.text = @"expert mode";
        [expertModeSegmentedControl addSubview:expertModeTitle];
        
        NSArray * proModeArray = @[@"pro off", @"pro on"];
        proModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:proModeArray];
        proModeSegmentedControl.frame = CGRectMake(settingsPage.frame.size.width/2-92.5, SCREEN_HEIGHT * 0.83, 185, 40);
        proModeSegmentedControl.selectedSegmentIndex = [[defaults objectForKey:@"proMode"] intValue];

        proModeSegmentedControl.tintColor = [UIColor blackColor];
        [proModeSegmentedControl addTarget:self action:@selector(setGameMode:)forControlEvents:UIControlEventValueChanged];
        
        UILabel * proModeTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,-25, 500, 20)];
        proModeTitle.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
        proModeTitle.textColor = [UIColor blackColor];
        proModeTitle.text = @"pro mode";
        [proModeSegmentedControl addSubview:proModeTitle];

        NSArray * gameModeArray = @[@"songs", @"random notes"];
        gameModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:gameModeArray];
        gameModeSegmentedControl.frame = CGRectMake(settingsPage.frame.size.width/2-92.5, SCREEN_HEIGHT * 0.35, 185, 40);
        gameModeSegmentedControl.selectedSegmentIndex = [[defaults objectForKey:@"gameMode"] intValue];

        gameModeSegmentedControl.tintColor = [UIColor blackColor];
        [gameModeSegmentedControl addTarget:self action:@selector(setGameMode:)forControlEvents:UIControlEventValueChanged];
        
        UILabel * gameModeTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,-27, 500, 24)];
        gameModeTitle.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
        gameModeTitle.textColor = [UIColor blackColor];
        gameModeTitle.text = @"game mode";
        [gameModeSegmentedControl addSubview:gameModeTitle];
        
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

    
//    [[Crashlytics sharedInstance] crash];       // Force a crash!!
    
    glowKeys = [@[] mutableCopy];
    
    float w = ((SCREEN_WIDTH-(2*4)-(7*2))/8);
    int h = SCREEN_HEIGHT-47;
    
    cKeyBottomLayer = [[UIView alloc]initWithFrame:CGRectMake(4, SCREEN_HEIGHT*.135, w, h)];
    cKeyBottomLayer.backgroundColor = [UIColor colorWithRed:1.000f green:0.008f blue:0.000f alpha:1.0f];
    cKeyBottomLayer.layer.cornerRadius = 5;
    [self.view addSubview:cKeyBottomLayer];
    
    cKey = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    cKey.layer.cornerRadius = 5;
    cKey.tag = 0;
    [cKeyBottomLayer addSubview:cKey];
    [glowKeys addObject:cKey];
    
    dKeyBottomLayer = [[UIView alloc]initWithFrame:CGRectMake(4+w+2, SCREEN_HEIGHT*.135, w, h)];
    dKeyBottomLayer.backgroundColor = [UIColor colorWithRed:1.000f green:0.004f blue:0.847f alpha:1.0f];
    dKeyBottomLayer.layer.cornerRadius = 5;
    [self.view addSubview:dKeyBottomLayer];
    
    dKey = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    dKey.layer.cornerRadius = 5;
    dKey.tag = 1;
    [dKeyBottomLayer addSubview:dKey];
    [glowKeys addObject:dKey];
    
    eKeyBottomLayer = [[UIView alloc]initWithFrame:CGRectMake(4+w*2+2*2, SCREEN_HEIGHT*.135, w, h)];
    eKeyBottomLayer.backgroundColor = [UIColor colorWithRed:0.365f green:0.000f blue:1.000f alpha:1.0f];
    eKeyBottomLayer.layer.cornerRadius = 5;
    [self.view addSubview:eKeyBottomLayer];
    
    eKey = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    eKey.layer.cornerRadius = 5;
    eKey.tag = 2;
    [eKeyBottomLayer addSubview:eKey];
    [glowKeys addObject:eKey];
    
    fKeyBottomLayer = [[UIView alloc]initWithFrame:CGRectMake(4+w*3+2*3, SCREEN_HEIGHT*.135, w, h)];
    fKeyBottomLayer.backgroundColor = [UIColor colorWithRed:0.008f green:0.965f blue:1.000f alpha:1.0f];
    fKeyBottomLayer.layer.cornerRadius = 5;
    [self.view addSubview:fKeyBottomLayer];
    
    fKey = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    fKey.layer.cornerRadius = 5;
    fKey.tag = 3;
    [fKeyBottomLayer addSubview:fKey];
    [glowKeys addObject:fKey];
    
    gKeyBottomLayer = [[UIView alloc]initWithFrame:CGRectMake(4+w*4+2*4, SCREEN_HEIGHT*.135, w, h)];
    gKeyBottomLayer.backgroundColor = [UIColor colorWithRed:0.000f green:0.827f blue:0.322f alpha:1.0f];
    gKeyBottomLayer.layer.cornerRadius = 5;
    [self.view addSubview:gKeyBottomLayer];
    
    gKey = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    gKey.layer.cornerRadius = 5;
    gKey.tag = 4;
    [gKeyBottomLayer addSubview:gKey];
    [glowKeys addObject:gKey];
    
    aKeyBottomLayer = [[UIView alloc]initWithFrame:CGRectMake(4+w*5+2*5, SCREEN_HEIGHT*.135, w, h)];
    aKeyBottomLayer.backgroundColor = [UIColor colorWithRed:0.875f green:0.933f blue:0.000f alpha:1.0f];
    aKeyBottomLayer.layer.cornerRadius = 5;
    [self.view addSubview:aKeyBottomLayer];
    
    aKey = [[UIView alloc]initWithFrame:CGRectMake(0,0, w, h)];
    aKey.layer.cornerRadius = 5;
    aKey.tag = 5;
    [aKeyBottomLayer addSubview:aKey];
    [glowKeys addObject:aKey];
    
    bKeyBottomLayer = [[UIView alloc]initWithFrame:CGRectMake(4+w*6+2*6, SCREEN_HEIGHT*.135, w, h)];
    bKeyBottomLayer.backgroundColor = [UIColor colorWithRed:1.000f green:0.518f blue:0.000f alpha:1.0f];
    bKeyBottomLayer.layer.cornerRadius = 5;
    [self.view addSubview:bKeyBottomLayer];
    
    bKey = [[UIView alloc]initWithFrame:CGRectMake(0,0, w, h)];
    bKey.layer.cornerRadius = 5;
    bKey.tag = 6;
    [bKeyBottomLayer addSubview:bKey];
    [glowKeys addObject:bKey];
    
    c2KeyBottomLayer = [[UIView alloc]initWithFrame:CGRectMake(4+w*7+2*7, SCREEN_HEIGHT*.135, w, h)];
    c2KeyBottomLayer.backgroundColor = [UIColor colorWithRed:1.000f green:0.008f blue:0.000f alpha:1.0f];
    c2KeyBottomLayer.layer.cornerRadius = 5;
    [self.view addSubview:c2KeyBottomLayer];
    
    c2Key = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    c2Key.layer.cornerRadius = 5;
    c2Key.tag = 7;
    [c2KeyBottomLayer addSubview:c2Key];
    [glowKeys addObject:c2Key];
    UIView * csBlackKey = [[UIView alloc]initWithFrame:CGRectMake((4+keyWidth+1)-((SCREEN_WIDTH/12)/2)-2, SCREEN_HEIGHT*.125-2, SCREEN_WIDTH/12+4, SCREEN_HEIGHT/2.5+4)];
    
    csBlackKey.backgroundColor = [UIColor blackColor];
    csBlackKey.layer.cornerRadius = 6;
    [self.view addSubview:csBlackKey];
    
    csKey = [[UIView alloc]initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH/12, SCREEN_HEIGHT/2.5)];
    csKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    csKey.layer.cornerRadius = 5;
    csKey.tag = 8;
    [csBlackKey addSubview:csKey];
    [glowKeys addObject:csKey];
    UIView * dsBlackKey = [[UIView alloc]initWithFrame:CGRectMake(((4+keyWidth)*2)-((SCREEN_WIDTH/12)/2)-2, SCREEN_HEIGHT*.125-2, SCREEN_WIDTH/12+4, SCREEN_HEIGHT/2.5+4)];
    dsBlackKey.backgroundColor = [UIColor blackColor];
    dsBlackKey.layer.cornerRadius = 6;
    [self.view addSubview:dsBlackKey];
    
    dsKey = [[UIView alloc]initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH/12, SCREEN_HEIGHT/2.5)];
    dsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    dsKey.layer.cornerRadius = 5;
    dsKey.tag = 9;
    [dsBlackKey addSubview:dsKey];
    [glowKeys addObject:dsKey];
    UIView * fsBlackKey = [[UIView alloc]initWithFrame:CGRectMake(((4+keyWidth*4)+7)-((SCREEN_WIDTH/12)/2)-2, SCREEN_HEIGHT*.125-2, SCREEN_WIDTH/12+4, SCREEN_HEIGHT/2.5+4)];
    fsBlackKey.backgroundColor = [UIColor blackColor];
    fsBlackKey.layer.cornerRadius = 6;
    [self.view addSubview:fsBlackKey];
    
    fsKey = [[UIView alloc]initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH/12, SCREEN_HEIGHT/2.5)];
    fsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    fsKey.layer.cornerRadius = 5;
    fsKey.tag = 10;
    [fsBlackKey addSubview:fsKey];
    [glowKeys addObject:fsKey];
    UIView * gsBlackKey = [[UIView alloc]initWithFrame:CGRectMake(((4+keyWidth*5)+9)-((SCREEN_WIDTH/12)/2)-2, SCREEN_HEIGHT*.125-2, SCREEN_WIDTH/12+4, SCREEN_HEIGHT/2.5+4)];
    gsBlackKey.backgroundColor = [UIColor blackColor];
    gsBlackKey.layer.cornerRadius = 6;
    [self.view addSubview:gsBlackKey];
    
    gsKey = [[UIView alloc]initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH/12, SCREEN_HEIGHT/2.5)];
    gsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    gsKey.layer.cornerRadius = 5;
    gsKey.tag = 11;
    [gsBlackKey addSubview:gsKey];
    [glowKeys addObject:gsKey];
    UIView * asBlackKey = [[UIView alloc]initWithFrame:CGRectMake(((4+keyWidth*6)+11)-((SCREEN_WIDTH/12)/2)-2, SCREEN_HEIGHT*.125-2, SCREEN_WIDTH/12+4, SCREEN_HEIGHT/2.5+4)];
    asBlackKey.backgroundColor = [UIColor blackColor];
    asBlackKey.layer.cornerRadius = 6;
    [self.view addSubview:asBlackKey];
    
    asKey = [[UIView alloc]initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH/12, SCREEN_HEIGHT/2.5)];
    asKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    asKey.layer.cornerRadius = 5;
    asKey.tag = 12;
    [asBlackKey addSubview:asKey];
    [glowKeys addObject:asKey];
    UIView * cs2BlackKey = [[UIView alloc]initWithFrame:CGRectMake(((4+keyWidth*8)+15)-((SCREEN_WIDTH/12)/2)-2, SCREEN_HEIGHT*.125-2, SCREEN_WIDTH/12+4, SCREEN_HEIGHT/2.5+4)];
    cs2BlackKey.backgroundColor = [UIColor blackColor];
    cs2BlackKey.layer.cornerRadius = 6;
    [self.view addSubview:cs2BlackKey];
    
    cs2Key = [[UIView alloc]initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH/12, SCREEN_HEIGHT/2.5)];
    cs2Key.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    cs2Key.layer.cornerRadius = 5;
    cs2Key.tag = 13;
    [cs2BlackKey addSubview:cs2Key];
    [glowKeys addObject:cs2Key];
    [self animateCircle];
    
    if (SCREEN_WIDTH > 500) {
    cLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth+1, keyWidth, keyWidth)];
    }else{
        cLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth-4, keyWidth, keyWidth)];
    }
    cLabel.layer.cornerRadius = keyWidth/2;
    cLabel.layer.masksToBounds = YES;
    cLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    cLabel.textColor = [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f];
    cLabel.textAlignment = 1;
    [cKey addSubview:cLabel];
    
    if (SCREEN_WIDTH > 500) {
    dLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth+1, keyWidth, keyWidth)];
    }else{
        dLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth-4, keyWidth, keyWidth)];
    }
    dLabel.layer.cornerRadius = keyWidth/2;
    dLabel.layer.masksToBounds = YES;
    dLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    dLabel.textColor = [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f];
    dLabel.textAlignment = 1;
    [dKey addSubview:dLabel];
    
    if (SCREEN_WIDTH > 500) {
    eLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth+1, keyWidth, keyWidth)];
    }else{
        eLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth-4, keyWidth, keyWidth)];
    }
    eLabel.layer.cornerRadius = keyWidth/2;
    eLabel.layer.masksToBounds = YES;
    eLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    eLabel.textColor = [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f];
    eLabel.textAlignment = 1;
    [eKey addSubview:eLabel];
    
    if (SCREEN_WIDTH > 500) {
    fLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth+1, keyWidth, keyWidth)];
    }else{
        fLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth-4, keyWidth, keyWidth)];
    }
    fLabel.layer.cornerRadius = keyWidth/2;
    fLabel.layer.masksToBounds = YES;
    fLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    fLabel.textColor = [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f];
    fLabel.textAlignment = 1;
    [fKey addSubview:fLabel];
    
    if (SCREEN_WIDTH > 500) {
    gLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth+1, keyWidth, keyWidth)];
    }else{
        gLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth-4, keyWidth, keyWidth)];
    }
    gLabel.layer.cornerRadius = keyWidth/2;
    gLabel.layer.masksToBounds = YES;
    gLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    gLabel.textColor = [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f];
    gLabel.textAlignment = 1;
    [gKey addSubview:gLabel];
    
    if (SCREEN_WIDTH > 500) {
    aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth+1, keyWidth, keyWidth)];
    }else{
        aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth-4, keyWidth, keyWidth)];
    }
    aLabel.layer.cornerRadius = keyWidth/2;
    aLabel.layer.masksToBounds = YES;
    aLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    aLabel.textColor = [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f];
    aLabel.textAlignment = 1;
    [aKey addSubview:aLabel];
    
    if (SCREEN_WIDTH > 500) {
    bLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth+1, keyWidth, keyWidth)];
    }else{
        bLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth-4, keyWidth, keyWidth)];
    }
    bLabel.layer.cornerRadius = keyWidth/2;
    bLabel.layer.masksToBounds = YES;
    bLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    bLabel.textColor = [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f];
    bLabel.textAlignment = 1;
    [bKey addSubview:bLabel];
    
    if (SCREEN_WIDTH > 500) {
    c2Label = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth+1, keyWidth, keyWidth)];
    }else{
        c2Label = [[UILabel alloc]initWithFrame:CGRectMake(0, cKey.frame.size.height-keyWidth-4, keyWidth, keyWidth)];
    }
    c2Label.layer.cornerRadius = keyWidth/2;
    c2Label.layer.masksToBounds = YES;
    c2Label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    c2Label.textColor = [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f];
    c2Label.textAlignment = 1;
    [c2Key addSubview:c2Label];
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
                if (self.isPlaying==NO){
                    [headerView addSubview:songsButton];
                    [headerView addSubview:instButton];
                }
                [stopButton removeFromSuperview];
                [headerView addSubview:songsButton];
                [self.view insertSubview:songsTableHeaderView belowSubview:songTableView];
                [self.view insertSubview:instTableHeaderView belowSubview:instTableView];
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
        self.currentTempo = self.currentTempo - 0.045;
    }
    [self setGameSongTempos:self.currentTempo];
    
    if (self.playlength > [currentSong[@"notes"]count])
    {
        self.gameOn = NO;
        [self setGameSongTempos:0.9];
        [self playRewardSong:0];
        [displayWindow removeFromSuperview];
        [scoreLabel removeFromSuperview];
        [headerView addSubview:settingsButton];
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
    if (self.expertMode || self.proMode) {
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 600 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                [self startGame];
                });
            }
        }else{
            
            // if song table is open, close it
            if (songTableView.frame.origin.x < SCREEN_WIDTH) {
                [self closeSongTableView];
                }
            if (settingsPage.frame.origin.x < SCREEN_WIDTH) {
                [self closeSettingsPage];
            }
            self.gameOn = YES;
            randomNotesDict = [@{
                                 @"tempo":@[],
                                 @"notes":[@[] mutableCopy]
                                 }mutableCopy];
            
            [self.view addSubview:displayWindow];
            [headerView addSubview:scoreLabel];

            displayWindow.text = [NSString stringWithFormat:@"0"];
            
            [songsButton removeFromSuperview];
            [stopButton removeFromSuperview];
            [songsTableHeaderView removeFromSuperview];
            [instButton removeFromSuperview];
            [instTableHeaderView removeFromSuperview];
            [settingsButton removeFromSuperview];
            
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

- (void)playGame:(UIView *)note withTag:(int)tag
{
    if (self.gameOn){
        if (noteCount == [tempSongNotesArray count]) {
            self.gameOn = NO;
            [self endGame];
            return;
            }else{
            if (notes[instrument][tag] == tempSongNotesArray[noteCount]){
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
        [scoreLabel removeFromSuperview];
        [self rewardDisplay:maxScore withIndex:0];
        [self playRewardSong:0];
        [headerView addSubview:settingsButton];
        return;
    }
    self.gameOn = NO;
    [self playRewardSong:1];
    [displayWindow removeFromSuperview];
    [scoreLabel removeFromSuperview];
    [self.view insertSubview:songsTableHeaderView belowSubview:songTableView];
    [headerView addSubview:songsButton];
    [self.view insertSubview:instTableHeaderView belowSubview:instTableView];
    [headerView addSubview:instButton];
    [headerView addSubview:settingsButton];
    
    UIView * rewardDisplayView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-50, SCREEN_WIDTH, 100)];
    rewardDisplayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rewardDisplayView];
    
    UILabel * rewardDisplayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, rewardDisplayView.frame.size.height)];
    rewardDisplayLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    rewardDisplayLabel.text = @"Try Again!";
    rewardDisplayLabel.textColor = [UIColor blackColor];
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
    [self closeInstTableView];
    [songsTableHeaderView addSubview:closeSongTableButton];
    [songTableView reloadData];
    
    [UIView animateWithDuration:0.2 animations:^{
        songsTableHeaderView.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*.40, 0, SCREEN_WIDTH*.40, 40);
        songTableView.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*.40, 40, SCREEN_WIDTH*.40, SCREEN_HEIGHT-40);
    }completion:^(BOOL finished) {
    }];
}


-(void)openInstList
{
    [self closeSettingsPage];
    [self closeSongTableView];
    [instTableHeaderView addSubview:closeInstTableButton];
    [instTableView reloadData];
    
    [UIView animateWithDuration:0.2 animations:^{
        instTableHeaderView.frame = CGRectMake(0, 0, 210, 40);
        instTableView.frame = CGRectMake(0, 40, 210, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
    }];
}

-(void)closeSongTableView
{
    self.stopPlaying = NO;
    [closeSongTableButton removeFromSuperview];
    if (songTableView.frame.origin.x < SCREEN_WIDTH && self.isPlaying) {
        [songsButton removeFromSuperview];
        [headerView addSubview:stopButton];
    }else{
        [headerView addSubview:startButton];
    }
    if (self.gameOn == YES) {
        [songsButton removeFromSuperview];
        [settingsButton removeFromSuperview];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        songsTableHeaderView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH*.40, 40);
        songTableView.frame = CGRectMake(SCREEN_WIDTH, 40, SCREEN_WIDTH*.40, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        if (self.gameOn == NO) {
        [headerView addSubview:settingsButton];
        }
    }];
}

-(void)closeInstTableView
{
    [closeInstTableButton removeFromSuperview];
    if (self.gameOn == NO) {
    }
    [UIView animateWithDuration:0.2 animations:^{
        instTableHeaderView.frame = CGRectMake(-210, 0, 210, 40);
        instTableView.frame = CGRectMake(-210, 40, 210, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
    }];
}

-(void)openSettingsPage
{
    [self closeInstTableView];

    [UIView animateWithDuration:0.2 animations:^{
        [displayWindow removeFromSuperview];
        [scoreLabel removeFromSuperview];
        settingsPage.frame =  CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*.40, 0, SCREEN_WIDTH*.40, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        [settingsPage addSubview:keyLabelSegmentedControl];
        [settingsPage addSubview:gameModeSegmentedControl];
        [settingsPage addSubview:expertModeSegmentedControl];
        [settingsPage addSubview:proModeSegmentedControl];
        [settingsPage addSubview:xView];
        [xView addSubview:xButton];
    }];
}

-(void)closeSettingsPage
{
    [UIView animateWithDuration:0.2 animations:^{
        settingsPage.frame =  CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        [xView removeFromSuperview];
        [xButton removeFromSuperview];

        if (self.gameOn) {
            [self.view addSubview:displayWindow];
            [headerView addSubview:scoreLabel];
            [stopButton removeFromSuperview];
            [songsButton removeFromSuperview];
            [settingsButton removeFromSuperview];
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
    [headerView addSubview:songsButton];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 800 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        self.stopPlaying = NO;
    });
}

- (void)glowKey:(int)indexOfKeyView
{
    if (self.proMode) {
        return;
    }else{
        UIView * currentGlowKey = glowKeys[indexOfKeyView];

        if (indexOfKeyView <=8) {
            currentGlowKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                currentGlowKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
            } completion:^(BOOL finished) {
            }];
        } else if (indexOfKeyView >=9)
        {
            currentGlowKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                currentGlowKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
            } completion:^(BOOL finished) {
            }];
        }
    }
}


-(void)playNote:(UIView *)note withTag:(int)tag
{    
    if (tag <=7) {
        note.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            note.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        } completion:^(BOOL finished) {
        }];
    } else if (tag >=8)
    {
        note.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            note.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        } completion:^(BOOL finished) {
        }];
    }
    [player playSoundWithName:notes[instrument][tag]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    cLabel.text = @"do";
    dLabel.text = @"re";
    eLabel.text = @"mi";
    fLabel.text = @"fa";
    gLabel.text = @"so";
    aLabel.text = @"la";
    bLabel.text = @"ti";
    c2Label.text = @"do";
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
    
    cLabel.text = @"c";
    dLabel.text = @"d";
    eLabel.text = @"e";
    fLabel.text = @"f";
    gLabel.text = @"g";
    aLabel.text = @"a";
    bLabel.text = @"b";
    c2Label.text = @"c";
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
    if (self.expertMode == NO && self.proMode == NO) {
        UISegmentedControl *control = (UISegmentedControl *)sender;
        NSString * label = [control titleForSegmentAtIndex: [control selectedSegmentIndex]];
        if ([label isEqual: @"do-re-mi"]) {
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
    if ([label isEqual: @"random notes"]) {
        self.randomMode = YES;
    }else if ([label  isEqual: @"songs"]){
        self.randomMode = NO;
    }
    if ([label isEqual: @"expert on"]) {
        self.expertMode = YES;
        self.proMode = NO;
        proModeSegmentedControl.selectedSegmentIndex = 0;
        [self removeLabels];
    }else if([label isEqual: @"expert off"]){
        self.expertMode = NO;
        [self labelKeys:keyLabelSegmentedControl];
    }
    if ([label isEqual: @"pro on"]) {
        self.expertMode = NO;
        self.proMode = YES;
        expertModeSegmentedControl.selectedSegmentIndex = 0;
        [self removeLabels];
    }else if([label isEqual: @"pro off"]){
        self.proMode = NO;
        [self labelKeys:keyLabelSegmentedControl];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInteger:[expertModeSegmentedControl selectedSegmentIndex]] forKey:@"expertMode"];
	[defaults setObject:[NSNumber numberWithInteger:[gameModeSegmentedControl selectedSegmentIndex]] forKey:@"gameMode"];
    [defaults setObject:[NSNumber numberWithInteger:[proModeSegmentedControl selectedSegmentIndex]] forKey:@"proMode"];
	[defaults synchronize];
//   NSLog(@"defaults modes: %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
}

-(void)rewardDisplay:(int)totalScore withIndex:(int)indexOfGameSongslist
{
    [self.view insertSubview:songsTableHeaderView belowSubview:songTableView];
    [headerView addSubview:songsButton];
    [self.view insertSubview:instTableHeaderView belowSubview:instTableView];
    [headerView addSubview:instButton];
    self.gameOn = NO;
    
    UIView * rewardDisplayView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-50, SCREEN_WIDTH, 100)];
    rewardDisplayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rewardDisplayView];
    
    UILabel * rewardDisplayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, rewardDisplayView.frame.size.height)];
    rewardDisplayLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:30];
    rewardDisplayLabel.textColor = [UIColor blackColor];
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
        
        if (cell == nil) {
            cell = [[PSSTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        UIView *selectionColor = [[UIView alloc] init];
        selectionColor.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = selectionColor;

        cell.backgroundColor =[UIColor clearColor];
        cell.layer.cornerRadius = 5;
        cell.imageView.frame = CGRectMake(10, 10, 200, 20);
        
        cell.songInfo = self.titleItems[indexPath.row];        
        
        return cell;
        
    }else if(tableView == instTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        cell.textLabel.text = instrumentList[indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
        cell.textLabel.highlightedTextColor = [UIColor blueColor];
        
        
        UIView *selectionColor = [[UIView alloc] init];
        selectionColor.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = selectionColor;
        
        
        cell.backgroundColor =[UIColor clearColor];
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

-(void)animateCircle
{
    {
        static int count = 0;
        static int pad = 0;
        count = count + 1;
        float x = (4+((keyWidth)*count)-((keyWidth)/2)+pad);
        int y = -35;
        pad = pad + 2;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        
        // Set up the shape of the circle
        int radius = 24;
        CAShapeLayer *circle = [CAShapeLayer layer];
        // Make a circular shape
        circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                 cornerRadius:radius].CGPath;
        // Center the shape in self.view
        circle.position = CGPointMake(x-radius,
                                      y-radius);
        
        // Configure the apperence of the circle
        circle.fillColor = [UIColor clearColor].CGColor;
        circle.strokeColor =[UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:1.0f].CGColor;

        circle.lineWidth = 0.5;
        
        // Add to parent layer
        [circlesView.layer addSublayer:circle];
        
        // Configure animation
        CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        drawAnimation.duration            = 0.5; // animate over .5 seconds
        drawAnimation.repeatCount         = 1.0;  // animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
        
        // Experiment with timing to get the appearence to look the way you want
        drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        // Add the animation to the circle
        [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
            
            if(count < 8)
            {
                [self animateCircle];
            }
        });
        [self.view addSubview:settingsPage];
        [self.view addSubview:instTableView];
        [self.view addSubview:songTableView];
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

- (UIImage *)blurView
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] set];
    CGContextFillRect(context, self.view.bounds);
    
    [self.view.layer renderInContext:context];
    
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	
	vImage_Buffer inBuffer;
	inBuffer.data = CGBitmapContextGetData(context);
	inBuffer.width = CGBitmapContextGetWidth(context);
	inBuffer.height = CGBitmapContextGetHeight(context);
	inBuffer.rowBytes = CGBitmapContextGetBytesPerRow(context);
    
	UIGraphicsBeginImageContext(self.view.bounds.size);
	CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
	vImage_Buffer outBuffer;
	outBuffer.data = CGBitmapContextGetData(effectOutContext);
	outBuffer.width = CGBitmapContextGetWidth(effectOutContext);
	outBuffer.height = CGBitmapContextGetHeight(effectOutContext);
	outBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
	
	CGFloat blurRadius = 10;
	CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
	int radius = floor(inputRadius * 9. * sqrt(2 * M_PI) / 4 + 0.5);
	if (radius % 2 != 1) { radius += 1; }
	vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
	vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
	vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
    
	// add tint
	UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    
	CGContextSaveGState(context);
	CGContextSetFillColorWithColor(context, tintColor.CGColor);
	CGContextFillRect(context, CGRectMake(0, 0, image.size.width, image.size.height));
	CGContextRestoreGState(context);
	
	
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
	
	UIGraphicsEndImageContext();
	UIGraphicsEndImageContext();
    
    CGImageRelease(imageRef);
    
    
    return returnImage;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.touchCount addObject:@1];
    
    for (UITouch * touch in touches) {
        if([self.touchCount count]==1) finger1 = touch;
        if([self.touchCount count]==2) finger2 = touch;
        if([self.touchCount count]==3) finger3 = touch;
    
        if ([touch view] == cKey){
            if ([self.touchCount count]==1) {
                [self.touchArray1 removeAllObjects];
                [self.touchArray1 addObject:@0];
            }
            if ([self.touchCount count]==2) {
                [self.touchArray2 removeAllObjects];
                [self.touchArray2 addObject:@0];
            }
            if ([self.touchCount count]==3) {
                [self.touchArray3 removeAllObjects];
                [self.touchArray3 addObject:@0];
            }
            [self playNote:cKey withTag:0];
            [self playGame:cKey withTag:0];
        }
        if ([touch view] == dKey){
            if ([self.touchCount count]==1) {
                [self.touchArray1 removeAllObjects];
                [self.touchArray1 addObject:@1];
            }
            if ([self.touchCount count]==2) {
                [self.touchArray2 removeAllObjects];
                [self.touchArray2 addObject:@1];
            }
            if ([self.touchCount count]==3) {
                [self.touchArray3 removeAllObjects];
                [self.touchArray3 addObject:@1];
            }
            [self playNote:dKey withTag:1];
            [self playGame:dKey withTag:1];
        }
        if ([touch view] == eKey){
            if ([self.touchCount count]==1) {
                [self.touchArray1 removeAllObjects];
                [self.touchArray1 addObject:@2];
            }
            if ([self.touchCount count]==2) {
                [self.touchArray2 removeAllObjects];
                [self.touchArray2 addObject:@2];
            }
            if ([self.touchCount count]==3) {
                [self.touchArray3 removeAllObjects];
                [self.touchArray3 addObject:@2];
            }
            [self playNote:eKey withTag:2];
            [self playGame:eKey withTag:2];
        }
        if ([touch view] == fKey){
            if ([self.touchCount count]==1) {
                [self.touchArray1 removeAllObjects];
                [self.touchArray1 addObject:@3];
            }
            if ([self.touchCount count]==2) {
                [self.touchArray2 removeAllObjects];
                [self.touchArray2 addObject:@3];
            }
            if ([self.touchCount count]==3) {
                [self.touchArray3 removeAllObjects];
                [self.touchArray3 addObject:@3];
            }
            [self playNote:fKey withTag:3];
            [self playGame:fKey withTag:3];
        }
        if ([touch view] == gKey){
            if ([self.touchCount count]==1) {
                [self.touchArray1 removeAllObjects];
                [self.touchArray1 addObject:@4];
            }
            if ([self.touchCount count]==2) {
                [self.touchArray2 removeAllObjects];
                [self.touchArray2 addObject:@4];
            }
            if ([self.touchCount count]==3) {
                [self.touchArray3 removeAllObjects];
                [self.touchArray3 addObject:@4];
            }
            [self playNote:gKey withTag:4];
            [self playGame:gKey withTag:4];
        }
        if ([touch view] == aKey){
            if ([self.touchCount count]==1) {
                [self.touchArray1 removeAllObjects];
                [self.touchArray1 addObject:@5];
            }
            if ([self.touchCount count]==2) {
                [self.touchArray2 removeAllObjects];
                [self.touchArray2 addObject:@5];
            }
            if ([self.touchCount count]==3) {
                [self.touchArray3 removeAllObjects];
                [self.touchArray3 addObject:@5];
            }
            [self playNote:aKey withTag:5];
            [self playGame:aKey withTag:5];
        }
        if ([touch view] == bKey){
            if ([self.touchCount count]==1) {
                [self.touchArray1 removeAllObjects];
                [self.touchArray1 addObject:@6];
            }
            if ([self.touchCount count]==2) {
                [self.touchArray2 removeAllObjects];
                [self.touchArray2 addObject:@6];
            }
            if ([self.touchCount count]==3) {
                [self.touchArray3 removeAllObjects];
                [self.touchArray3 addObject:@6];
            }
            [self playNote:bKey withTag:6];
            [self playGame:bKey withTag:6];
        }
        if ([touch view] == c2Key){
            if ([self.touchCount count]==1) {
                [self.touchArray1 removeAllObjects];
                [self.touchArray1 addObject:@7];
            }
            if ([self.touchCount count]==2) {
                [self.touchArray2 removeAllObjects];
                [self.touchArray2 addObject:@7];
            }
            if ([self.touchCount count]==3) {
                [self.touchArray3 removeAllObjects];
                [self.touchArray3 addObject:@7];
            }
            [self playNote:c2Key withTag:7];
            [self playGame:c2Key withTag:7];
        }
        if ([touch view] == csKey){
            [self.touchArray1 removeAllObjects];
            [self.touchArray1 addObject:@8];
            [self playNote:csKey withTag:8];
            [self playGame:csKey withTag:8];
        }
        if ([touch view] == dsKey){
            [self.touchArray1 removeAllObjects];
            [self.touchArray1 addObject:@9];
            [self playNote:dsKey withTag:9];
            [self playGame:dsKey withTag:9];
        }
        if ([touch view] == fsKey){
            [self.touchArray1 removeAllObjects];
            [self.touchArray1 addObject:@10];
            [self playNote:fsKey withTag:10];
            [self playGame:fsKey withTag:10];
        }
        if ([touch view] == gsKey){
            [self.touchArray1 removeAllObjects];
            [self.touchArray1 addObject:@11];
            [self playNote:gsKey withTag:11];
            [self playGame:gsKey withTag:11];
        }
        if ([touch view] == asKey){
            [self.touchArray1 removeAllObjects];
            [self.touchArray1 addObject:@12];
            [self playNote:asKey withTag:12];
            [self playGame:asKey withTag:12];
        }
        if ([touch view] == cs2Key){
            [self.touchArray1 removeAllObjects];
            [self.touchArray1 addObject:@13];
            [self playNote:cs2Key withTag:13];
            [self playGame:cs2Key withTag:13];
        }
    }
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.gameOn) {
        return;
    }else{
        NSArray * touchArray1Copy = [self.touchArray1 copy];
        NSArray * touchArray2Copy = [self.touchArray2 copy];
        NSArray * touchArray3Copy = [self.touchArray3 copy];
        
        UITouch *touch1 = [touches anyObject];
        CGPoint location1 = [touch1 locationInView:self.view];

        float wkh = SCREEN_HEIGHT*.125-2 + SCREEN_HEIGHT/2.5+4;  //white key height
        float hwkw = ((SCREEN_WIDTH/12)/2)-2;                    //half of white key width, minus 2 padding

        for (UITouch* touch in touches) {
            if (location1.x > 3 && location1.x < 3+keyWidth && location1.y > wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @0]){
                            [self playNote:cKey withTag:0];
                            [self.touchArray1 removeAllObjects];
                            [self.touchArray1 addObject:@0];
                        }else{
                            return;
                        }
                    }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @0]) {
                        [self playNote:cKey withTag:0];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@0];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @0]) {
                        [self playNote:cKey withTag:0];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@0];
                    }else{
                        return;
                    }
                }
            }
            
            if (location1.x > 5+keyWidth && location1.x < 5+keyWidth*2 && location1.y > wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @1]){
                        [self playNote:dKey withTag:1];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@1];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @1]) {
                        [self playNote:dKey withTag:1];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@1];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @1]) {
                        [self playNote:dKey withTag:1];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@1];
                    }else{
                        return;
                    }
                }
            }

            if (location1.x > 7+keyWidth*2 && location1.x < 7+keyWidth*3 && location1.y > wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @2]){
                        [self playNote:eKey withTag:2];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@2];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @2]) {
                        [self playNote:eKey withTag:2];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@2];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @2]) {
                        [self playNote:eKey withTag:2];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@2];
                    }else{
                        return;
                    }
                }
            }
        
            if (location1.x > 9+keyWidth*3 && location1.x < 9+keyWidth*4 && location1.y > wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @3]){
                        [self playNote:fKey withTag:3];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@3];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @3]) {
                        [self playNote:fKey withTag:3];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@3];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @3]) {
                        [self playNote:fKey withTag:3];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@3];
                    }else{
                        return;
                    }
                }
            }
            
            if (location1.x > 11+keyWidth*4 && location1.x < 11+keyWidth*5 && location1.y > wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @4]){
                        [self playNote:gKey withTag:4];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@4];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @4]) {
                        [self playNote:gKey withTag:4];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@4];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @4]) {
                        [self playNote:gKey withTag:4];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@4];
                    }else{
                        return;
                    }
                }
            }
            
            if (location1.x > 13+keyWidth*5 && location1.x < 13+keyWidth*6 && location1.y > wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @5]){
                        [self playNote:aKey withTag:5];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@5];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @5]) {
                        [self playNote:aKey withTag:5];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@5];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @5]) {
                        [self playNote:aKey withTag:5];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@5];
                    }else{
                        return;
                    }
                }
            }
        
            if (location1.x > 15+keyWidth*6 && location1.x < 15+keyWidth*7 && location1.y > wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @6]){
                        [self playNote:bKey withTag:6];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@6];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @6]) {
                        [self playNote:bKey withTag:6];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@6];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @6]) {
                        [self playNote:bKey withTag:6];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@6];
                    }else{
                        return;
                    }
                }
            }
        
            if (location1.x > 17+keyWidth*7 && location1.x < 17+keyWidth*8 && location1.y > wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @7]){
                        [self playNote:c2Key withTag:7];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@7];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @7]) {
                        [self playNote:c2Key withTag:7];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@7];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @7]) {
                        [self playNote:c2Key withTag:7];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@7];
                    }else{
                        return;
                    }
                }
            }
            if (location1.x > (4+keyWidth)-hwkw && location1.x < (4+keyWidth)+hwkw && location1.y < wkh) {
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @8]){
                        [self playNote:csKey withTag:8];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@8];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @8]) {
                        [self playNote:csKey withTag:8];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@8];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @8]) {
                        [self playNote:csKey withTag:8];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@8];
                    }else{
                        return;
                    }
                }
            }
            if (location1.x > (4+keyWidth*2)-hwkw && location1.x < (4+keyWidth*2)+hwkw && location1.y < wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @9]){
                        [self playNote:dsKey withTag:9];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@9];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @9]) {
                        [self playNote:dsKey withTag:9];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@9];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @9]) {
                        [self playNote:dsKey withTag:9];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@9];
                    }else{
                        return;
                    }
                }
            }
        if (location1.x > (4+keyWidth*4)-hwkw && location1.x < (4+keyWidth*4)+hwkw && location1.y < wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @10]){
                        [self playNote:fsKey withTag:10];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@10];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @10]) {
                        [self playNote:fsKey withTag:10];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@10];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @10]) {
                        [self playNote:fsKey withTag:10];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@10];
                    }else{
                        return;
                    }
                }
            }
            if (location1.x > (4+keyWidth*5)-hwkw && location1.x < (4+keyWidth*5)+hwkw && location1.y < wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @11]){
                        [self playNote:gsKey withTag:11];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@11];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @11]) {
                        [self playNote:gsKey withTag:11];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@11];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @11]) {
                        [self playNote:gsKey withTag:11];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@11];
                    }else{
                        return;
                    }
                }
            }
            if (location1.x > (4+keyWidth*6)-hwkw && location1.x < (4+keyWidth*6)+hwkw && location1.y < wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @12]){
                        [self playNote:asKey withTag:12];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@12];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @12]) {
                        [self playNote:asKey withTag:12];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@12];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @12]) {
                        [self playNote:asKey withTag:12];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@12];
                    }else{
                        return;
                    }
                }
            }
            if (location1.x > (4+keyWidth*8)-hwkw && location1.x < (4+keyWidth*8)+hwkw && location1.y < wkh){
                if(finger1 == touch){
                    if (![touchArray1Copy[0] isEqual: @13]){
                        [self playNote:cs2Key withTag:13];
                        [self.touchArray1 removeAllObjects];
                        [self.touchArray1 addObject:@13];
                    }else{
                        return;
                    }
                }
                if(finger2 == touch){
                    if (![touchArray2Copy[0] isEqual: @13]) {
                        [self playNote:cs2Key withTag:13];
                        [self.touchArray2 removeAllObjects];
                        [self.touchArray2 addObject:@13];
                    }else{
                        return;
                    }
                }
                if(finger3 == touch){
                    if (![touchArray3Copy[0] isEqual: @13]) {
                        [self playNote:cs2Key withTag:13];
                        [self.touchArray3 removeAllObjects];
                        [self.touchArray3 addObject:@13];
                    }else{
                        return;
                    }
                }
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch* touch in touches) {
        [self.touchCount removeLastObject];
        if(finger1 == touch) finger1 = nil;
        if(finger2 == touch) finger2 = nil;
        if(finger3 == touch) finger3 = nil;
    }
}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
