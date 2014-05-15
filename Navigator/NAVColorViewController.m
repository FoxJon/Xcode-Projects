//
//  NAVColorViewController.m
//  Navigator
//
//  Created by Jonathan Fox on 5/14/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVColorViewController.h"

@interface NAVColorViewController ()

@end

@implementation NAVColorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blueColor];
        
        UIView * drawer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.height)];
        drawer.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:drawer];
        
        UIView * tab = [[UIView alloc]initWithFrame:CGRectMake(100, 50, 20, 30)];
        tab.backgroundColor = [UIColor redColor];
        [drawer addSubview:tab];
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
