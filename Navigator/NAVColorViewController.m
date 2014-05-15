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
{
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
        self.view.backgroundColor = [UIColor whiteColor];
        
        drawer = [[UIView alloc]initWithFrame:CGRectMake(-100, 44, 100, self.view.frame.size.height-44)];
        drawer.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:drawer];
        
        tab = [[UIView alloc]initWithFrame:CGRectMake(100, 5, 15, 40)];
        tab.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        [drawer addSubview:tab];
        
        tapLocation1 = [[UIView alloc]initWithFrame:CGRectMake(0, 49, 15, 40)];
        tapLocation1.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tapLocation1];
        
        tapLocation2 = [[UIView alloc]initWithFrame:CGRectMake(100, 49, 15, 40)];
        tapLocation2.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tapLocation2];
        
        UIView * circle = [[UIView alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-40, 23.2, 80, 80)];
        circle.backgroundColor = [UIColor redColor];
        [drawer addSubview:circle];
        
        UIView * square = [[UIView alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-40, 126.4, 80, 80)];
        square.backgroundColor = [UIColor yellowColor];
        [drawer addSubview:square];
        
        UIView * triangle = [[UIView alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-40, 229.6, 80, 80)];
        triangle.backgroundColor = [UIColor orangeColor];
        [drawer addSubview:triangle];
        
        UIView * diamond = [[UIView alloc]initWithFrame:CGRectMake(drawer.frame.size.width/2-40, 332.8, 80, 80)];
        diamond.backgroundColor = [UIColor greenColor];
        [drawer addSubview:diamond];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:nil action:nil];
//    self.navigationItem.rightBarButtonItem = back;
    self.navigationController.navigationBarHidden = NO;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.view addGestureRecognizer:tap];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.toolbarHidden = YES;

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
         
    drawer.frame = CGRectMake(0, 44, 100, self.view.frame.size.height-44);
     } completion:^(BOOL finished) {
         
     }];
    }else{
        if (CGRectContainsPoint(tapLocation2.frame, location))    {
            
            [UIView animateWithDuration:0.3 delay:0.0 options:
             UIViewAnimationOptionCurveEaseInOut animations:^{
                 
                 drawer.frame = CGRectMake(-100, 44, 100, self.view.frame.size.height-44);
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
