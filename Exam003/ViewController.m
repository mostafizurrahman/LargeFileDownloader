//
//  ViewController.m
//  Exam003
//
//  Created by Mostafizur Rahman on 10/9/17.
//  Copyright © 2017 Mostafizur Rahman. All rights reserved.
//

#import "ViewController.h"
#import "RSHttpClient.h"

@interface ViewController (){
    UIProgressView * progressView;
    double expectedDataLength;
    double receivedDataLength;
    RSHttpClient *httpClient;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    httpClient = [[RSHttpClient alloc] init];
    httpClient.dataReceiverDelegate = self;
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)appWillResignActive:(NSNotification*)note
{
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    if (notification)
    {
        
        NSDate *fireTime = [[NSDate date] addTimeInterval:10]; // adds 10 secs
        notification.fireDate = fireTime;
        
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber = 1;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.repeatInterval = NSCalendarUnitDay;
        notification.alertBody = [NSString stringWithFormat:@"Your download is %0.2f% completed!", progressView.progress];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark data receive delegate
-(void)exepectedDataLength:(const long long)data_leght{
    expectedDataLength = data_leght;
    receivedDataLength = 0;
    
    if(!progressView){
        const CGSize viewSize = [[UIScreen mainScreen] bounds].size;
        progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, viewSize.height / 2 - 10, viewSize.width - 20, 20)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:progressView];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            progressView.progress = 0.0f;
        });
    }
    
}
-(void)receivedDataPath:(NSString *)filePath{
    [progressView removeFromSuperview];
    //here is the path of the large data file saved in local directory
    
}
-(void)receivedDataLength:(const long long)data_leght{
    receivedDataLength += data_leght;
    dispatch_async(dispatch_get_main_queue(), ^{
        progressView.progress = receivedDataLength / expectedDataLength;
    });
}
-(void)receivedData:(NSData *)receiveData{
    
    
}
-(void)receivedString:(NSString *)jsonString{
    
}
- (IBAction)startFileDownloading:(id)sender {
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [httpClient startLoading:@"http://dropbox.sandbox2000.com/intrvw/SampleVideo_1280x720_30mb.mp4"];
    //    });
    
}

@end
