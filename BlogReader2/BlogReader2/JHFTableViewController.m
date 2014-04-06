//
//  JHFTableViewController.m
//  BlogReader2
//
//  Created by Jonathan Fox on 4/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFTableViewController.h"
#import "JHFBlogPost.h"
#import "JHFWebViewController.h"

@interface JHFTableViewController ()

@end

@implementation JHFTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *blogURL = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
    
    NSData * jsonData = [NSData dataWithContentsOfURL:blogURL];
    
    NSError *error = nil;
    
    NSDictionary * dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    self.blogPosts = [NSMutableArray array];
    
    NSArray * blogPostsArray = [dataDictionary objectForKey:@"posts"];
    
    for (NSDictionary *bpDictionary in blogPostsArray) {
        JHFBlogPost *blogPost = [JHFBlogPost blogPostWithTitle:[bpDictionary objectForKey:@"title"]];
        blogPost.author = [bpDictionary objectForKey:@"author"];
        blogPost.thumbnail = [bpDictionary objectForKey:@"thumbnail"];
        blogPost.date = [bpDictionary objectForKey:@"date"];
        blogPost.url = [NSURL URLWithString:[bpDictionary objectForKey:@"url"]];
        [self.blogPosts addObject:blogPost];
    }    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.blogPosts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    JHFBlogPost * blogPost = [self.blogPosts objectAtIndex:indexPath.row];
    
   
    if ([blogPost.thumbnail isKindOfClass:[NSString class]]) {
        NSData * imageData = [NSData dataWithContentsOfURL:blogPost.thumbnailURL];
        UIImage * image = [UIImage imageWithData:imageData];
        cell.imageView.image = image;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"JonFox.png"];
    }
    
    cell.textLabel.text = blogPost.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", blogPost.author, [blogPost formattedDate]];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"preparing for segue: %@:", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"showBlogPost"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JHFBlogPost * blogPost = [self.blogPosts objectAtIndex:indexPath.row];

        [segue.destinationViewController setBlogPostURL:blogPost.url];
    }
}





//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    JHFBlogPost * blogPost = [self.blogPosts objectAtIndex:indexPath.row];
//    UIApplication *application = [UIApplication sharedApplication];
//    [application openURL:blogPost.url];
//}




@end
