//
//  Dictionary.m
//  anagram
//
//  Created by li wei && Bubble_000 on 13/10/2014.
//  Copyright (c) 2014 li wei. All rights reserved.
//

#import "Dictionary.h"
@implementation Dictionary
#define NO_OF_CHARS 256
-(void) loadDic
{
    NSString *filepath = @"/Users/bubble/Desktop/ios assignment2/dict.txt";
    NSString *str = [[NSString alloc] initWithContentsOfFile:filepath
                                                    encoding:NSUTF8StringEncoding
                                                       error:NULL];
    //checks for read content
    if(str==nil)
    {
        NSLog(@"file read failed");
    }
    
    // extract the data line by line
    dictionary = [str componentsSeparatedByString:@"\r\n"];
    
    if([dictionary count] == 0)
    {
        NSLog(@"dictionary count = 0");
    }
    NSLog(@"Dictionary Loaded successfully");
}

-(void) AnagramsMatch: (NSString *) given
{
    if ([given isEqualToString:@""]) {
        Anagram = nil;
    }else{
    Anagram = [given cStringUsingEncoding:NSASCIIStringEncoding];
    }
    }
-(BOOL) areAnagram:(const char*)str1 :(const char*)str2;
{
    int l,i,j;
    char *p = (char*)malloc(sizeof(char)*strlen(str1));
    for(j=0,l=0;j<strlen(str1);j++){
        if(str1[j]!=' '){
            p[l++] = str1[j];
        }
    }
    p[l] = '\0';
    str1=p;
    if (str1 == NULL || str2 == NULL)
    {
        return false;
    }
    int count[NO_OF_CHARS] = {0};
    for (i = 0; str1[i] && str2[i]; i++)
    {
        count[str1[i]]++;
        count[str2[i]]--;
    }
    if (str1[i] != '\0' || str2[i] != '\0')
    {
        return false;
    }
		
    for (i = 0; i < NO_OF_CHARS; i++)
    {
        if (count[i] != 0)
        {
            return false;
        }
    }
    return true;
}
-(void) AnagramsSearch: (const char *) given :(NSString*)Sizes
{
    FinalResult = [[NSString alloc]init];
    sumAng = [[NSMutableArray alloc]init];
    NSArray *ary = [Sizes componentsSeparatedByString:@","];
    NSMutableArray *ary2 =[[NSMutableArray alloc]init];
    int tmpnum=0;
    for (NSString* num in ary) {
        int ReNum = [num intValue]-1;
        ary2 = [NewDict objectAtIndex:ReNum];
        [self Sum2Ang:sumAng :ary2];
    }
    for (NSString* str in sumAng) {
        if ([self areAnagram:[str cStringUsingEncoding:NSASCIIStringEncoding] :Anagram]) {
            tmpnum++;
            FinalResult = [FinalResult stringByAppendingFormat:@"%@\n",str];
            if (tmpnum==100) {
                break;
            }
        }
    }
}
-(void) Sum2Ang:(NSMutableArray *) ary1 :(NSMutableArray*)ary2{
    sumAng = [[NSMutableArray alloc]init];
    if ([ary1 count]==0) {
        sumAng=ary2;
        return;
    }
    for (NSString *st1 in ary1) {
        for (NSString *st2 in ary2) {
            NSString *tmpstr = [[NSString alloc]init];
            tmpstr = [st1 stringByAppendingFormat:@" %@",st2];
            [sumAng addObject:tmpstr];
        }
    }
}
-(void) Anag{
    NewDict = [[NSMutableArray alloc]init];
    for (int i = 1; i<30; i++) {
        NSMutableArray *dict = [[NSMutableArray alloc]initWithArray:dictionary];
        NSMutableArray *tmp = [[NSMutableArray alloc]init];
        for (NSString* str in dict) {
            if ([str length]==i) {
                [tmp addObject:str];
            }
        }
        [NewDict addObject:tmp];
    }
   }
-(void) PatternMatch: (NSString *) given : (NSString *)Sizes
{
    FinalResult = [[NSString alloc]init];
    sumStr = [[NSMutableArray alloc]init];
    AllWords = [NSMutableArray arrayWithCapacity:1];
    NSArray *ary = [Sizes componentsSeparatedByString:@","];
    Results= [NSMutableArray arrayWithCapacity:1];
    NSMutableString *strs;
    @try {
         strs = [NSMutableString stringWithString:given];
    }
    @catch (NSException *exception) {
        return;
    }
   
    for (NSString *strnum in ary) {
        @try {
            [Results addObject:[strs substringToIndex:[strnum intValue]]];
            [strs deleteCharactersInRange:NSMakeRange(0,[strnum intValue])];
        }
        @catch (NSException *exception) {
            return;
        }

    }
    for (NSString *s in Results) {
        const char *t =[s cStringUsingEncoding:NSASCIIStringEncoding];
        [self PatternMatch2:t];
    }
    sumStr = [AllWords objectAtIndex:0];
    for (int d =1; d<[AllWords count]; d++) {
        [self Sum2Array:sumStr:[AllWords objectAtIndex:d]];
    }
    int tmpnum =0;
    for (NSString *st in sumStr) {
        if (Anagram==nil) {
            FinalResult = [FinalResult stringByAppendingFormat:@"%@\n",st];
        }
        if ([self areAnagram:[st cStringUsingEncoding:NSASCIIStringEncoding] :Anagram]) {
            FinalResult = [FinalResult stringByAppendingFormat:@"%@\n",st];
            tmpnum++;
            if(tmpnum==100){
                break;
            }
        }
    }
}
-(void) Sum2Array:(NSMutableArray *) ary1 :(NSMutableArray*)ary2{
    sumStr =[NSMutableArray arrayWithCapacity:1];
    for (NSString *st1 in ary1) {
        for (NSString *st2 in ary2) {
            NSString *tmpstr = [[NSString alloc]init];
            tmpstr = [st1 stringByAppendingFormat:@" %@",st2];
            [sumStr addObject:tmpstr];
        }
    }

}
-(id)ReturnResults{
    return FinalResult;
}
-(void) PatternMatch2: (const char *) given
{
	//NSLog(@"hai");
	int arloc[20];
	int loc=0;
	int i;
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:1];;
	//NSLog(@"%s",given);
	//finding chars location in given pattern
	for(i=0;i<strlen(given);i++)
	{
        if(given[i]!='-')
        {
            arloc[loc]=i;
            loc++;
        }
	}
	//NSLog(@"%s",given);
	//for each word from dictionary
	for (NSString *str in dictionary)
	{
		int k=0;
		int count=0;
		const char *ch = [str cStringUsingEncoding:NSUTF8StringEncoding]; //converting NSString word from dictionary to character array
		
		// both have equal length
		if(strlen(given)==(strlen(ch)))
		{
			//checking for matching chars in dictionary word with respect to location in given word
			while(k<loc)
			{
				if(ch[arloc[k]]==given[arloc[k]])
				{
                    count++;
				}
				k++;
			}
            // if dictionary word and given word have same chars at same location and length add that word to result
			if(count==loc)
			{
				[tmp addObject:str];
			}
            
		}
	}
    [AllWords addObject:tmp];
    //NSLog(@"pattern match successfully");
}

@end
