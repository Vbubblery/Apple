//
//  GameData.h
//  C-4
//
//  Created by Bubble on 11/19/14.
//  Copyright (c) 2014 Bubble. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KUNQIANGameData : NSObject
-(void)addNewGame:(NSMutableArray *)game;
-(void)saveData:(NSMutableArray *)game;
-(void)clear;
@end
