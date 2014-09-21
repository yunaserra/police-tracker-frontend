//
//  PinView.h
//  EveryCop
//
//  Created by Gabriel Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface PinView : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *subtext;
@property (nonatomic, assign) PFObject *object;
@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinate;

- (id)initWithName:(NSString *)name AndSubtext:(NSString *)subtext AndObject:(PFObject*)object AndCoordinate:(CLLocationCoordinate2D)coordinate;

@end
