//
//  PSSTableViewCell.m
//  Piano Simon Says
//
//  Created by Jonathan Fox on 6/6/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PSSTableViewCell.h"

@implementation PSSTableViewCell
{
    UIImageView * lockImageView;
    UILabel * songTitle;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 10, 15, 15)];
        [self.contentView addSubview:lockImageView];
        
        songTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 40)];
        songTitle.textColor = [UIColor blackColor];
        songTitle.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
       // songTitle.highlightedTextColor = [UIColor blueColor];
        
        [self.contentView addSubview:songTitle];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSongInfo:(NSDictionary *)songInfo
{
    _songInfo = songInfo;
    
    if([songInfo[@"locked"] isEqual: @"Yes"])
    {
      lockImageView.image = [UIImage imageNamed:@"lock"];
    }else{
        lockImageView.image = nil;
    }
    
    NSLog(@"%@",songInfo[@"title"]);
    
    songTitle.text = songInfo[@"title"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
