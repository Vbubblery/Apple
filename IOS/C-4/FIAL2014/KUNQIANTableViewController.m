//
//  TableViewController.m
//  C-4
//
//  Created by Bubble on 11/18/14.
//  Copyright (c) 2014 Bubble. All rights reserved.
//

#import "KUNQIANTableViewController.h"
#import "KUNQIANTableViewCell.h"
#import "KUNQIANGameData.h"
#import "FIALGameModel.h"
#import "ViewController.h"
@interface KUNQIANTableViewController ()

@end

@implementation KUNQIANTableViewController
KUNQIANGameData *game;
NSUserDefaults *defaults;
FIALGameModel *model;
ViewController *view;
- (void)viewDidLoad {
    [super viewDidLoad];
    game = [[KUNQIANGameData alloc]init];
    defaults = [NSUserDefaults standardUserDefaults];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
//get the viewcontroller
-(void)setViewController:(ViewController*) c{
    view = c;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table View Data Source Methods
//return the row's count.
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [[defaults objectForKey:@"game"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    BOOL nibsRegistered = NO;
    //register the custom cell.
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"KUNQIANTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }

    KUNQIANTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          CellTableIdentifier];
    [self removeSubView:[cell screenView]];
    //get the game array positon
    NSMutableArray *tary = [[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"game"]];
    [self drawView:[cell screenView] :[[[tary objectAtIndex:[indexPath row]]objectAtIndex:3]integerValue] :[[[tary objectAtIndex:[indexPath row]]objectAtIndex:2]integerValue] :[[tary objectAtIndex:[indexPath row]]objectAtIndex:1]];
    [[cell statusLabel]setText:[[tary objectAtIndex:[indexPath row]]objectAtIndex:0]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set the height
    CGFloat height = 211;
    return height;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *ary = [[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"game"]];
        NSUInteger row = [indexPath row];
        if(row == [ary count]-1)
        {
            [view removeSubView];
        }
        [ary removeObjectAtIndex:row];
        [[NSUserDefaults standardUserDefaults] setObject:ary forKey:@"game"];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

//Click Event.....
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *tmp = [[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"game"]];
    tmp = [defaults objectForKey:@"game"];
    
    NSInteger arrayrow = [[[tmp objectAtIndex:[indexPath row]]objectAtIndex:3]integerValue];
    NSInteger arraycol = [[[tmp objectAtIndex:[indexPath row]]objectAtIndex:2]integerValue];
    
    //init a game with row and col.
    model = [[FIALGameModel alloc]initWithRows:arrayrow columns:arraycol];
    NSMutableArray * tmp2 = [[NSMutableArray alloc]initWithArray:[[tmp objectAtIndex:[indexPath row]]objectAtIndex:1]];
    [model setGameArray:tmp2];

    //send this game to the viewcontroller.
    [view initTheModel:model];

    NSString *str = [[tmp objectAtIndex:[indexPath row]]objectAtIndex:0];
    if ([str isEqual:@"gameover"]) {
        [model setGameOver:true];
    }
    else{
        [model setGameOver:false];
        if([str isEqualToString:@"yellow"])
            [model setCurrentPlayer:1];
        else
            [model setCurrentPlayer:2];
    }
            [[view statusOfGame]setText:str];
    NSMutableArray *ary = [[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"game"]];
    //when click the game. remove the game from the list
    [ary removeObjectAtIndex:[indexPath row]];
    [[NSUserDefaults standardUserDefaults] setObject:ary forKey:@"game"];
    //then create a new game on the end.
    [view newGAry];
    [self.tableView reloadData];
    [view removeSubView];
    [view drawTheChessBoard];
    
}
-(void)drawView:(UIView *)view :(int)row :(int)col :(NSMutableArray *)ary{
    for (int i = 0; i < row; ++i)
    {
        for (int j = 0; j < col; ++j)
        {
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(284/col * j,  144/row * i, 284/col, 144/row)];
            view1.layer.borderWidth = 1;
            view1.layer.borderColor = [[UIColor grayColor] CGColor];
            if([[ary objectAtIndex:i* col+j]integerValue] == 2){
                UIImage *image = [UIImage imageNamed:@"redCounter"];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image] ;
                [imageView setFrame:CGRectMake(0, 0, 284/col, 144/row)];
                [view1 addSubview:imageView];
            }
            else if([[ary objectAtIndex:i* col+j]integerValue] == 1){
                UIImage *image = [UIImage imageNamed:@"yellowCounter"];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image] ;
                [imageView setFrame:CGRectMake(0, 0, 284/col, 144/row)];
                [view1 addSubview:imageView];
            }
            [view addSubview:view1];
        }
    }

}
-(void)removeSubView:(UIView *)view{
    for (UIView *subView in [view subviews]) {
        for (UIView *image in [subView subviews]) {
            [image removeFromSuperview];
        }
        [subView removeFromSuperview];
    }
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
