//
//  IncidentReportViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 EveryCop. All rights reserved.
//

#import "IncidentReportViewController.h"
#import "CopReportViewController.h"

@implementation IncidentReportViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    officerButton.layer.cornerRadius = 10;
    officerButton.layer.borderWidth = 1;
    officerButton.layer.borderColor = officerButton.backgroundColor.CGColor;
    
    addCommentBtn.layer.cornerRadius = 10;
    addCommentBtn.layer.borderWidth = 1;
    addCommentBtn.layer.borderColor = officerButton.backgroundColor.CGColor;
    
    reportBtn.layer.cornerRadius = 10;
    reportBtn.layer.borderWidth = 1;
    reportBtn.layer.borderColor = officerButton.backgroundColor.CGColor;
    
    descriptionView.text = [incidentReport objectForKey:@"Description"];
    
    excellence.text = [NSString stringWithFormat:@"%i/10",
                       (int)([[incidentReport objectForKey:@"Excellence"] floatValue] * 10)];
    
    harmReduction.text = [NSString stringWithFormat:@"%i/10",
                       (int)([[incidentReport objectForKey:@"HarmReduction"] floatValue] * 10)];
    
    service.text = [NSString stringWithFormat:@"%i/10",
                       (int)([[incidentReport objectForKey:@"Service"] floatValue] * 10)];
    
    humilty.text = [NSString stringWithFormat:@"%i/10",
                       (int)([[incidentReport objectForKey:@"Humility"] floatValue] * 10)];
    
    justice.text = [NSString stringWithFormat:@"%i/10",
                       (int)([[incidentReport objectForKey:@"Justice"] floatValue] * 10)];
    
    respect.text = [NSString stringWithFormat:@"%i/10",
                       (int)([[incidentReport objectForKey:@"Respect"] floatValue] * 10)];
    
    professional.text = [NSString stringWithFormat:@"%i/10",
                       (int)([[incidentReport objectForKey:@"Professional"] floatValue] * 10)];
    
    
    PFQuery* query = [PFQuery queryWithClassName:@"Cop"];
    PFObject *object =[incidentReport objectForKey:@"Cop"];
    [query whereKey:@"objectId" equalTo:object.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil && [objects count] > 0)
        {
            cop = [objects firstObject];
        }
    }];
}

- (IBAction) officerButtonClicked : (id) sender
{
    NSString *identifier = @"cop";
    [self performSegueWithIdentifier:identifier sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"cop"])
    {
        // Get reference to the destination view controller
        CopReportViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setCopObject:cop];
    }
}

- (void)setIncidentReportObject:(PFObject*)newIncidentReport
{
    self->incidentReport = newIncidentReport;
}

- (IBAction)facebookEnable:(id)sender
{
    
}

- (IBAction)twitterEnable:(id)sender
{
    
}

@end
