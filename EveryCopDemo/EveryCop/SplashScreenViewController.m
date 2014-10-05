//
//  SplashScreenViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/21/14.
//  Copyright (c) 2014 EveryCop. All rights reserved.
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

@end
