//
//  ViewController.m
//  Flight Companion
//
//  Created by juncheng zhou on 6/17/14.
//
//

#import "ViewController.h"
@interface ViewController ()

@end
@implementation ViewController
@synthesize CounterText,Begin_Stop_Button,DDList,DDListArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    sec = 0;sec2 = 0;min = 0;min2 = 0;hour = 0;
    [CounterText setText:[NSString stringWithFormat:@"%d:%d%d:%d%d",hour,min,min2,sec,sec2]];
    localmanager = [[CLLocationManager alloc]init];
    DDListArray = [NSMutableArray arrayWithCapacity:6];
    lo=[NSMutableArray arrayWithCapacity:10];
    [self LoadTxt];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Begin_stop_action_button:(id)sender {
   

    if (counter==nil) {
        counter = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Countplusone) userInfo:nil repeats:YES
                   ];
         [Begin_Stop_Button setTitle:@"Stop!" forState:UIControlStateNormal];
        if([CLLocationManager locationServicesEnabled])
        {
            localmanager.desiredAccuracy = kCLLocationAccuracyBest;
            localmanager.delegate = self;
            [localmanager startUpdatingLocation];
        }else{}

           }
    else{
        [self Stop];
        [localmanager stopUpdatingLocation];
        [self ShowAlter];
    }
   
}
-(void)ShowAlter{
    BeginPosition=[self TheNearstAirPort:[lo firstObject]];
    EndPosition=[self TheNearstAirPort:[lo lastObject]];
    BeginPosition = [BeginPosition substringWithRange:NSMakeRange(0,4)];
    EndPosition = [EndPosition substringWithRange:NSMakeRange(0,4)];
    NSString *message = [NSString stringWithFormat:@"Departure:%@\nArrival:%@\nDuration:%@",BeginPosition,EndPosition,[NSString stringWithFormat:@"%d:%d%d:%d%d",hour,min,min2,sec,sec2]];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"Finished" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alter show];
    NSMutableArray *array = [[NSUserDefaults standardUserDefaults] mutableArrayValueForKey:@"past"];
    [array addObject:message];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"past"];

}
-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations
{
    [lo addObject:[locations lastObject]];
    
//    if (BeginPosition==nil) {
//        BeginPosition=[self TheNearstAirPort:[locations firstObject]];
//    }else
//    {
//        EndPosition=[self TheNearstAirPort:[locations lastObject]];
//        NSLog(@"%@%@",BeginPosition,EndPosition);
//        BeginPosition = [BeginPosition substringWithRange:NSMakeRange(0,4)];
//        EndPosition = [EndPosition substringWithRange:NSMakeRange(0,4)];
//        NSString *message = [NSString stringWithFormat:@"Departure:%@\nArrival:%@\nDuration:",BeginPosition,EndPosition];
//        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"Finished" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alter show];
//        NSMutableArray *array = [[NSUserDefaults standardUserDefaults] mutableArrayValueForKey:@"past"];
//        [array addObject:message];
//        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"past"];
//    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Fail: %@",error);
}
-(void)Stop{
    [counter invalidate];
}
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    CLLocationCoordinate2D loc = [newLocation coordinate];
//    
//    //    tflatitude.text = [NSString stringWithFormat: @"%f", loc.latitude];
//    NSLog(@"%f",loc.latitude);
//    //    tflongitude.text        = [NSString stringWithFormat: @"%f", loc.longitude];
//    //    tfaltitude.text = [NSString stringWithFormat: @"%f", newLocation.altitude];
//    
//    //将取得的经纬度传送给Goolge Map电子地图显示位置
//    //    if (stopenmap.on)
//    //    {
//    //        NSString *mapUrl = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%f,%f", loc.latitude, loc.longitude];
//    //        NSURL *url = [NSURL URLWithString:mapUrl];
//    //        [[UIApplication sharedApplication] openURL:url];
//    //    }
//    
//}
-(void)Countplusone{
    sec2 = sec2 + 1;
    if ( sec2 == 10 ) {
        sec2 = 0;
        sec = sec + 1;
    }
    if ( sec == 6 ) {
        sec= 0;
        min2=min2 + 1;
    }
    if ( min2 == 10 ) {
        min2 = 0;
        min = min + 1;
    }
    if ( min == 60 ) {
        min=0;
        hour=hour+1;
    }
    [CounterText setText:[NSString stringWithFormat:@"%d:%d%d:%d%d",hour,min,min2,sec,sec2]];
}
-(void)LoadTxt{
    NSString *filepath = @"/Users/junchengzhou/Desktop/Flight Companion/Flight Companion/raw-airfields.txt";
    NSString *str = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    NSArray *numArr = [str componentsSeparatedByString:@"\n"];
    for (NSString *k in numArr) {
        DDList = [NSMutableDictionary dictionaryWithCapacity:10];
        NSArray *tmp=[k componentsSeparatedByString:@","];
        CLLocation * position = [[CLLocation alloc] initWithLatitude:[[tmp objectAtIndex:1] floatValue] longitude:[[tmp objectAtIndex:2] floatValue]];
        [DDList setObject:[tmp objectAtIndex:0] forKey:@"name"];
        [DDList setObject:position forKey:@"position"];
        [DDListArray addObject:DDList];
        
    }
}
-(NSString *)TheNearstAirPort:(CLLocation*)location{
    NSLog(@"%f",location.coordinate.latitude);
    NSString* TheNearestPlace=@"";
    float TheNearestfloat=9990000000000000.0;
    for (id k in DDListArray) {
        float tmp =[location distanceFromLocation:[k objectForKey:@"position"]];
        if (tmp<TheNearestfloat) {
            TheNearestPlace=[k objectForKey:@"name"];
            TheNearestfloat=tmp;
        }
    }
    return TheNearestPlace;
}
@end
