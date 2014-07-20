//
//  JHFNewEntryViewController.m
//  Diary
//
//  Created by Jonathan Fox on 7/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFEntryViewController.h"
#import "JHFDiaryEntry.h"
#import "JHFCoreDataStack.h"

@interface JHFEntryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation JHFEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.entry != nil) {
        self.textField.text = self.entry.body;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissSelf
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertDiaryEntry
{
    JHFCoreDataStack * coreDataStack = [JHFCoreDataStack defaultStack];
    JHFDiaryEntry * entry = [NSEntityDescription insertNewObjectForEntityForName:@"JHFDiaryEntry"  inManagedObjectContext:coreDataStack.managedObjectContext];
    entry.body = self.textField.text;
    entry.date = [[NSDate date]timeIntervalSince1970];
    [coreDataStack saveContext];
}

- (void)updateDiaryEntry{
    self.entry.body = self.textField.text;
    
    JHFCoreDataStack * coreDataStack = [JHFCoreDataStack defaultStack];
    [coreDataStack saveContext];
}


- (IBAction)doneWasPressed:(id)sender {
    if (self.entry != nil) {
        [self updateDiaryEntry];
    }else{
    [self insertDiaryEntry];
    }
    [self dismissSelf];
}
- (IBAction)cancelWasPressed:(id)sender {
    [self dismissSelf];
}


@end
