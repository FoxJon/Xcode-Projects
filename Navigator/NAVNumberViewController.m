//
//  NAVNumberViewController.m
//  Navigator
//
//  Created by Jonathan Fox on 5/14/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVNumberViewController.h"
#import "NAVData.h"

@interface NAVNumberViewController ()

@end

@implementation NAVNumberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *chalkboard = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 137.5, 100, 275, 183)];
        chalkboard.image = [UIImage imageNamed:@"chalkboard.png"];
        [self.view addSubview:chalkboard];
        
        UILabel * numberFrame = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 275, 183)];
        numberFrame.backgroundColor = [UIColor clearColor];
        numberFrame.layer.cornerRadius = 100;
        numberFrame.textColor = [UIColor whiteColor];
        numberFrame.font = [UIFont fontWithName:@"Chalkduster" size:100];
        numberFrame.textAlignment = 1;
        if ([[NAVData mainData].number isEqual: @"One"]) {
            numberFrame.text = @"1";
        }else if ([[NAVData mainData].number isEqual: @"Thirty-two"]) {
            numberFrame.text = @"32";
        }else if ([[NAVData mainData].number isEqual: @"Fourty"]) {
            numberFrame.text = @"40";
        }else if ([[NAVData mainData].number isEqual: @"One Hundred"]) {
            numberFrame.text = @"100";
        }
        
        [chalkboard addSubview:numberFrame];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

-(BOOL)prefersStatusBarHidden{return YES;}

@end
