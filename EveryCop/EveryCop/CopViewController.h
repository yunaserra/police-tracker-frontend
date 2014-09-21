//
//  CopViewController.h
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CopViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *badgeLabel;
    
    IBOutlet UITableView *interactionTable;
    
    IBOutlet UIImageView *copPhoto;
}

@end
