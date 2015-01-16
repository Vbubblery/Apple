//
//  AlertViewController.m
//  C-4
//
//  Created by Bubble on 11/22/14.
//  Copyright (c) 2014 Bubble. All rights reserved.
//

#import "KUNQIANAlertViewController.h"
@interface KUNQIANAlertViewController ()
@end

@implementation KUNQIANAlertViewController
@synthesize RowLabel,RowSlider,ColLabel,ColSlider;

//initwith the nib's name
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)initUI{
    //custom the slider
    RowSlider.minimumValue = 4;
    RowSlider.maximumValue = 10;
    RowSlider.value = 4;

    [RowSlider addTarget:self action:@selector(updateTheRow:) forControlEvents:UIControlEventValueChanged];
    ColSlider.minimumValue = 4;
    ColSlider.maximumValue = 10;
    ColSlider.value = 4;

    //add a value changed event.
    [ColSlider addTarget:self action:@selector(updateTheCol:) forControlEvents:UIControlEventValueChanged];
    [RowLabel setText:[ NSString stringWithFormat:@"The Row: 4"]];
    [ColLabel setText:[ NSString stringWithFormat:@"The Col: 4"]];
}
-(void)updateTheRow:(id)sender{
    //when slider's value changed.Update the label.
    int size = RowSlider.value;
    [RowLabel setText:[ NSString stringWithFormat:@"The Row: %d",size]];
}
-(void)updateTheCol:(id)sender{
    int size = ColSlider.value;
    [ColLabel setText:[ NSString stringWithFormat:@"The Col: %d",size]];
}

@end
