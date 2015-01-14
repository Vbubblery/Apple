//
//  FirstViewController.m
//  Hash
//
//  Created by juncheng zhou on 5/25/14.
//
//

#import "FirstViewController.h"
#import "de_md5.h"
#import <CommonCrypto/CommonDigest.h>
#import "FileObject.h"
#import "AppDelegate.h"
@interface FirstViewController ()
@end
@implementation FirstViewController
@synthesize Box1,SameFileResults,AlertSameFile,HashResults,ErrorTip;
NSData *nsData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
          }
    return self;
}
- (IBAction)MD5Button:(id)sender {
     [ErrorTip setStringValue:@""];
    if (![[Box1 stringValue] isEqual:@""]) {
        @try{
        [self Calculate:[Box1 stringValue]:1];
            [Box1 setStringValue:@""];}
        @catch (NSException *exception) {  NSLog(@"Problem!!! Caught exception: %@", [exception name]);
            [ErrorTip setStringValue:[NSString stringWithFormat:@"%@",[exception reason]]];
        }
    }
}
- (IBAction)SHA1:(id)sender {
    if (![[Box1 stringValue] isEqual:@""]) {
        @try{
            [self Calculate:[Box1 stringValue]:2];
            [Box1 setStringValue:@""];}
        @catch (NSException *exception) {
            NSLog(@"Problem!!! Caught exception: %@", [exception name]);
            [ErrorTip setStringValue:[NSString stringWithFormat:@"%@",[exception reason]]];
        }
    }

}

- (IBAction)SHA256:(id)sender {
    if (![[Box1 stringValue] isEqual:@""]) {
        @try{
            [self Calculate:[Box1 stringValue]:3];
            [Box1 setStringValue:@""];}
        @catch (NSException *exception) {
            NSLog(@"Problem!!! Caught exception: %@", [exception name]);
            [ErrorTip setStringValue:[NSString stringWithFormat:@"%@",[exception reason]]];
        }
    }
}

- (void)Calculate:(NSString*)Path :(int)mo{
    //Creates and returns a data object by reading every byte from the file specified by a given path.
    nsData = [NSData dataWithContentsOfFile:Path];
    if (nsData!=nil) {
        NSString *NewHash=[nsData Hash:mo];
        FileObject *file=[[FileObject alloc]initWithPath:Path andHash:NewHash];
        //check the same file
        if ([nsData Check:file]) {
            [AlertSameFile setStringValue:@"YOU HAVE SAME FILES!!"];
            [SameFileResults setString:[self ArrayOfSameResults]];
        }
        //store Hash
        [nsData AddNewHash:file];
        [HashResults setString:[self ArrayOfResults]];
    }
    else{
        NSException *exception=[NSException exceptionWithName:@"invalidPath" reason:@"The file or the path is invalid" userInfo:nil];
        @throw exception;
    }
}

//retuen the results as string
-(NSString*)ArrayOfResults{
    NSMutableArray *tmp= [nsData arrayHash];
    NSString *info=@"";
    for (NSArray *k in tmp) {
        info=[NSString stringWithFormat:@"%@%@:%@ \n",info,k[0],k[1]];
    }
    return info;
}
//retuen the results as string
-(NSString*)ArrayOfSameResults{
    NSString *info=@"";
    NSMutableArray *tmp = [nsData arraySameR];
    for (NSString *k in tmp) {
        info=[NSString stringWithFormat:@"%@%@ \n",info,k];
    }
    return info;
}
@end
