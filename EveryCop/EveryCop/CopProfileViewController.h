//
//  CopProfileViewController.h
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CopProfileViewController : UIViewController
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
    
    IBOutlet UILabel* firstRating;
    IBOutlet UILabel* secondRating;
    IBOutlet UILabel* thirdRating;
    IBOutlet UILabel* fourthRating;
    IBOutlet UILabel* fifthRating;
    
}

- (IBAction)valueChanged:(id)sender;
- (IBAction)finishedTyping:(id)sender;

@end
