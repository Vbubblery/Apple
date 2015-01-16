//
//  ViewController.m
//  C-4
//
//  Created by Bubble on 11/14/14.
//  Copyright (c) 2014 Bubble. All rights reserved.
//

#import "ViewController.h"
#import "FIALGameModel.h"
#import "JGActionSheet.h"
#import "KUNQIANGameAreaView.h"
#import "KUNQIANTableViewController.h"
#import "KUNQIANGameData.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize popoverController,username;
KUNQIANGameAreaView *view1;
KUNQIANGameData *game;
KUNQIANTableViewController *tableViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [username setText:@"KUN QIANG"];

    tableViewController = [[KUNQIANTableViewController alloc] init];
    [self addChildViewController:tableViewController];
    [tableViewController.tableView setFrame:CGRectMake(700, 100, 300, 600)];
    [self.view addSubview:tableViewController.tableView];

    game = [[KUNQIANGameData alloc]init];
    //popover init.
    KUNQIANAlertViewController *newViewController = [[KUNQIANAlertViewController alloc] initWithNibName:@"KUNQIANAlertViewController" bundle:nil];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:newViewController];
    popoverController.delegate = (id)self;

    [tableViewController setViewController:self];
    view1 = [[KUNQIANGameAreaView alloc] initWithFrame:CGRectMake(0, 100, 700, 630)];
    [view1 setBounds:CGRectMake(0, 0, 700, 630)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
//click new button's action
- (IBAction)newGame:(id)sender {
    [self removeSubView];
    popoverController.popoverContentSize = CGSizeMake(320.0, 200.0);
    [popoverController presentPopoverFromRect:[(UIButton *)sender frame]
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:YES];
}

//when the popover view miss's action:
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController2
{
    [[self statusOfGame]setText:@"red"];
    float rowValue =((KUNQIANAlertViewController *) popoverController2.contentViewController).RowSlider.value;
    float colValue =((KUNQIANAlertViewController *) popoverController2.contentViewController).ColSlider.value;
    
    [self initBoard:(int)rowValue :(int)colValue];
}

-(void)initBoard:(int)row :(int)col{
    @try {
        //init with thw row and col.
        model = [[FIALGameModel alloc] initWithRows:row  columns:col];
        [self newGAry];
        [view1 drawTheBoard:model];
        [self registerViewTouchEvent];
        [self.view addSubview:view1];
        [model setCurrentPlayer:FIAL_RedPlayer];
    }
    @catch (NSException *exception) {
        return;
    }
}

-(void)removeSubView{
    //remove all subview when we click a new game or old game.
    for (UIView *view in [view1 subviews]) {
        for (UIView *image in [view subviews]) {
            [image removeFromSuperview];
        }
        [view removeFromSuperview];
    }
}
-(void)registerViewTouchEvent
{
    //register the touch event to each cell
    for (UIView *view in [view1 subviews]) {
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [view addGestureRecognizer:singleFingerTap];
        
    }
    
}
-(void)drawTheChessBoard{
    [view1 drawTheBoard:model];
    [self registerViewTouchEvent];
    [self.view addSubview:view1];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer{
    if ([model isGameOver]) {
        return;
    }
    //got the view that click before
    UIView *a = recognizer.view;
    if ([model addCounterInColumn:[a tag]]) {
        [view1 drawTheBoard:model];
        [self registerViewTouchEvent];
        if ([model isGameOver]) {
            JGActionSheetSection *alert;
            //when some one win the match. Alert a message.
            if([[[self statusOfGame]text]isEqualToString:@"red"]){
                alert= [JGActionSheetSection sectionWithTitle:@"red player win" message:nil buttonTitles:@[@"ok"] buttonStyle:JGActionSheetButtonStyleCancel];
            }
            else{
                alert = [JGActionSheetSection sectionWithTitle:@"yellow player win" message:nil buttonTitles:@[@"ok"] buttonStyle:JGActionSheetButtonStyleCancel];
            }
            NSArray *sections = @[alert];
            JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
            [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
                [sheet dismissAnimated:YES];
            }];
            [sheet showInView:self.view animated:YES];
            //change the status of game with gameover.
            [[self statusOfGame]setText:[NSString stringWithFormat:@"gameover"]];
            [self saveTheAryAndStatus];
            [tableViewController.tableView reloadData];
            return;
        }
    }
    else
    {
        //when some one want to go a error positon. alert the error.
        JGActionSheetSection *alert = [JGActionSheetSection sectionWithTitle:@"error position" message:nil buttonTitles:@[@"ok"] buttonStyle:JGActionSheetButtonStyleCancel];
        NSArray *sections = @[alert];
        JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
        [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
            [sheet dismissAnimated:YES];
        }];
        [sheet showInView:self.view animated:YES];
        
    }
    //change the statu's of the match
    if (model.currentPlayer==FIAL_RedPlayer) {
        [[self statusOfGame]setText:[NSString stringWithFormat:@"red"]];
    }
    else{
        [[self statusOfGame]setText:[NSString stringWithFormat:@"yellow"]];
    }
    [self saveTheAryAndStatus];
    [tableViewController.tableView reloadData];
}
//each step.save the game.
-(void)saveTheAryAndStatus{
    NSMutableArray *ary = [[NSMutableArray alloc]init];
    [ary addObject:self.statusOfGame.text];
    [ary addObject:[model getAryOfGame]];
    [ary addObject:[NSNumber numberWithInt:[model getColumns]]];
    [ary addObject:[NSNumber numberWithInt:[model getRows]]];
    [game saveData:ary];
}
//when create a new game. 
-(void)newGAry
{
    NSMutableArray *ary = [[NSMutableArray alloc]init];
    [ary addObject:self.statusOfGame.text];
    [ary addObject:[model getAryOfGame]];
    [ary addObject:[NSNumber numberWithInt:[model getColumns]]];
    [ary addObject:[NSNumber numberWithInt:[model getRows]]];
    [game addNewGame:ary];
    [tableViewController.tableView reloadData];
}
-(void)initTheModel:(FIALGameModel *)m{
    model =m;
}
@end
