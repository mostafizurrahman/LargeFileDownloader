//
//  RSHttpClient.m
//  Exam
//
//  Created by Mostafizur Rahman on 10/4/17.
//  Copyright © 2017 IPvision. All rights reserved.
//

#import "RSHttpClient.h"
#import <UIKit/UIKit.h>

@interface RSHttpClient(){
    
    NSString *largeFilePath;
    
    NSFileHandle *largeFileHandler;
}

@end

@implementation RSHttpClient




- (void) startLoading:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    
    [request setURL:[NSURL URLWithString:url]];
    NSURLConnection *url_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [url_connection start];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self removeTempDataFile];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    const NSUInteger data_leght = (NSUInteger)response.expectedContentLength;
    largeFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"data.mp4"];
    if([[NSFileManager defaultManager] createFileAtPath:largeFilePath contents:nil attributes:nil]){
        largeFileHandler = [NSFileHandle fileHandleForWritingAtPath:largeFilePath];
    }
    [self.dataReceiverDelegate exepectedDataLength:data_leght];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    if(largeFileHandler){
        [largeFileHandler writeData:data];
        [largeFileHandler synchronizeFile];
        [self.dataReceiverDelegate receivedDataLength:data.length];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [self.dataReceiverDelegate receivedDataPath:largeFilePath];
    [self removeTempDataFile];
}

-(void)removeTempDataFile{
    if([[NSFileManager defaultManager] removeItemAtPath:largeFilePath error:nil]){
        NSLog(@"removed");
    }
    largeFileHandler = nil;
    largeFilePath = nil;
}

@end
