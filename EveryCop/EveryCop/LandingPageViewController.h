//
//  ViewController.h
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 EveryCop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface LandingPageViewController : UIViewController<MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
{
    IBOutlet UITextField *searchField;
    IBOutlet MKMapView *mapView;
    IBOutlet UITableView *listView;
    IBOutlet UIButton *reportButton;
    IBOutlet UISegmentedControl *mapOrListButton;
    NSMutableArray * array;
    
    CLLocationManager *locationMgr;
    PFObject *incidentObject;
    
}

- (IBAction) viewTypeChanged : (id) sender;
- (IBAction) buttonClicked : (id) sender;

@end
