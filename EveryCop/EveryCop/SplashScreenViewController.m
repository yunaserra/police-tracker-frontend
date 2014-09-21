//
//  SplashScreenViewController.m
//  EveryCop
//
//  Created by Gabriel Serra on 9/21/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImage *img = [UIImage imageNamed:@"everycopLogo.png"];
    logo.image = img;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(timeHasElapsed)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void) timeHasElapsed
{
    [timer invalidate];
    NSString *identifier = @"main";
    [self performSegueWithIdentifier:identifier sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
