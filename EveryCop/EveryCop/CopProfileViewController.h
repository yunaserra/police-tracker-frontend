//
//  CopProfileViewController.h
// This is supposed to be for SUBMIT report, not profile view
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CopProfileViewController : UIViewController<UITextViewDelegate>
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
    IBOutlet UIButton* attachPhotoBtn;
    IBOutlet UIButton* attachVideoBtn;
    
    
    PFObject *toSave;
}

- (IBAction)valueChanged:(id)sender;
- (IBAction)finishedTyping:(id)sender;
- (IBAction)submitReport:(id)sender;

@end
