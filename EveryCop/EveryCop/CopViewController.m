//
//  CopViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import "CopViewController.h"
#import "CustomIncidentListCellTableViewCell.h"

@interface CopViewController ()

@end

@implementation CopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [interactionTable setDataSource:self];
    [interactionTable setDelegate:self];
    
    UIImage *img = [UIImage imageNamed:@"Seattle-police-shield.png"];
    copPhoto.image = img;
    
    nameLabel.text = [cop objectForKey:@"Name"];
    badgeLabel.text = [cop objectForKey:@"Badge"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *incidentTableIdentifier = @"IncidentCell";
    
    CustomIncidentListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:incidentTableIdentifier];
    
    if (cell == nil) {
        cell = [[CustomIncidentListCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:incidentTableIdentifier];
    }
    
    int posNeg = arc4random() % 2;
    NSString *name = @"Positive";
    if (posNeg == 0)
    {
        name = @"Negative";
    }
    
    int month = arc4random() % 12 + 1;
    int day = arc4random() % 28 + 1;
    int year = arc4random() % 4 + 2010;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %02i/%02i/%i", name, month, day, year];
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)setCopObject:(PFObject *)copObj
{
    self->cop = copObj;
}

@end
