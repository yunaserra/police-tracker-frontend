//
//  IncidentViewController.h
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface IncidentViewController : UIViewController
{
    IBOutlet UILabel *excellence;
    IBOutlet UILabel *harmReduction;
    IBOutlet UILabel *service;
    IBOutlet UILabel *humilty;
    IBOutlet UILabel *justice;
    IBOutlet UILabel *respect;
    IBOutlet UILabel *professional;
    
    IBOutlet UIButton *officerButton;
    IBOutlet UITextView *descriptionView;
    IBOutlet UIButton *reportBtn;
    IBOutlet UIButton *twitterBtn;
    IBOutlet UIButton *fbButton;
    IBOutlet UIButton *addCommentBtn;
    
    PFObject *incidentReport;
    PFObject *cop;
}

- (void)setIncidentReportObject:(PFObject*)incidentReport;
- (IBAction) officerButtonClicked : (id) sender;

@end
