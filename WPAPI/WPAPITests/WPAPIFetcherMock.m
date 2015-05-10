//
//  WPAPIFetcherMock.m
//  WPAPI
//
//  Created by Softamo S.L.U on 10/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import "WPAPIFetcherMock.h"

@implementation WPAPIFetcherMock


- (void)executeDownloadTaskWithBaseUrl:(NSURL *)baseUrl completionHandler:(void (^)(NSDictionary *headers, NSString *objectNotation, NSError *error))completion {
    
    int index = (arc4random() % 30);
    float delay = index > 0 ? index / 100.0f : 0.0f;
    [NSThread sleepForTimeInterval:delay];

   
    NSString *objectNotation;
    NSDictionary *headers;
    if([[baseUrl absoluteString] isEqualToString:@"http://appfadeta.com/wp-json/posts?type=alojamiento"]) {
        objectNotation = [WPAPIFetcherMock contentOfJSONFile:@"posts-page1"];
        headers = [self headersAtIndex:0];
        
    } else if([[baseUrl absoluteString] isEqualToString:@"http://appfadeta.com/wp-json/posts?type=alojamiento&page=2"]) {
        objectNotation = [WPAPIFetcherMock contentOfJSONFile:@"posts-page2"];
        headers = [self headersAtIndex:1];
        
    } else if([[baseUrl absoluteString] isEqualToString:@"http://appfadeta.com/wp-json/posts?type=alojamiento&page=3"]) {
        objectNotation = [WPAPIFetcherMock contentOfJSONFile:@"posts-page3"];
        headers = [self headersAtIndex:2];
        
    } else if([[baseUrl absoluteString] isEqualToString:@"http://appfadeta.com/wp-json/posts?type=alojamiento&page=4"]) {
        objectNotation = [WPAPIFetcherMock contentOfJSONFile:@"posts-page4"];
        headers = [self headersAtIndex:3];
        
    } else if([[baseUrl absoluteString] isEqualToString:@"http://appfadeta.com/wp-json/posts?type=alojamiento&page=5"]) {
        objectNotation = [WPAPIFetcherMock contentOfJSONFile:@"posts-page5"];
        headers = [self headersAtIndex:4];
        
    } else if([[baseUrl absoluteString] isEqualToString:@"http://appfadeta.com/wp-json/posts?type=alojamiento&page=6"]) {
        objectNotation = [WPAPIFetcherMock contentOfJSONFile:@"posts-page6"];
        headers = [self headersAtIndex:5];
        
    } else if([[baseUrl absoluteString] isEqualToString:@"http://appfadeta.com/wp-json/posts?type=alojamiento&page=7"]) {
        objectNotation = [WPAPIFetcherMock contentOfJSONFile:@"posts-page7"];
        headers = [self headersAtIndex:6];
        
    } else if([[baseUrl absoluteString] isEqualToString:@"http://appfadeta.com/wp-json/posts?type=alojamiento&page=8"]) {
        objectNotation = [WPAPIFetcherMock contentOfJSONFile:@"posts-page8"];
        headers = [self headersAtIndex:7];
        
    } else if([[baseUrl absoluteString] isEqualToString:@"http://appfadeta.com/wp-json/posts?type=alojamiento&page=9"]) {
        objectNotation = [WPAPIFetcherMock contentOfJSONFile:@"posts-page9"];
        headers = [self headersAtIndex:8];
        
    }

    
    if(completion) {
        completion(headers, objectNotation,nil);
    }
    


}

- (NSDictionary *)headersAtIndex:(NSInteger)index {
    NSString *plistPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"ResponseHeaders" ofType:@"plist"];
    NSArray *headers = [[NSArray alloc] initWithContentsOfFile:plistPath];
    return [headers count] > index ? headers[index] : nil;
}


+ (NSString *)contentOfJSONFile:(NSString *)filename {
    
    NSString *contentPath = [[NSBundle bundleForClass:[self class]] pathForResource:filename
                                                                             ofType:@"json"];
    NSURL *contentURL = [NSURL fileURLWithPath:contentPath];
    return [NSString stringWithContentsOfURL:contentURL
                                    encoding:NSUTF8StringEncoding
                                       error:nil];
}

@end
