//
//  FIALGameModel.m
//  ConnectFour2013
//
//  Created by Terry Payne on 17/10/2013.
//  Copyright (c) 2013 Terry Payne. All rights reserved.
//

#import "FIALGameModel.h"

// =======================================================================================
@interface FIALGameModel ()

// Board Properties
@property (nonatomic, strong) NSNumber *rows;
@property (nonatomic, strong) NSNumber *columns;
@property (nonatomic, strong) NSNumber *numberOfPositions;


// Create some objects that can populate the array.  These will be created
// in initWithBoardSize:, and retained whenever added to the gameBoard.
@property (nonatomic, strong) NSNumber *emptyCounterObject;
@property (nonatomic, strong) NSNumber *yellowCounterObject;
@property (nonatomic, strong) NSNumber *redCounterObject;
// Game Properties
@property (nonatomic, strong) NSMutableArray *gamePositionArray;    // with rows * columns positions
@end

@implementation FIALGameModel
@synthesize gamePositionArray;
// =======================================================================================
// Getting and setting board positions

-(NSInteger) getNumberOfPositions {
    return [[self numberOfPositions] intValue];
}

-(NSInteger) getColumns {
    return [[self columns] integerValue];
}

-(NSInteger) getRows {
    return [[self rows] integerValue];
}

// Returns the type of counter from the model, or NC_Empty if empty
// Returns NC_Error if unsuccessful, if
//    1) either horizontal or vertical positions are invalid
-(FIAL_CounterType)getCounterAtPosition:(NSInteger)pos {
    if ((pos < 0) || (pos >= [self getNumberOfPositions]))
        return FIAL_Error;
    
    return [[[self gamePositionArray] objectAtIndex:pos] intValue];
}

// =======================================================================================
// Adds a counter to the column col
// Returns YES if successful, or NO if
//    1) the column is full
//    2) the column number is invalid

-(BOOL)addCounterInColumn:(NSInteger)col {
    if ((col < 0) || (col >= [self getColumns]))
        return NO;
    
    NSInteger pos=0;
    bool updateOK = NO;
    for (NSInteger i = ([self getRows]-1); i>=0; i--) {
        pos = (i * [self getColumns])+col;
        int n =[[[self gamePositionArray] objectAtIndex:pos]integerValue];
        NSNumber *num = [[NSNumber alloc] initWithInt:n];
        if ([[self emptyCounterObject] isEqualToValue:num]) {
            [self setCurrentStep:pos];
            switch ([self currentPlayer]) {
                case FIAL_RedPlayer:
                    [[self gamePositionArray] replaceObjectAtIndex:pos withObject:[self redCounterObject]];
                    updateOK = YES;
                    break;
                case FIAL_YellowPlayer:
                    [[self gamePositionArray] replaceObjectAtIndex:pos withObject:[self yellowCounterObject]];
                    updateOK = YES;
                    break;
                default:
                    break;  // do nothing.  Means that every position will be checked if the counter
                            // is invalid, but ultimately NO will be returned
            }
        }
        if (updateOK) {
            // Change the current player
            [self setCurrentPlayer:([self currentPlayer]==FIAL_YellowPlayer)?FIAL_RedPlayer:FIAL_YellowPlayer];

            break;  // no need to check any other row
        }
    }
    (void)[self checkForWinningMove];
    return updateOK;
}
// =======================================================================================
-(BOOL)checkForWinningMove {
    BOOL win=false;
    // Check every position:
    //  1) is there a line to thr right?
    //  2) is there a line down?
    //  3) is there a diagonal line?
    
    FIAL_CounterType currentCounter;
    int c, r, pos, i;
    int rows = (int) [self getRows];
    int cols = (int) [self getColumns];
    
    for (r=0; r < rows; r++) {
        for (c=0; c < cols; c++) {
            
            int score = 0;
            pos = (r*cols)+c;
            currentCounter = (int) [[[self gamePositionArray] objectAtIndex:pos] integerValue];
            if (currentCounter == FIAL_Empty)
                continue;
            
            // check to the right
            if ((!win) && (c <= (cols-WINLINE))) {
                score = 0;
                for (i=0; i<WINLINE; i++)
                    score += [[[self gamePositionArray] objectAtIndex:(pos+i)] integerValue];
                
                if (score == (currentCounter*WINLINE)) {
                    win=true;
                    break;
                }
            }
            // check diagonal down
            if ((!win) && (c <= (cols-WINLINE)) && (r <= (rows-WINLINE))) {
                score = 0;
                for (i=0; i<WINLINE; i++)
                    score += [[[self gamePositionArray] objectAtIndex:((pos+i)+(i*cols))] integerValue];

                if (score == (currentCounter*WINLINE)) {
                    win=true;
                    break;
                }
            }
            // check diagonal up
            if ((!win) && (c >= (WINLINE-1)) && (r <= (rows-WINLINE))) {
                score = 0;
                for (i=0; i<WINLINE; i++)
                    score += [[[self gamePositionArray] objectAtIndex:((pos-i)+(i*cols))] integerValue];
                
                if (score == (currentCounter*WINLINE)) {
                    win=true;
                    break;
                }
            }
            // check down
            if ((!win) && (r <= (rows-WINLINE))) {
                score = 0;
                for (i=0; i<WINLINE; i++)
                    score += [[[self gamePositionArray] objectAtIndex:(pos+(i*cols))] integerValue];
                
                if (score == (currentCounter*WINLINE)) {
                    win=true;
                    break;
                }
                
            }
        }
    }

    // Note that we set the ivar directly rather than using its setter, as the property is readonly
    _gameOver=win;

    return win;
}


// =======================================================================================

-(FIALGameModel *)initWithRows:(NSInteger)rows columns:(NSInteger)cols {
    
    // Fail if either the number of rows or cols is less than WINLINE (typically 4)
    if ((rows < WINLINE) || (cols < WINLINE))  {
        return nil;
    };
    if ((rows > MAXCR) || (cols > MAXCR)) {
        return nil;
    }
    self = [super init];
    
    if (self) {
        // set up and store the board details
        [self setRows:[NSNumber numberWithInteger:rows]];
        [self setColumns:[NSNumber numberWithInteger:cols]];
        [self setNumberOfPositions:[NSNumber numberWithInteger:(NSInteger) rows*cols]];
        
        // Create the counter objects
        [self setEmptyCounterObject:[[NSNumber alloc] initWithInt:FIAL_Empty]];
        [self setYellowCounterObject:[[NSNumber alloc] initWithInt:FIAL_YellowPlayer]];
        [self setRedCounterObject:[[NSNumber alloc] initWithInt:FIAL_RedPlayer]];

        [self setGamePositionArray:[NSMutableArray arrayWithCapacity:[self getNumberOfPositions]]];
        for (NSInteger i=[self getNumberOfPositions]; i>=0; i--)
            [[self gamePositionArray] addObject:[self emptyCounterObject]];
        
        // Note that we set the ivar directly rather than using its setter, as the property is readonly
        _gameOver=NO;
    
    }
    return self;
}
-(NSInteger)getTheLastStep{
    return [self currentStep];
}
-(id)getAryOfGame{
    return gamePositionArray;
}
-(void)setGameArray:(NSMutableArray *)ary{
    gamePositionArray = ary;
    
}
-(void)setGameOver:(BOOL)gameOver{
    _gameOver = gameOver;
}
@end
