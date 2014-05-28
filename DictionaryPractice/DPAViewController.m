//
//  DPAViewController.m
//  DictionaryPractice
//
//  Created by Jonathan Fox on 5/27/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "DPAViewController.h"

@interface DPAViewController ()

@end

@implementation DPAViewController
{
    NSDictionary * rewardSequenceArray;
    NSDictionary * twinkleTwinkleArray;
    NSDictionary * maryHadALittleLambArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray * songlist = @[@"rewardSequenceArray",
                           @{
                               @"notes":@[@7, @1, @2, @4, @7, @0],
                               @"tempo":@[@100, @400, @500, @600, @700, @800]
                            },
                          @"twinkleTwinkleArray",
                           @{
                               @"notes":@[@0, @0, @4, @4, @5, @5, @4, @3, @3, @2, @2, @1, @1, @0],
                               @"tempo":@[@100, @400, @700, @1000, @1300, @1600, @1900, @2200, @2500, @2800, @3100, @3400, @3700, @4000]
                            },
                          @"maryHadALittleLambArray",
                           @{
                               @"notes":@[@0, @0, @4, @4, @5, @5, @4, @3, @3, @2, @2, @1, @1, @0],
                               @"tempo":@[@100, @400, @700, @1000, @1300, @1600, @1900, @2200, @2500, @2800, @3100, @3400, @3700, @4000]
                            },
                        ];
    
    NSLog(@"%@", songlist[0]);
    NSLog(@"%@", songlist[1]);
    NSLog(@"%@", songlist[2]);

}



    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
