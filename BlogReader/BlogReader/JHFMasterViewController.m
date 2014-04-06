//
//  JHFMasterViewController.m
//  BlogReader
//
//  Created by Jonathan Fox on 4/4/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFMasterViewController.h"

#import "JHFDetailViewController.h"


@implementation JHFMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titlesArray = @[@"Getting started with WordPress",
                         @"Whitespace in the Web Design: What it is and Why You Should Use it",
                         @"Adaptive Images and Responsive SVGx - Treehouse Show Episode 15",
                         @"Productivity is about restraints and Concentration",
                         @"A Guide to Becoming the Smartest Developer On The Planet",
                         @"Teacher Spotlight: Zac Gardon",
                         @"Do You Love What You Do?",
                         @"Applying Normalize.css Reset - Quick Tip",
                         @"How I Wrote a Book In 3 Days",
                         @"Responsive Techniques, Javascript MVC Frameworks, Firefox 16 | Treehouse Episode 14"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *object = self.titlesArray[indexPath.row];
    cell.textLabel.text = object;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setDetailItem:self.titlesArray[indexPath.row]];
    }
}

@end
