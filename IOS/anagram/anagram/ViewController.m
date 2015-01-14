//
//  ViewController.m
//  anagram
//
//  Created by li wei on 9/10/2014.
//  Copyright (c) 2014 li wei. All rights reserved.
//

#import "ViewController.h"
#import "Dictionary.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize anagramField,patternField,wordSizeField,ResultsView;
Dictionary *dict;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer* tapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap:)];
    
    tapRecogniser.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecogniser];
      dict = [[Dictionary alloc]init];
    [dict loadDic];
    [dict Anag];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleBackgroundTap:(UITapGestureRecognizer *) sender
{
    [anagramField resignFirstResponder];
    [patternField resignFirstResponder];
    [wordSizeField resignFirstResponder];
    
}

- (IBAction)Search:(id)sender {
   }

- (IBAction)onDismissKeyboard:(id)sender
{
    [anagramField resignFirstResponder];
    [patternField resignFirstResponder];
    [wordSizeField resignFirstResponder];
}


- (IBAction)onEnterDetail:(id)sender
{
    [anagramField resignFirstResponder];
    [patternField resignFirstResponder];
    [wordSizeField resignFirstResponder];
    NSString *anag =[[anagramField text]lowercaseString];
    NSString *patt = [[patternField text]lowercaseString];
    NSString *size = [wordSizeField text];
    if ([anag length] == 0 &&[patt length]==0) {
        UIAlertView *welcomeMessage = [[UIAlertView alloc] initWithTitle:@"Where are the anag and patt? :( \n" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [welcomeMessage show];
        return;
    }
    if ([self IsRePatt:patt]) {
        UIAlertView *welcomeMessage = [[UIAlertView alloc] initWithTitle:@"Worry patt matched :( \n" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [welcomeMessage show];
        return;
    }
    if ([self IsReAnag:anag]) {
        UIAlertView *welcomeMessage = [[UIAlertView alloc] initWithTitle:@"Worry anag matched :( \n" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [welcomeMessage show];
        return;
    }
    if ([size length]>7|| [size length]<1) {
        UIAlertView *welcomeMessage = [[UIAlertView alloc] initWithTitle:@"wrong Size :( \n smaller than 4 or big than 1 size plz!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [welcomeMessage show];
        return;
    }
    NSArray *ary = [size componentsSeparatedByString:@","];
    int totalnum;
    for(NSString *num in ary){
        totalnum +=[num intValue];
    }
    if(totalnum!=[patt length]&&totalnum!=[anag length]){
        UIAlertView *welcomeMessage = [[UIAlertView alloc] initWithTitle:@"wrong Size :( \n The Size is not matched with the patt or anag!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [welcomeMessage show];
        return;
    }
    [dict AnagramsMatch:anag];
    if ([patt length]==0) {
        const char *tmp =[anag cStringUsingEncoding:NSASCIIStringEncoding];
        [dict AnagramsSearch:tmp:size];if ([[dict ReturnResults]isEqualToString:@""]) {
            UIAlertView *welcomeMessage = [[UIAlertView alloc] initWithTitle:@"cannot find any word :(" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [welcomeMessage show];
            [ResultsView setText:@""];}else{
                [ResultsView setText:[dict ReturnResults]];}
        return;
    }
    [dict PatternMatch:patt:size];
    if ([[dict ReturnResults]isEqualToString:@""]) {
        UIAlertView *welcomeMessage = [[UIAlertView alloc] initWithTitle:@"cannot find any word :(" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [welcomeMessage show];
        [ResultsView setText:@""];
    }else{[ResultsView setText:[dict ReturnResults]];}

    
    //NSString *display = [NSString stringWithFormat:@"display%@",anagram];
    	
}

- (IBAction)LimitedNumberAndComma:(id)sender {
}


- (Boolean)IsReAnag:(NSString *)Str{
     NSString * Rule = @"^[A-z]*";
     NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Rule];
    if (([regextestmobile evaluateWithObject:Str] == YES) ){
        return NO;
    }
   return YES;
}
- (Boolean)IsRePatt:(NSString *)Str{
    NSString * Rule = @"^[A-z\\-]*";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Rule];
    if (([regextestmobile evaluateWithObject:Str] == YES) ){
        return NO;
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];
        if ((single >='0' && single<='9') || single==',')
        {
            return YES;
        }else{
            return NO; 
        } 
    }else{ 
        return YES; 
    } 
}

@end
