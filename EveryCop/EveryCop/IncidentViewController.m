//
//  IncidentViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import "IncidentViewController.h"
#import "CopViewController.h"

@interface IncidentViewController ()

@end

@implementation IncidentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    descriptionView.layer.borderWidth = 1.0f;
    descriptionView.layer.borderColor = officerButton.backgroundColor.CGColor;
    
    officerButton.layer.cornerRadius = 10;
    officerButton.layer.borderWidth = 1;
    
    addCommentBtn.layer.cornerRadius = 10;
    addCommentBtn.layer.borderWidth = 1;
    
    reportBtn.layer.cornerRadius = 10;
    reportBtn.layer.borderWidth = 1;
    
    UIImage *img = [UIImage imageNamed:@"fbLogo.png"];
    fbButton.imageView.image = img;
    
    img = [UIImage imageNamed:@"Twitter_logo_blue.png"];
    twitterBtn.imageView.image = img;
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
    
    officerButton.enabled = false;
    officerButton.userInteractionEnabled = false;
    officerButton.titleLabel.text = @"Loading Cop...";
    
    PFQuery* query = [PFQuery queryWithClassName:@"Cop"];
    PFObject *object =[incidentReport objectForKey:@"Cop"];
    [query whereKey:@"objectId" equalTo:object.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil && [objects count] > 0)
        {
            cop = [objects firstObject];
            officerButton.enabled = true;
            officerButton.userInteractionEnabled = true;
            NSString * str = [NSString stringWithFormat:@"Show More of Officer %@", [cop objectForKey:@"Name"]];
            [officerButton setTitle:str forState:UIControlStateNormal];
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
        CopViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setCopObject:cop];
    }
}

- (void)setIncidentReportObject:(PFObject*)newIncidentReport
{
    self->incidentReport = newIncidentReport;
}

@end
