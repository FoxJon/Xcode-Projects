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
    NSArray * colors;
    NSDictionary * colorDictionary1;
    NSDictionary * colorDictionary2;

    NSDictionary * faces;
    
    int chosenColorIndex;
    int chosenFaceIndex;
}

- (NSDictionary *)returnChosenFace
{
    return colors[chosenColorIndex][@"faces"][chosenFaceIndex];  //use singleton to grab these
}

-(void)addFace:(NSDictionary *)face WithColor:(int)colorIndex
{
    [colors[colorIndex][@"faces"] addObject:face];
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
    
    [self setUpArchitecture];
    
    [self createColors];

}

- (void)setUpArchitecture
{
    colorDictionary1 = [@{
                    @"yellow": @"image1",
                    @"yellow": @"image2"
                    }mutableCopy];
    
    faces = @{
               @"yellow": @[@"face1", @"face2"],
               @"red": @[@"face1", @"face2"],
               };
   //////////////////////////////////////////////////////////////
   //////////////////////////////////////////////////////////////
    
//NSDictionary * face = colors[0][@"faces"][1][@"image"];
    
   colors = @[                          //array with nine dictionaries
             @{                         //key is always a string
                @"color": @"yellow",
                @"image": @"colors0",
                @"faces": @[
                           @{
                               @"emotion": @"happy",
                               @"image" : @"yellow0"
                            },
                           @{
                               @"emotion": @"sad",
                               @"image" : @"yellow1"
                               },
                           ]
                },
             @{
                 @"color": @"red",
                 @"image": @"colors0",
                 },
             @{
                 @"color": @"blue",
                 @"image": @"colors1",
                 },
             @{
                 @"color": @"green",
                 @"image": @"colors2",
                },
             @{
                 @"color": @"orange",
                 @"image": @"colors3",
                 },
             @{
                 @"color": @"purple",
                 @"image": @"colors4",
                 },
             @{  @"color": @"pink",
                 @"image": @"colors5",
                 },
             @{
                 @"color": @"cyan",
                 @"image": @"colors6",
                 },
             @{
                 @"color": @"teal",
                 @"image": @"colors7",
                 }
             ];
    
    colorDictionary2 = @{
                        @"yellow": @{
                             @"image": @"colors0",
                             @"faces": @[
                                     @{
                                         @"emotion": @"happy",
                                         @"image" : @"yellow0"
                                         },
                                     @{
                                         @"emotion": @"happy",
                                         @"image" : @"yellow0"
                                         },
                                 ]
                         },
                        @"yellow": @{
                                @"image": @"colors0",
                                @"faces": @[
                                        @{
                                            @"emotion": @"happy",
                                            @"image" : @"yellow0"
                                            },
                                        @{
                                            @"emotion": @"happy",
                                            @"image" : @"yellow0"
                                            },
                                        ]
                                }
                        };
}

-(void)createColors
{
    NSString * yellowKey = [colorDictionary2 allKeys][0];
    NSDictionary * yellowColor = colorDictionary2[yellowKey];
    
    for (NSString * key in [colorDictionary2 allKeys])
    {
        NSDictionary * color = colorDictionary2[key];
        
        NSLog(@"%@", color);
    }
    
    
    for (NSDictionary * color in colors) {
        NSString * imageFileName = color[@"image"];
 //       imageFileName = [color objectForKey:@"image"]; //slow way

        NSLog(@"image file: %@", imageFileName);
        
        [self createFacesWithColorDictionary:color];
        
//        UIImage * colorImage = [UIImage imageNamed:imageFileName];
    }
    
    NSDictionary * face = colors[0][@"faces"][1][@"image"];
    NSLog(@"face: %@", face);
}

-(void)createFacesWithColor:(NSString * )color
{
    NSArray * faces = colorDictionary2[color][@"faces"];
    
    for (NSDictionary * face in faces) {
        NSLog(@"%@", face);
    }
}

-(void)createFacesWithColorDictionary:(NSDictionary * )color
{
    NSArray * faces = color[@"faces"];
    for (NSDictionary * face in faces) {
        NSLog(@"%@", face);
    }
    
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
