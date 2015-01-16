//
//  TableViewController.h
//  C-4
//
//  Created by Bubble on 11/18/14.
//  Copyright (c) 2014 Bubble. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FIALGameModel.h"
#import "ViewController.h"
@interface KUNQIANTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
-(void)setViewController:(ViewController *)c;
-(void)drawView:(UIView *)view :(int)row :(int)col :(NSMutableArray *)ary;
-(void)removeSubView:(UIView *)view;
@end
