//
//  IncidentSubmissionViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 EveryCop. All rights reserved.
//

#import "IncidentSubmissionViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@implementation IncidentSubmissionViewController

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
    UISlider *inner_slider = (UISlider*)sender;
    int value = inner_slider.value * 10;
    
    switch(inner_slider.tag)
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
    
    attachPhotoVideoBtn.layer.cornerRadius = 10;
    attachPhotoVideoBtn.layer.borderWidth = 1;
    attachButton.layer.borderColor = attachButton.backgroundColor.CGColor;
    
    submitBtn.layer.cornerRadius = 10;
    submitBtn.layer.borderWidth = 1;
    submitBtn.layer.borderColor = attachButton.backgroundColor.CGColor;
    
    description.delegate = self;
    description.layer.borderWidth = 1.0f;
    description.layer.borderColor = attachPhotoVideoBtn.backgroundColor.CGColor;
    
    copName.delegate = self;
    copBadgeNumber.delegate = self;
    
    slider.tintColor = submitBtn.backgroundColor;
    [slider setOnTintColor:submitBtn.backgroundColor];
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 1000);
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
        incidentData[@"MediaFile"] = imageFile;
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

- (IBAction)takePhotoVideo:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    
    [self presentViewController:picker animated:YES completion:NULL];

}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get the type of media
    NSString *media = info[UIImagePickerControllerMediaType];
    
    //media is a movie
    if ([media isEqualToString:(NSString*)kUTTypeMovie])
    {
        NSData *data = [NSData dataWithContentsOfURL:info[UIImagePickerControllerMediaURL]];
        
        imageFile = [PFFile fileWithName:@"movie.mov" data:data];
        
    }
    else if ([media isEqualToString:(NSString*)kUTTypeImage])
    {
        UIImage *img = info[UIImagePickerControllerEditedImage];
        //resize to 1/4 of original size
        CGSize compressedSize = CGSizeMake(img.size.width / 4, img.size.height / 4);
        
        UIGraphicsBeginImageContext(compressedSize);
        [img drawInRect:CGRectMake(0, 0, compressedSize.width, compressedSize.height)];
        UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *data = UIImagePNGRepresentation(newImg);
        
        imageFile = [PFFile fileWithName:@"pict.png" data:data];
        
    }
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //self.imageView.image = chosenImage;
    
    //Pulls out PNG data of the chosen image
    NSData *pngData = UIImagePNGRepresentation(chosenImage);
    
    //Write PNG data to a file
    //NSString *filePath = [ViewController getFilePath:@"imageTest.png"];
    //[pngData writeToFile:filePath atomically:YES];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
