//
//  CopReportViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import "CopReportViewController.h"
#import "LandingPageListTableViewCell.h"

@implementation CopReportViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [interactionTable setDataSource:self];
    [interactionTable setDelegate:self];
    
    UIImage *img = [UIImage imageNamed:@"Seattle-police-shield.png"];
    copPhoto.image = img;
    
    nameLabel.text = [cop objectForKey:@"Name"];
    badgeLabel.text = [cop objectForKey:@"Badge"];
    
    if ([badgeLabel.text isEqualToString:@"7522"])
    {
        img = [UIImage imageNamed:@"coptest.PNG"];
        copPhoto.image = img;
    }
    
    float totalRating = 0.0f;
    int rate = arc4random() % 10;
    label1.text = [NSString stringWithFormat:@"%i%@", rate, @" / 10"];
    totalRating += rate;
    
    rate = arc4random() % 10;
    label2.text = [NSString stringWithFormat:@"%i%@", rate, @" / 10"];
    totalRating += rate;
    
    rate = arc4random() % 10;
    label3.text = [NSString stringWithFormat:@"%i%@", rate, @" / 10"];
    totalRating += rate;
    
    rate = arc4random() % 10;
    label4.text = [NSString stringWithFormat:@"%i%@", rate, @" / 10"];
    totalRating += rate;
    
    rate = arc4random() % 10;
    label5.text = [NSString stringWithFormat:@"%i%@", rate, @" / 10"];
    totalRating += rate;
    
    rate = arc4random() % 10;
    label6.text = [NSString stringWithFormat:@"%i%@", rate, @" / 10"];
    totalRating += rate;
    
    //convert to %
    totalRating = (totalRating / 60.0f) * 100.0f;
    
    averageRating.text = [NSString stringWithFormat:@"%.0f%%", totalRating];
    [averageRating setFont:[UIFont boldSystemFontOfSize:18.0f]];
    if (totalRating <= 40.0f)
    {
        //color it red
        averageRating.textColor = [UIColor redColor];
    }
    else if (totalRating <= 80.0f)
    {
        averageRating.textColor = [UIColor colorWithRed:209/255.0f
                                                  green:199.0f/255.0f
                                                   blue:59/255.0f alpha:1.0f];
    }
    else
    {
        averageRating.textColor = [UIColor colorWithRed:0.0f green:153/255.0f blue:0.0f alpha:1.0f];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *incidentTableIdentifier = @"IncidentCell";
    
    LandingPageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:incidentTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[LandingPageListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:incidentTableIdentifier];
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
