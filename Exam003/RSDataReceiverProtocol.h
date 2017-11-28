//
//  RSDataReceiverProtocol.h
//  Exam
//
//  Created by Mostafizur Rahman on 10/5/17.
//  Copyright © 2017 IPvision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol RSDataReceiverProtocol
-(void)exepectedDataLength:(const long long)data_leght;
-(void)receivedDataLength:(const long long)data_leght;
-(void)receivedDataPath:(NSString *)filePath;
-(void)receivedData:(NSData *)receiveData;
-(void)receivedString:(NSString *)jsonString;
@end
