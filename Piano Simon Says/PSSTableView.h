//
//  PSSTableView.h
//  Piano Simon Says
//
//  Created by Jonathan Fox on 5/29/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tableViewProtocol;

@interface PSSTableView : PSSPianoViewController

@end

@protocol tableViewProtocol <NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
