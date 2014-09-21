//
//  CopProfileViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import "CopProfileViewController.h"


@interface CopProfileViewController ()

@end

@implementation CopProfileViewController

- (void)viewDidAppear:(BOOL)animated
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [locationManager stopUpdatingLocation];
    locationManager = nil;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation* location = [locations objectAtIndex:0];
    currentLocation = [location coordinate];
}

- (IBAction)valueChanged:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    int value = slider.value * 10;
    
    switch(slider.tag)
    {
        case 1:
            firstRating.text = [NSString stringWithFormat:@"%i", value];
            break;
        case 2:
            secondRating.text = [NSString stringWithFormat:@"%i", value];
            break;
        case 3:
            thirdRating.text = [NSString stringWithFormat:@"%i", value];
            break;
        case 4:
            fourthRating.text = [NSString stringWithFormat:@"%i", value];
            break;
        case 5:
            fifthRating.text = [NSString stringWithFormat:@"%i", value];
            break;
        case 6:
            sixthRating.text = [NSString stringWithFormat:@"%i", value];
            break;
        case 7:
            seventhRating.text = [NSString stringWithFormat:@"%i", value];
            break;
        default:
            break;
    }
}

- (IBAction)finishedTyping:(id)sender
{
    UITextField *textField = (UITextField*)sender;
    NSString* key = nil;
    
    if (textField.tag == 0)
    {
        key = @"Name";
    }
    else if (textField.tag == 1)
    {
        key = @"Badge";
    }
    else
    {
        return;
    }
    
    copName.enabled = false;
    copName.userInteractionEnabled = false;
    copBadgeNumber.enabled = false;
    copBadgeNumber.userInteractionEnabled = false;
    
    PFQuery * query = [PFQuery queryWithClassName:@"Cop"];
    [query whereKey:key equalTo:textField.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error != nil || [objects count] == 0)
        {
            copBadgeNumber.text = @"";
            copName.text = @"";
        }
        else
        {
            toSave = (PFObject*)[objects firstObject];
            if (textField.tag == 0)
            {
                copBadgeNumber.text = [(PFObject*)[objects firstObject] objectForKey:@"Badge"];
            }
            else
            {
                copName.text = [(PFObject*)[objects firstObject] objectForKey:@"Name"];
            }
        }
        
        copName.enabled = true;
        copName.userInteractionEnabled = true;
        copBadgeNumber.enabled = true;
        copBadgeNumber.userInteractionEnabled = true;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    firstSlider.tag = 1;
    secondSlider.tag = 2;
    thirdSlider.tag = 3;
    fourthSlider.tag = 4;
    fifthSlider.tag = 5;
    sixthSlider.tag = 6;
    seventhSlider.tag = 7;
    
    attachPhotoBtn.layer.cornerRadius = 10;
    attachPhotoBtn.layer.borderWidth = 1;
    attachButton.layer.borderColor = attachButton.backgroundColor.CGColor;
    
    submitBtn.layer.cornerRadius = 10;
    submitBtn.layer.borderWidth = 1;
    submitBtn.layer.borderColor = attachButton.backgroundColor.CGColor;
    
    description.delegate = self;
    description.layer.borderWidth = 1.0f;
    description.layer.borderColor = attachPhotoBtn.backgroundColor.CGColor;
    
    copName.delegate = self;
    copBadgeNumber.delegate = self;
    
    slider.tintColor = submitBtn.backgroundColor;
    [slider setOnTintColor:submitBtn.backgroundColor];
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 600);
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    ptToScroll = scrollView.contentOffset;
    
    CGPoint pt;
    CGRect rect = [textField bounds];
    rect = [textField convertRect:rect toView:scrollView];
    
    pt = rect.origin;
    pt.x = 0;
    pt.y -= 60;
    
    [scrollView setContentOffset:pt animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:ptToScroll animated:YES];
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)submitReport:(id)sender
{
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:currentLocation.latitude
                                                  longitude:currentLocation.longitude];
    
    PFObject *incidentData = [PFObject objectWithClassName:@"IncidentReport"];
    {
        incidentData[@"Description"] = description.text;
        incidentData[@"Time"] = [NSDate date];
        incidentData[@"Location"] = geoPoint;
        incidentData[@"Excellence"] = [NSNumber numberWithFloat:firstSlider.value];
        incidentData[@"HarmReduction"] = [NSNumber numberWithFloat:secondSlider.value];
        incidentData[@"Service"] = [NSNumber numberWithFloat:thirdSlider.value];
        incidentData[@"Humility"] = [NSNumber numberWithFloat:fourthSlider.value];
        incidentData[@"Justice"] = [NSNumber numberWithFloat:fifthSlider.value];
        incidentData[@"Respect"] = [NSNumber numberWithFloat:sixthSlider.value];
        incidentData[@"Professional"] = [NSNumber numberWithFloat:seventhSlider.value];
        incidentData[@"Cop"] = toSave;
    }
    [incidentData saveInBackground];
    
    //Move back to map screen
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return FALSE;
    }
    return TRUE;
}

@end
