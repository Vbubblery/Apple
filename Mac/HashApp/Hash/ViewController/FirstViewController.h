//
//  FirstViewController.h
//  Hash
//
//  Created by juncheng zhou on 5/25/14.
//
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

@interface FirstViewController : NSViewController
@property (weak) IBOutlet NSTextField *Box1;
- (IBAction)MD5Button:(id)sender;
@property (weak) IBOutlet NSTextField *AlertSameFile;
@property (unsafe_unretained) IBOutlet NSTextView *HashResults;
@property (unsafe_unretained) IBOutlet NSTextView *SameFileResults;
- (IBAction)SHA1:(id)sender;
- (IBAction)SHA256:(id)sender;
@property (weak) IBOutlet NSTextField *ErrorTip;
-(NSString*)ArrayOfResults;
- (void)Calculate:(NSString*)Path :(int)mo;
@end
