//
//  ViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import "LandingPageViewController.h"
#import "CustomIncidentListCellTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PinView.h"
#import <Parse/Parse.h>

@interface LandingPageViewController ()

@end

@implementation LandingPageViewController

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    listView.hidden = YES;
    
    //Customize the nav bar
    self.navigationItem.title = @"EveryCop";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(search:)];
    
    //List stuffs
    [listView setDataSource:self];
    [listView setDelegate:self];
    
    //Button stuffs
    reportButton.layer.cornerRadius = 10;
    reportButton.layer.borderWidth = 1;
    reportButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // set it to always show user's current location
    mapView.showsUserLocation = TRUE;
    mapView.delegate = self;
    
    //GEt current location
    locationMgr = [[CLLocationManager alloc] init];
    locationMgr.distanceFilter = kCLDistanceFilterNone;
    locationMgr.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationMgr startUpdatingLocation];
    mapView.userLocation.coordinate = locationMgr.location.coordinate;
		
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 8, 8);
    [mapView setRegion:region animated:YES];
    
    PFQuery* query = [PFQuery queryWithClassName:@"IncidentReport"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil)
        {
            for (PFObject* object in objects)
            {
                PFObject *cop = [object objectForKey:@"Cop"];
                cop = [cop fetchIfNeeded];
                PFGeoPoint *geo = [object objectForKey:@"Location"];
                NSString *copBadge = @"Dummy";
                NSString *description = [object objectForKey:@"Description"];
                PinView * pinView = [[PinView alloc] initWithName:copBadge
                                                       AndSubtext:description
                                                        AndObject:object
                                                    AndCoordinate:CLLocationCoordinate2DMake(geo.latitude, geo.longitude)];
                [mapView addAnnotation:pinView];
            }
        }
    }];
}

/**********
    Handles switching b/ween map or list view
 ***/
- (IBAction) viewTypeChanged : (id) sender
{
    switch (mapOrListButton.selectedSegmentIndex)
    {
        case 0:
            //map view
            if (mapView.hidden)
            {
                listView.hidden = YES;
                mapView.hidden = NO;
            }
            break;
        case 1:
            if (listView.hidden)
            {
                mapView.hidden = YES;
                listView.hidden = NO;
            }
            break;
        default:
            break;
    }
}

- (void)search : (id) sender
{
    //do nothing
}

/****
    Called when button is clicked. Brings up the report submission page
 ***/
- (IBAction) buttonClicked : (id) sender
{
    NSString *identifier = @"report";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self performSegueWithIdentifier:identifier sender:sender];
}

- (IBAction) pinSelected: (id) sender
{
    NSString *identifier = @"incident";
    [self performSegueWithIdentifier:identifier sender:sender];
}


/*************************
 
 TABLE STUFFS
 
 *************************/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *incidentTableIdentifier = @"IncidentCell";
    
    CustomIncidentListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:incidentTableIdentifier];
    
    if (cell == nil) {
        cell = [[CustomIncidentListCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:incidentTableIdentifier];
    }
    
    cell.textLabel.text = @"Test";
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerPinView:(NSString *)name AndSubtext:(NSString *)subtext WithLocation:(CLLocationCoordinate2D)coord
{
}

- (MKAnnotationView *)mapView:(MKMapView *)locMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *identifier = @"PinView";
    if ([annotation isKindOfClass:[PinView class]])
    {
        MKAnnotationView *annotationView = (MKAnnotationView *) [locMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil)
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height/2);
        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

@end
