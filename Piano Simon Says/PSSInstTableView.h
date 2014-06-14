//
//  PSSInstTableView.h
//  Piano Says
//
//  Created by Jonathan Fox on 6/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSPianoViewController.h"

@protocol instTableViewProtocol <NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PSSInstTableView : PSSPianoViewController

@end
