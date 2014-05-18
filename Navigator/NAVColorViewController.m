//
//  NAVColorViewController.m
//  Navigator
//
//  Created by Jonathan Fox on 5/14/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVColorViewController.h"
#import "NAVTableViewController.h"
#import "NAVData.h"

@interface NAVColorViewController ()

@end

@implementation NAVColorViewController
{
    UIView * frame;
    UIView * drawer;
    UIView * tab;
    UIView * tapLocation1;
    UIView * tapLocation2;
    BOOL dragging;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([[NAVData mainData].color isEqual: @"Red"]) {
            self.view.backgroundColor = [UIColor redColor];
        }else if ([[NAVData mainData].color isEqual: @"Yellow"]) {
            self.view.backgroundColor = [UIColor yellowColor];
        }else if ([[NAVData mainData].color isEqual: @"Green"]) {
            self.view.backgroundColor = [UIColor greenColor];
        }else if ([[NAVData mainData].color isEqual: @"Blue"]) {
            self.view.backgroundColor = [UIColor blueColor];
        }
        
        drawer = [[UIView alloc]initWithFrame:CGRectMake(-75, 44, 75, self.view.frame.size.height-44)];
        drawer.backgroundColor = [UIColor darkGrayColor];
        
        tab = [[UIView alloc]initWithFrame:CGRectMake(75, 5, 15, 40)];
        tab.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        [drawer addSubview:tab];
        
        tapLocation1 = [[UIView alloc]initWithFrame:CGRectMake(0, 49, 15, 40)];
        tapLocation1.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tapLocation1];
        
        tapLocation2 = [[UIView alloc]initWithFrame:CGRectMake(75, 49, 15, 40)];
        tapLocation2.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tapLocation2];
        
        
        UIButton * circleButton = [[UIButton alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-30, 23.2, 60, 60)];
        circleButton.backgroundColor = [UIColor cyanColor];
        [circleButton addTarget:self action:@selector(addCircle) forControlEvents:UIControlEventTouchUpInside];
        [drawer addSubview:circleButton];
        
        UIButton * squareButton = [[UIButton alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-30, 126.4, 60, 60)];
        squareButton.backgroundColor = [UIColor orangeColor];
        [squareButton addTarget:self action:@selector(addSquare) forControlEvents:UIControlEventTouchUpInside];
        [drawer addSubview:squareButton];
        
        UIButton * triangleButton = [[UIButton alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-30, 229.6, 60, 60)];
        triangleButton.backgroundColor = [UIColor purpleColor];
        [triangleButton addTarget:self action:@selector(addTriangle) forControlEvents:UIControlEventTouchUpInside];
        [drawer addSubview:triangleButton];
        
        UIButton * diamondButton = [[UIButton alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-30, 332.8, 60, 60)];
        diamondButton.backgroundColor = [UIColor magentaColor];
        [diamondButton addTarget:self action:@selector(addDiamond) forControlEvents:UIControlEventTouchUpInside];
        [drawer addSubview:diamondButton];
        
        frame = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.view.frame.size.height/2-75, 150, 150)];
        frame.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        
        [self.view addSubview:frame];
    }
    return self;
}

- (void)addCircle
{
    UIView * circleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    circleView.backgroundColor = [UIColor cyanColor];
    [frame addSubview:circleView];
    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         
         drawer.frame = CGRectMake(-75, 44, 75, self.view.frame.size.height-44);
     } completion:^(BOOL finished) {
         
     }];
}

- (void)addSquare
{
    UIView * squareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    squareView.backgroundColor = [UIColor orangeColor];
    [frame addSubview:squareView];
    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         
         drawer.frame = CGRectMake(-75, 44, 75, self.view.frame.size.height-44);
     } completion:^(BOOL finished) {
         
     }];
}

- (void)addTriangle
{
    UIView * triangleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    triangleView.backgroundColor = [UIColor purpleColor];
    [frame addSubview:triangleView];
    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         
         drawer.frame = CGRectMake(-75, 44, 75, self.view.frame.size.height-44);
     } completion:^(BOOL finished) {
         
     }];
}

- (void)addDiamond
{
    UIView * diamondView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    diamondView.backgroundColor = [UIColor magentaColor];
    [frame addSubview:diamondView];
    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         
         drawer.frame = CGRectMake(-75, 44, 75, self.view.frame.size.height-44);
     } completion:^(BOOL finished) {
         
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    UIBarButtonItem * exitButton = [[UIBarButtonItem alloc]initWithTitle:@"Exit" style:UIBarButtonItemStylePlain target:self action:@selector(exit)];
//    self.navigationItem.rightBarButtonItem = exitButton;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.view addGestureRecognizer:tap];
}

-(void)exit
{
//     NAVTableViewController * tvc = [[NAVTableViewController alloc]initWithNibName:nil bundle:nil];
//     [self.navigationController pushViewController:tvc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];

//    self.navigationItem.hidesBackButton = YES;
    self.navigationController.toolbarHidden = YES;

}

- (void)viewDidAppear:(BOOL)animated
{
    [self.view addSubview:drawer];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [drawer removeFromSuperview];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];    
    
    if (CGRectContainsPoint(tapLocation1.frame, location))    {

    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
         
    drawer.frame = CGRectMake(0, 44, 75, self.view.frame.size.height-44);
     } completion:^(BOOL finished) {
         
     }];
    }else{
        if (CGRectContainsPoint(tapLocation2.frame, location))    {
            
            [UIView animateWithDuration:0.3 delay:0.0 options:
             UIViewAnimationOptionCurveEaseInOut animations:^{
                 
                 drawer.frame = CGRectMake(-75, 44, 75, self.view.frame.size.height-44);
             } completion:^(BOOL finished) {
                 
             }];
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    
    [[UIColor lightGrayColor] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.6);
    
    CGContextClearRect(context, rect);
    
    //    [self.tintColor set];
    
    CGContextMoveToPoint(context, 1, 1);
    CGContextAddLineToPoint(context, 19, 19);
    
    CGContextMoveToPoint(context, 1, 19);
    CGContextAddLineToPoint(context, 19, 1);
    
    CGContextStrokePath(context);
    
    [[UIColor blueColor] set];
        
    
    CGContextStrokePath(context);
}

-(BOOL)prefersStatusBarHidden{return YES;}


@end
