//
//  IncidentSubmissionViewController.h
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 EveryCop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface IncidentSubmissionViewController : UIViewController<UITextViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UITextField* copName;
    IBOutlet UITextField* copBadgeNumber;
    IBOutlet UITextView* description;
    IBOutlet UIButton* upButton;
    IBOutlet UIButton* downButton;
    IBOutlet UIButton* attachButton;
    
    IBOutlet UISlider* firstSlider;
    IBOutlet UISlider* secondSlider;
    IBOutlet UISlider* thirdSlider;
    IBOutlet UISlider* fourthSlider;
    IBOutlet UISlider* fifthSlider;
    IBOutlet UISlider* sixthSlider;
    IBOutlet UISlider* seventhSlider;
    
    IBOutlet UILabel* firstRating;
    IBOutlet UILabel* secondRating;
    IBOutlet UILabel* thirdRating;
    IBOutlet UILabel* fourthRating;
    IBOutlet UILabel* fifthRating;
    IBOutlet UILabel* sixthRating;
    IBOutlet UILabel* seventhRating;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton* submitBtn;
    IBOutlet UIButton* attachPhotoVideoBtn;
    
    IBOutlet UISwitch* slider;
    
    
    PFObject *toSave;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentLocation;
    
    CGPoint ptToScroll;
    
    PFFile *imageFile;
}

- (IBAction)valueChanged:(id)sender;
- (IBAction)finishedTyping:(id)sender;
- (IBAction)submitReport:(id)sender;
- (IBAction)takePhotoVideo:(id)sender;

@end
