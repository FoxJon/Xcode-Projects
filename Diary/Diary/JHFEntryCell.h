//
//  JHFEntryCell.h
//  Diary
//
//  Created by Jonathan Fox on 7/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHFDiaryEntry;

@interface JHFEntryCell : UITableViewCell

+ (CGFloat)heightForEntry:(JHFDiaryEntry *)entry;

-(void)configureCellForEntry:(JHFDiaryEntry *)entry;

@end
