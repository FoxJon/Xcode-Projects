//
//  PSSPianoViewController.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/25/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSPianoViewController.h"
#import "PSSCNotePlayer.h"
#import "PSSCsNotePlayer.h"
#import "PSSDNotePlayer.h"
#import "PSSDsNotePlayer.h"
#import "PSSENotePlayer.h"
#import "PSSFNotePlayer.h"
#import "PSSFsNotePlayer.h"
#import "PSSGNotePlayer.h"
#import "PSSGsNotePlayer.h"
#import "PSSANotePlayer.h"
#import "PSSAsNotePlayer.h"
#import "PSSBNotePlayer.h"
#import "PSSC2NotePlayer.h"


@interface PSSPianoViewController ()

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
    
    PSSCNotePlayer * cNote;
    PSSCsNotePlayer * csNote;
    PSSDNotePlayer * dNote;
    PSSDsNotePlayer * dsNote;
    PSSENotePlayer * eNote;
    PSSFNotePlayer * fNote;
    PSSFsNotePlayer * fsNote;
    PSSGNotePlayer * gNote;
    PSSGsNotePlayer * gsNote;
    PSSANotePlayer * aNote;
    PSSAsNotePlayer * asNote;
    PSSBNotePlayer * bNote;
    PSSC2NotePlayer * c2Note;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blueColor];
        
       

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cKey = [[UIButton alloc]initWithFrame:CGRectMake(0, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    cKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    cKey.layer.cornerRadius = 15;
    [cKey addTarget:self action:@selector(playCNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cKey];
    
    dKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*1, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    dKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    dKey.layer.cornerRadius = 15;
    [dKey addTarget:self action:@selector(playDNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dKey];
    
    eKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*2, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    eKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    eKey.layer.cornerRadius = 15;
    [eKey addTarget:self action:@selector(playENote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eKey];
    
    fKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*3, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    fKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    fKey.layer.cornerRadius = 15;
    [fKey addTarget:self action:@selector(playFNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fKey];
    
    gKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*4, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    gKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    gKey.layer.cornerRadius = 15;
    [gKey addTarget:self action:@selector(playGNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gKey];
    
    aKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*5, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    aKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    aKey.layer.cornerRadius = 15;
    [aKey addTarget:self action:@selector(playANote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aKey];
    
    bKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*6, -100, SCREEN_WIDTH/8-1, SCREEN_HEIGHT+100)];
    bKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    bKey.layer.cornerRadius = 15;
    [bKey addTarget:self action:@selector(playBNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bKey];
    
    c2Key = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*7, -100, SCREEN_WIDTH/8, SCREEN_HEIGHT+100)];
    c2Key.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    c2Key.layer.cornerRadius = 15;
    [c2Key addTarget:self action:@selector(playC2Note) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:c2Key];
    
    csKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*1-(SCREEN_WIDTH/13)/2, -100, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    csKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    csKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    [csKey addTarget:self action:@selector(playCsNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:csKey];
    
    dsKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*2-(SCREEN_WIDTH/13)/2, -100, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    dsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    dsKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    [dsKey addTarget:self action:@selector(playDsNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dsKey];
    
    fsKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*4-(SCREEN_WIDTH/13)/2, -100, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    fsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    fsKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    [fsKey addTarget:self action:@selector(playFsNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fsKey];
    
    gsKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*5-(SCREEN_WIDTH/13)/2, -100, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    gsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    gsKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    [gsKey addTarget:self action:@selector(playGsNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gsKey];
    
    asKey = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8*6-(SCREEN_WIDTH/13)/2, -100, SCREEN_WIDTH/13, SCREEN_HEIGHT/2+100)];
    asKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    asKey.layer.cornerRadius = (SCREEN_WIDTH/13)/4;
    [asKey addTarget:self action:@selector(playAsNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:asKey];
    
    cNote = [[PSSCNotePlayer alloc]init];
    csNote = [[PSSCsNotePlayer alloc]init];
    dNote = [[PSSDNotePlayer alloc]init];
    dsNote = [[PSSDsNotePlayer alloc]init];
    eNote = [[PSSENotePlayer alloc]init];
    fNote = [[PSSFNotePlayer alloc]init];
    fsNote = [[PSSFsNotePlayer alloc]init];
    gNote = [[PSSGNotePlayer alloc]init];
    gsNote = [[PSSGsNotePlayer alloc]init];
    aNote = [[PSSANotePlayer alloc]init];
    asNote = [[PSSAsNotePlayer alloc]init];
    bNote = [[PSSBNotePlayer alloc]init];
    c2Note = [[PSSC2NotePlayer alloc]init];
    
}

-(void)playCNote
{
    [cNote playSoundWithName:@"cNote"];

    cKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        cKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playCsNote
{
    [csNote playSoundWithName:@"csNote"];

    csKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        csKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}


-(void)playDNote
{
    [dNote playSoundWithName:@"dNote"];

    dKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        dKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}


-(void)playDsNote
{
    [dsNote playSoundWithName:@"dsNote"];

    dsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        dsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playENote
{
    [eNote playSoundWithName:@"eNote"];

    eKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        eKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playFNote
{
    [fNote playSoundWithName:@"fNote"];

    fKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        fKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playFsNote
{
    [fsNote playSoundWithName:@"fsNote"];

    fsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        fsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playGNote
{
    [gNote playSoundWithName:@"gNote"];

    gKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        gKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playGsNote
{
    [gsNote playSoundWithName:@"gsNote"];

    gsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        gsKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playANote
{
    [aNote playSoundWithName:@"aNote"];

    aKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        aKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playAsNote
{
    [asNote playSoundWithName:@"asNote"];

    asKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        asKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playBNote
{
    [bNote playSoundWithName:@"bNote"];

    bKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        bKey.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}

-(void)playC2Note
{
    [c2Note playSoundWithName:@"c2Note"];

    c2Key.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        c2Key.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
