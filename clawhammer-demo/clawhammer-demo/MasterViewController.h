//
//  MasterViewController.h
//  clawhammer-demo
//
//  Created by Charlie Mezak on 3/17/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
