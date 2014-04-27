//
//  InboxViewController.h
//  Ribbit
//
//  Created by Jonathan Fox on 4/26/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface InboxViewController : UITableViewController

@property (nonatomic, strong)NSArray *messages;
@property (nonatomic, strong)PFObject *selectedMessage;

- (IBAction)logOut:(id)sender;
@end
