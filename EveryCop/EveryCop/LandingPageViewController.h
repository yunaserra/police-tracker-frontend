//
//  ViewController.h
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LandingPageViewController : UIViewController<MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITextField *searchField;
    IBOutlet MKMapView *mapView;
    IBOutlet UITableView *listView;
    IBOutlet UIButton *reportButton;
    IBOutlet UISegmentedControl *mapOrListButton;
    
}

- (IBAction) viewTypeChanged : (id) sender;
- (IBAction) buttonClicked : (id) sender;
- (void)registerPinView:(NSString *)name WithLocation:(CLLocationCoordinate2D)coord;

@end
