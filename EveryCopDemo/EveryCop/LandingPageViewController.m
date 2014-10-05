//
//  ViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 EveryCop. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "LandingPageViewController.h"
#import "LandingPageListTableViewCell.h"
#import "LandingPageMapPinView.h"
#import "IncidentReportViewController.h"

@implementation LandingPageViewController

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
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
    
    mapView.layer.borderWidth = 1.0f;
    mapView.layer.borderColor = reportButton.backgroundColor.CGColor;
    
    //GEt current location
    locationMgr = [[CLLocationManager alloc] init];
    locationMgr.distanceFilter = kCLDistanceFilterNone;
    locationMgr.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationMgr startUpdatingLocation];
    mapView.userLocation.coordinate = locationMgr.location.coordinate;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 2000, 2000);
    [mapView setRegion:region animated:YES];
    
    array = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [locationMgr startUpdatingLocation];
    mapView.userLocation.coordinate = locationMgr.location.coordinate;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 2000, 2000);
    [mapView setRegion:region animated:YES];
    
    
    PFQuery* query = [PFQuery queryWithClassName:@"IncidentReport"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil)
        {
            int index = 0;
            for (PFObject* object in objects)
            {
                NSString *name = @"Positive";
                
                NSDate *date = [object objectForKey:@"Time"];
                NSCalendar *cal = [NSCalendar currentCalendar];
                NSDateComponents *components = [cal components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
                int year = [components year];
                int month = [components month];
                int day = [components day];
                NSNumber * values = [object objectForKey:@"Excellence"];
                float average = [values floatValue] * 10;
                values = [object objectForKey:@"HarmReduction"];
                average += [values floatValue] * 10;
                values = [object objectForKey:@"Humility"];
                average += [values floatValue] * 10;
                values = [object objectForKey:@"Justice"];
                average += [values floatValue] * 10;
                values = [object objectForKey:@"Professional"];
                average += [values floatValue] * 10;
                values = [object objectForKey:@"Respect"];
                average += [values floatValue] * 10;
                values = [object objectForKey:@"Service"];
                average += [values floatValue] * 10;
                
                average /= 7;
                
                if (average < 5)
                {
                    name = @"Negative";
                }
                
                NSString *pinname = [NSString stringWithFormat:@"%@ : %02i/%02i/%i", name, month, day, year];
                
                PFGeoPoint *geo = [object objectForKey:@"Location"];
                NSString *description = [object objectForKey:@"Description"];
                LandingPageMapPinView * pinView = [[LandingPageMapPinView alloc] initWithName:pinname
                                                       AndSubtext:description
                                                         AndIndex:index++
                                                    AndCoordinate:CLLocationCoordinate2DMake(geo.latitude, geo.longitude)];
                [mapView addAnnotation:pinView];
                [array addObject:object];
            }
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [mapView removeAnnotations:mapView.annotations];
    [array removeAllObjects];
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

/*************************
 
 TABLE STUFFS
 
 *************************/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *incidentTableIdentifier = @"IncidentCell";
    
    LandingPageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:incidentTableIdentifier];
    
    if (cell == nil) {
        cell = [[LandingPageListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:incidentTableIdentifier];
    }
    
    cell.textLabel.text = @"Test";
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (MKAnnotationView *)mapView:(MKMapView *)locMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *identifier = @"PinView";
    if ([annotation isKindOfClass:[LandingPageMapPinView class]])
    {
        MKAnnotationView *annotationView = (MKAnnotationView *) [locMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil)
        {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height/2);
        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        button.tag = ((LandingPageMapPinView *)annotation).index;
        [button addTarget:self action:@selector(gotoIncident:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = button;
        
        return annotationView;
    }
    
    return nil;
}

- (void)gotoIncident:(id)sender
{
    UIButton *button = (UIButton*)sender;
    incidentObject = [array objectAtIndex:button.tag];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self performSegueWithIdentifier:@"incident" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"incident"])
    {
        // Get reference to the destination view controller
        IncidentReportViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setIncidentReportObject:incidentObject];
    }
}

@end
