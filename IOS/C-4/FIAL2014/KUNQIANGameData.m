//
//  GameData.m
//  C-4
//
//  Created by Bubble on 11/19/14.
//  Copyright (c) 2014 Bubble. All rights reserved.
//

#import "KUNQIANGameData.h"

@implementation KUNQIANGameData



//operation the NSUserDefaults' class.

-(void)addNewGame:(NSMutableArray *)game
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"game"]];
    [ary addObject:game];
    [defaults setObject:ary forKey:@"game"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)saveData:(NSMutableArray *)game
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"game"]];
    [ary removeLastObject];
    [ary addObject:game];
    [[NSUserDefaults standardUserDefaults] setObject:ary forKey:@"game"];
}
-(void)clear
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"game"];
}

@end
