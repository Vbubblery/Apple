//
//  GameAreaView.m
//  C-4
//
//  Created by Bubble on 11/17/14.
//  Copyright (c) 2014 Bubble. All rights reserved.
//

#import "KUNQIANGameAreaView.h"
#import "FIALGameModel.h"
#import "JGActionSheet.h"
#import "KUNQIANGameData.h"
@implementation KUNQIANGameAreaView
KUNQIANGameData *game;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
FIALGameModel *model;
//draw the chessboard on the view.
-(void)drawTheBoard:(FIALGameModel *)tmodel{
    model = tmodel;
    game = [[KUNQIANGameData alloc]init];
    for (int i = 0; i < [model getRows]; ++i)
    {
        for (int j = 0; j < [model getColumns]; ++j)
        {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(700/model.getColumns * j,  630/model.getRows * i, 700/model.getColumns, 630/model.getRows)];
            [view setTag:j];
            //customer the view
            view.layer.borderWidth = 1;
            view.layer.borderColor = [[UIColor grayColor] CGColor];

            //if the position have added. show the picture
            if([model getCounterAtPosition:i* [model getColumns]+j] == FIAL_RedPlayer){
                UIImage *image = [UIImage imageNamed:@"redCounter"];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image] ;
                [imageView setFrame:CGRectMake(0, 0, 700/model.getColumns, 630/model.getRows)];
                [view addSubview:imageView];
            }
            else if([model getCounterAtPosition:i* [model getColumns]+j] == FIAL_YellowPlayer){
                UIImage *image = [UIImage imageNamed:@"yellowCounter"];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image] ;
                [imageView setFrame:CGRectMake(0, 0, 700/model.getColumns, 630/model.getRows)];
                [view addSubview:imageView];
            }

            //add the view into the view.
            [self addSubview:view];
        }
    }
}

@end
