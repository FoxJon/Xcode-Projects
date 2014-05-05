//
//  SquareViewController.m
//  TEMP
//
//  Created by Jonathan Fox on 4/28/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SquareViewController.h"

@interface SquareViewController ()

@end

@implementation SquareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *square = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    square.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:square];
    
    [UIView animateWithDuration:1.0 animations:^{
        square.backgroundColor = [UIColor blackColor];
        
        square.layer.shadowColor = [UIColor blackColor].CGColor;
        square.layer.shadowOpacity = 0.75;
        square.layer.shadowRadius = 15.0;
        square.layer.shadowOffset = (CGSize){0.0,20.0};
        
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                         animations: ^(void) {
                             square.transform = CGAffineTransformMakeScale(-1, 1);
                         }
                         completion:^(BOOL b) {
                             square.layer.shadowColor = [UIColor blackColor].CGColor;
                             square.layer.shadowOpacity = 0.75;
                             square.layer.shadowRadius = 15.0;
                             square.layer.shadowOffset = (CGSize){0.0, 20.0};
                         }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)flipWithDuration:(NSTimeInterval)duration
//               direction:(UIViewAnimationFlipDirection)direction
//             repeatCount:(NSUInteger)repeatCount
//             autoreverse:(BOOL)shouldAutoreverse;

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
