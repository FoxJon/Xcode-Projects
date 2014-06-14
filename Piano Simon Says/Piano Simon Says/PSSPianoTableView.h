//
//  PSSPianoTableView.h
//  Piano Says
//
//  Created by Jonathan Fox on 5/30/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSPianoViewController.h"

@protocol pianoTableViewProtocol <NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PSSPianoTableView : PSSPianoViewController

@end
