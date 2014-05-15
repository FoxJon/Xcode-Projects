//
//  NAVViewController.m
//  Navigator
//
//  Created by Jonathan Fox on 5/14/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVViewController.h"
#import "NAVTableViewController.h"

@interface NAVViewController ()

@end

@implementation NAVViewController

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
    
    UIView * redRing = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-51, self.view.frame.size.height/2-51, 102, 102)];
    redRing.backgroundColor = [UIColor redColor];
    redRing.layer.cornerRadius = 51;
    [self.view addSubview:redRing];
    
    UIView * blackRing = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
    blackRing.backgroundColor = [UIColor blackColor];
    blackRing.layer.cornerRadius = 50;
    [self.view addSubview:blackRing];
    
    UIButton * startButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 90, 90)];
    startButton.layer.cornerRadius = 45;
    startButton.backgroundColor = [UIColor redColor];
    startButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(openTableView) forControlEvents:UIControlEventTouchUpInside];
    [blackRing addSubview:startButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.toolbarHidden = YES;

}

-(void)openTableView
{
    NAVTableViewController *tvc = [[NAVTableViewController alloc]initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:tvc animated:YES];
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
