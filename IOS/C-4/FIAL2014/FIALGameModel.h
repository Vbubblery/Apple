//
//  FIALGameModel.h
//  FourInARow2013
//  Version 2.0 (2012)
//
//  Created by Terry Payne on 17/10/2013.
//  Copyright (c) 2013 Terry Payne. All rights reserved.
//


#import <Foundation/Foundation.h>

// =======================================================================================
// Usefull Macros and typedefs - see below
// =======================================================================================

#define WINLINE 4
#define MAXCR 10

// To determine winning conditions, we add rows of counters to see if their
// sum is a multiple of WINLINE.  Thus, empty cells are stored as -WINLINE
// to prevent winning conditions if empty cells are presents
typedef enum FIAL_CounterType {
    FIAL_Empty = -WINLINE,
    FIAL_Error = 0,
    FIAL_YellowPlayer = 1,
    FIAL_RedPlayer = 2,
} FIAL_CounterType;

@interface FIALGameModel : NSObject


// =======================================================================================
//
// The FIALGameModel was developed as a Model class to support the game Four in a Row.
// It's design has been to be as general as possible, allowing for game boards of any
// size (notionally greater than WINLINE - typically 4).
//
// The macro value WINLINE determines how many counters shoud appear in a line for a
// player to win.  This can be varied (in code) to permit longer lines.
//
// The Enumerated types FIAL_CounterType represent counters or states in the model.  They have
// the values:
//    FIAL_Error - this is reserved for error conditions
//    FIAL_Empty - the counter is "empty"; i.e. there is no counter
//    FIAL_YellowPlayer - the counter represents the "yellow" player
//    FIAL_RedPlayer - the counter represents the "red" player
//
// Note that these enumerated types actually represent integers, and their value is used
// when determining the winning condition.

// ===========================
// Properties
//
// Two properties have been defined, to determine the state of the game.
// The first, currentPlayer determines who the current player is.  Thus, an application
// can use this to determine the current player, or by using the setter, set the
// current player (typically after creating a new game).

@property (nonatomic, assign) FIAL_CounterType currentPlayer;   // Determines the current player of a game
@property (nonatomic, assign) NSInteger currentStep;
// The second property determines if the game is over.  This is a readonly property, and
// is called by using the method "isGameOver".  This is a standard pattern when defining
// getters on boolean properties.
@property (nonatomic, assign, readonly, getter=isGameOver) BOOL gameOver; // Determines when the game is over

// ===========================
// Setting up the Model
//
// A model should always be initialised using the following method:

-(FIALGameModel *)initWithRows:(NSInteger)rows columns:(NSInteger)cols;
-(void)setGameOver:(BOOL)gameOver;
// This initialises the new model, and specifies the size of the board in terms of
// rows and columns.  In most cases (for the traditional four in a row game), this
// would be implemented (as a 7 column by 6 row board) as:
//
//     FIALGameModel *model = [[FIALGameModel alloc] initWithRows:6 columns:7];
//
//
// This will also ensure that all the defualt values and internal state have been
// defined.  The method will eaither return a new instance of the model, or nil
// if something has gone wrong.  The number of rows and columns can later be
// queried using the two methods:

-(NSInteger) getColumns;
-(NSInteger) getRows;
-(id)getAryOfGame;
// =======================================================================================
// Using the Model
//
// Two methods are used to update or query the model.  A game is modelled as a 1-dimensional
// array which has col * row elements (where col is the number of columns and row is the number
// of rows).  Thus the position of a counter can be converted into rows and columns using integer
// maths as follows:
//
// row = position / cols
// column = position % cols (i.e. modulo)
//
// For example, position 17 corresponds to row 2 (i.e. 17/7), and column 3 (i.e. 17%7)
// Position 0 is the first position in the top left of the board.
//
// Given this, the type of counter can now be retrieved by using the method:

-(FIAL_CounterType)getCounterAtPosition:(NSInteger)pos;

// Note that this returns an element of enum type FIAL_CounterType, which could
// correspond to a red counter, yellow counter or an empty space.  If there is
// error (for example, an invalid position is entered), then the value FIAL_Error
// will be returned.

// Adding a counter is based purely on the column number (not the position).  The following
// method takes an integer corresponding to the column, and returns either YES if the
// counter was successfully added, or NO if there was a problem (such as the column number
// was invalid; i.e. less that 0 or greater than or equal to the number of columns), or if
// the column was full.

-(BOOL)addCounterInColumn:(NSInteger)col;
-(NSInteger)getTheLastStep;
-(void)setGameArray:(NSMutableArray *)ary;

@end
