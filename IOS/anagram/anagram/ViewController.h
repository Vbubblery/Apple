//
//  ViewController.h
//  anagram
//
//  Created by li wei on 9/10/2014.
//  Copyright (c) 2014 li wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dictionary.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *anagramField;
@property (weak, nonatomic) IBOutlet UITextField *patternField;
@property (weak, nonatomic) IBOutlet UITextField *wordSizeField;
@property (weak, nonatomic) IBOutlet UITextView *ResultsView;
- (IBAction)Search:(id)sender;

- (IBAction)onDismissKeyboard:(id)sender;
- (IBAction)onEnterDetail:(id)sender;
- (IBAction)LimitedNumberAndComma:(id)sender;
- (void) handleBackgroundTap:(UITapGestureRecognizer*) sender;

- (Boolean)IsReAnag:(NSString *)Str;
- (Boolean)IsRePatt:(NSString *)Str;
@end

