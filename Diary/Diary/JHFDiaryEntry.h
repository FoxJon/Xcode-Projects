//
//  JHFDiaryEntry.h
//  Diary
//
//  Created by Jonathan Fox on 7/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ENUM(int16_t, JHFDiaryEntryMood){
    JHFDiaryEntryMoodGood = 0,
    JHFDiaryEntryMoodAverage = 1,
    JHFDiaryEntryMoodBad = 2
};

@interface JHFDiaryEntry : NSManagedObject

@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSData * image;
@property (nonatomic) int16_t mood;
@property (nonatomic, retain) NSString * location;

@property (nonatomic, readonly) NSString * sectionName;


@end
