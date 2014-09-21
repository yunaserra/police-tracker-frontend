//
//  IncidentViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import "IncidentViewController.h"

@interface IncidentViewController ()

@end

@implementation IncidentViewController

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
}

- (IBAction) officerButtonClicked : (id) sender
{
    NSString *identifier = @"cop";
    [self performSegueWithIdentifier:identifier sender:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
