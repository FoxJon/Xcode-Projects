//
//  NAVTableViewController.m
//  Navigator
//
//  Created by Jonathan Fox on 5/14/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "NAVTableViewController.h"
#import "NAVTableViewCell.h"
#import "NAVColorViewController.h"
#import "NAVNumberViewController.h"
#import "NAVData.h"

@interface NAVTableViewController ()

@end

@implementation NAVTableViewController
{
    UINavigationController * navController;
    NSArray * colors;
    NSArray * numbers;
    
    NSArray * selectedArray;
    
//    BOOL colorsIsSelected;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.rowHeight = 80;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
        self.navigationController.toolbarHidden = NO;
        
//        colorsIsSelected = YES;
        
        colors = @[@"Red", @"Yellow", @"Green", @"Blue"];
        numbers = @[@"One", @"Thirty-two", @"Fourty", @"One Hundred"];
        
        selectedArray = colors;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    //self.clearsSelectionOnViewWillAppear = NO;
}


-(void)loadColorDetailView
{
    NAVColorViewController * cvc = [[NAVColorViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:cvc animated:YES];
//    CATransition* transition = [CATransition animation];
//    transition.duration = .45;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
}

-(void)loadNumberDetailView
{
    NAVNumberViewController * nvc = [[NAVNumberViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:nvc animated:YES];
//    CATransition* transition = [CATransition animation];
//    transition.duration = .45;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];

    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.toolbarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    UIBarButtonItem * button1 = [[UIBarButtonItem alloc]initWithTitle:@"Colors" style:UIBarButtonItemStylePlain target:self action:@selector(loadList:)];
    [self.navigationController.toolbar setItems:@[button1] animated:YES];
    
    UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithTitle:@"Numbers" style:UIBarButtonItemStylePlain target:self action:@selector(loadList:)];
    [self.navigationController.toolbar setItems:@[button1, button2] animated:YES];
    
    UIBarButtonItem * flexible = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [self.navigationController.toolbar setItems:@[flexible, button1, flexible, button2, flexible] animated:YES];
}

-(void)loadList:(UIBarButtonItem *)sender
{
    // will return true if Colors else return false if Numbers
//    colorsIsSelected = [sender.title isEqualToString:@"Colors"];
    
    if ([sender.title isEqualToString:@"Colors"]) {
        selectedArray = colors;
    }else{
        selectedArray = numbers;
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [selectedArray count];
    
    // Return the number of rows in the section.
//    if (colorsIsSelected) {
//        return [colors count];
//    }else{
//        return [numbers count];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NAVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // Configure the cell...
    
    if (cell==nil) {
        cell = [[NAVTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    cell.textLabel.text = selectedArray[indexPath.row];
    
    if ([cell.textLabel.text isEqualToString:@"Red"]) {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor redColor];
    } else if ([cell.textLabel.text isEqualToString:@"Yellow"]){
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor yellowColor];
    } else if ([cell.textLabel.text isEqualToString:@"Green"]){
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor greenColor];
    } else if ([cell.textLabel.text isEqualToString:@"Blue"]){
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor blueColor];
    }else if (![cell.textLabel.text isEqualToString:@"Blue"]){
        cell.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.02];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
    if ([selectedArray[0] isEqualToString:@"Red"])
    {
        NSString * chosenColor = cell.textLabel.text;
        [NAVData mainData].color = chosenColor;
        [self loadColorDetailView];
    }else{
        NSString * chosenNumber = cell.textLabel.text;
        [NAVData mainData].number = chosenNumber;
        [self loadNumberDetailView];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
