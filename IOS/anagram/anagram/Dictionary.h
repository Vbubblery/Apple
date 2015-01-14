//
//  Dictionary.h
//  anagram
//
//  Created by li wei on 13/10/2014.
//  Copyright (c) 2014 li wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dictionary : NSObject
{
    NSArray * dictionary;
    const char * Anagram;
    NSMutableArray *AllWords;
    NSMutableArray *Results;
    NSMutableArray *sumStr;
    NSString *FinalResult;
    NSMutableArray *NewDict;
    NSMutableArray *sumAng;
}
-(void) loadDic;
-(void) Sum2Ang:(NSMutableArray *) ary1 :(NSMutableArray*)ary2;
-(void) PatternMatch: (NSString *) given : (NSString *)Sizes;
-(void) AnagramsMatch: (NSString *) str;
-(BOOL) areAnagram:(const  char *)str1 :(const char *)str2;
-(void) PatternMatch2: (const char *) given;
-(void) AnagramsSearch: (const char *) given : (NSString*)Sizes;
-(void) Anag;
-(void) Sum2Array:(NSMutableArray *)ary1 :(NSMutableArray *)ar2;
-(id)ReturnResults;
@end
