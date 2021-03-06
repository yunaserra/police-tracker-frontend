//
//  LandingPageMapPinView.h
//  EveryCop
//
//  Created by Gabriel Serra on 9/20/14.
//  Copyright (c) 2014 EveryCop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface LandingPageMapPinView : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *subtext;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinate;

- (id)initWithName:(NSString *)name AndSubtext:(NSString *)subtext AndIndex:(int)index AndCoordinate:(CLLocationCoordinate2D)coordinate;

@end
