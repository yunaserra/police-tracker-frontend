//
//  LandingPageMapPinView.m
//  EveryCop
//
//  Created by Gabriel Serra on 9/20/14.
//  Copyright (c) 2014 EveryCop. All rights reserved.
//

#import "LandingPageMapPinView.h"

@implementation LandingPageMapPinView

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

- (id)initWithName:(NSString *)name
        AndSubtext:(NSString *)subtext
          AndIndex:(int)index
     AndCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        self.name = name;
        self.subtext = subtext;
        self.index = index;
        self.currentCoordinate = coordinate;
    }
    
    return self;
}

@end
