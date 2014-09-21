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
        default:
            break;
    }
}

- (IBAction)finishedTyping:(id)sender
{
    UITextField *textField = (UITextField*)sender;
    
    if (textField.tag == 0)
    {
        //Name
    }
    else if (textField.tag == 1)
    {
        //Badge number
    }
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
    
    description.delegate = self;
    description.layer.borderWidth = 1.0f;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(backToMain)];
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 500);
}

- (void) backToMain
{
    
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
