//
//  CopReportViewController.h
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 EveryCop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CopReportViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *badgeLabel;
    
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *label3;
    IBOutlet UILabel *label4;
    IBOutlet UILabel *label5;
    IBOutlet UILabel *label6;
    
    IBOutlet UITableView *interactionTable;
    
    IBOutlet UIImageView *copPhoto;
    
    PFObject *cop;
}

- (void)setCopObject:(PFObject*)copObj;

@end
