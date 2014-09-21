//
//  PinView.m
//  EveryCop
//
//  Created by Gabriel Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import "PinView.h"

@implementation PinView

- (NSString *)title
{
    return _name;
}

- (NSString *)subtext
{
    return _subtext;
}

- (CLLocationCoordinate2D)coordinate
{
    return _currentCoordinate;
}

- (id)initWithName:(NSString *)name AndSubtext:(NSString *)subtext AndObject:(PFObject *)object AndCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        self.name = name;
        self.subtext = subtext;
        self.object = object;
        self.currentCoordinate = coordinate;
    }
    
    return self;
}

@end
