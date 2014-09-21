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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
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
    
    description.delegate = self;
    description.layer.borderWidth = 1.0f;
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 550);
}

- (IBAction)submitReport:(id)sender
{
    PFObject *incidentData = [PFObject objectWithClassName:@"IncidentReport"];
    incidentData[@"Description"] = description.text;
    //excelence, harm reduction, service humilty justie resepect professional
    incidentData[@"Excellence"] = [NSNumber numberWithFloat:firstSlider.value];
    incidentData[@"HarmReduction"] = [NSNumber numberWithFloat:secondSlider.value];
    incidentData[@"Service"] = [NSNumber numberWithFloat:thirdSlider.value];
    incidentData[@"Humility"] = [NSNumber numberWithFloat:fourthSlider.value];
    incidentData[@"Justice"] = [NSNumber numberWithFloat:fifthSlider.value];
    incidentData[@"Respect"] = [NSNumber numberWithFloat:sixthSlider.value];
    incidentData[@"Professional"] = [NSNumber numberWithFloat:seventhSlider.value];
    
    incidentData[@"Cop"] = toSave;
    
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