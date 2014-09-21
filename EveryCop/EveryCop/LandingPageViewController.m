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


@interface LandingPageViewController ()

@end

@implementation LandingPageViewController

- (void)viewDidAppear:(BOOL)animated
{
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
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
		
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(zoomLocation, 8, 8);
    
    [mapView setRegion:region animated:YES];
    [self registerPinView:@"Start Location" WithLocation:mapView.userLocation.coordinate];
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

- (void)registerPinView:(NSString *)name WithLocation:(CLLocationCoordinate2D)coord
{
	
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

@end
