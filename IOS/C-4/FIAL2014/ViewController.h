//
//  ViewController.h
//  C-4
//
//  Created by Bubble on 11/14/14.
//  Copyright (c) 2014 Bubble. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FIALGameModel.h"
#import "KUNQIANAlertViewController.h"

@interface ViewController : UIViewController<UIPopoverPresentationControllerDelegate>
{
    FIALGameModel *model;
}
- (IBAction)newGame:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (nonatomic,retain) UIPopoverController *popoverController;
@property (weak, nonatomic) IBOutlet UILabel *statusOfGame;
-(void)removeSubView;
-(void)initBoard:(int)row :(int)col;
-(void)registerViewTouchEvent;
-(void)handleSingleTap:(UITapGestureRecognizer *)recognizer;
-(void)saveTheAryAndStatus;
-(void)newGAry;
-(void)drawTheChessBoard;
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController;
-(void)initTheModel:(FIALGameModel *)m;
@end

