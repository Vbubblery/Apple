//
//  ViewController.h
//  Flight Companion
//
//  Created by juncheng zhou on 6/17/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    NSTimer *counter;
    int sec;
    int sec2;
    int min;
    int min2;
    int hour;
    CLLocationManager *localmanager;
    NSString *BeginPosition;
    NSString *EndPosition;
    NSMutableArray *lo;
}
@property (weak, nonatomic) IBOutlet UILabel *CounterText;
@property (weak, nonatomic) IBOutlet UIButton *Begin_Stop_Button;
@property (nonatomic,strong) NSMutableDictionary *DDList;
@property (nonatomic,strong) NSMutableArray *DDListArray;
- (IBAction)Begin_stop_action_button:(id)sender;
-(void)Countplusone;
-(void)Stop;
-(void)LoadTxt;
-(void)ShowAlter;
-(NSString *)TheNearstAirPort:(CLLocation*)location;
@end
