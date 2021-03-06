//
//  JHFEntryCell.m
//  Diary
//
//  Created by Jonathan Fox on 7/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFEntryCell.h"
#import "JHFDiaryEntry.h"
#import <QuartzCore/QuartzCore.h>

@interface JHFEntryCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *moodImageView;

@end

@implementation JHFEntryCell

+ (CGFloat)heightForEntry:(JHFDiaryEntry *)entry{
    const CGFloat topMargin = 40.0f;
    const CGFloat bottomMargin = 50.0f;
    const CGFloat minHeight = 20.0f;

    UIFont * font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGRect boundingBox = [entry.body boundingRectWithSize:CGSizeMake(212, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil];
    
    return MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);
}

-(void)configureCellForEntry:(JHFDiaryEntry *)entry{
    self.bodyLabel.text = entry.body;
    self.locationLabel.text = entry.location;

    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEEE MMMM d, yyyy"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:entry.date];

    self.dateLabel.text = [dateFormatter stringFromDate:date];

    
    if (entry.image) {
        self.mainImageView.image = [UIImage imageWithData:entry.image];
    }else{
        self.mainImageView.image = [UIImage imageNamed:@"icn_noimage"];
    }
    
    if (entry.mood == JHFDiaryEntryMoodGood) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_happy"];
    }else if (entry.mood == JHFDiaryEntryMoodAverage) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_average"];
    }else if (entry.mood == JHFDiaryEntryMoodBad) {
        self.moodImageView.image = [UIImage imageNamed:@"icn_bad"];
    }
    
    self.mainImageView.layer.cornerRadius = CGRectGetWidth(self.mainImageView.frame)/2.0f;
    
    if (entry.location.length > 0) {
        self.locationLabel.text = entry.location;
    }else{
        self.locationLabel.text = @"No location";
    }
}


@end
