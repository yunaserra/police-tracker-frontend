//
//  CopViewController.m
//  EveryCop
//
//  Created by GabrielYuna Serra on 9/20/14.
//  Copyright (c) 2014 PoliceTracker. All rights reserved.
//

#import "CopViewController.h"
#import "CustomIncidentListCellTableViewCell.h"

@interface CopViewController ()

@end

@implementation CopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [interactionTable setDataSource:self];
    [interactionTable setDelegate:self];
    
    UIImage *img = [UIImage imageNamed:@"Seattle-police-shield.png"];
    copPhoto.image = img;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
    Table stuffs
 */

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
