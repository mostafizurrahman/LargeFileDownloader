//
//  RSHttpClient.h
//  Exam
//
//  Created by Mostafizur Rahman on 10/4/17.
//  Copyright © 2017 IPvision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDataReceiverProtocol.h"

@interface RSHttpClient : NSObject<NSURLConnectionDelegate,  NSURLConnectionDataDelegate>
- (void) startLoading:(NSString *)url;
@property (readwrite, strong) id<RSDataReceiverProtocol> dataReceiverDelegate;
@end
