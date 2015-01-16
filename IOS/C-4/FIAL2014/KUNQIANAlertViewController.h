//
//  AlertViewController.h
//  C-4
//
//  Created by Bubble on 11/22/14.
//  Copyright (c) 2014 Bubble. All rights reserved.
//

#import "ViewController.h"

@interface KUNQIANAlertViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *RowLabel;
@property (weak, nonatomic) IBOutlet UILabel *ColLabel;
@property (weak, nonatomic) IBOutlet UISlider *RowSlider;
@property (weak, nonatomic) IBOutlet UISlider *ColSlider;

-(void)initUI;
-(void)updateTheRow:(id)sender;
-(void)updateTheCol:(id)sender;
@end
