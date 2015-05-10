//
//  MovilRuralFetcher.m
//  Movil Rural
//
//  Created by Softamo S.L.U on 30/03/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import "WPAPIFetcher.h"
#import "WPAPIResponseLink.h"


static NSString *kWPAPIReponseHeaderTotal = @"X-WP-Total";
static NSString *kWPAPIReponseHeaderTotalPages = @"X-WP-TotalPages";
static NSString *kWPAPIReponseHeaderLink = @"Link";


@implementation WPAPIFetcher

- (void)fetchPostsBaseUrlStr:(NSString *)baseUrlStr type:(NSString *)type completion:(void (^)(NSError *error, NSString *objectNotation, NSNumber *total, NSNumber *totalPages, NSString *link))completion {

    NSString *urlStr = [self linkforBaseUrlStr:baseUrlStr type:type];

    [self fetchPostLink:urlStr completion:^(NSError *error, NSString *objectNotation, NSNumber *total, NSNumber *totalPages, NSString *link) {
        if(completion) {
            completion(error,objectNotation, total, totalPages, link);
        }
    }];
    
}

- (NSString *)linkforBaseUrlStr:(NSString *)baseUrlStr type:(NSString *)type {
    
    return [NSString stringWithFormat:@"%@/wp-json/posts?type=%@",baseUrlStr,type];
}

- (void)fetchPostLink:(NSString *)link completion:(void (^)(NSError *error, NSString *objectNotation, NSNumber *total, NSNumber *totalPages, NSString *link))completion {
    
    NSURL *baseUrl = [[NSURL alloc] initWithString:link];

    [self executeDownloadTaskWithBaseUrl:baseUrl completionHandler:^(NSDictionary *headers, NSString *objectNotation, NSError *error) {
        
        if(error == nil) {
            
            NSNumber *total =[NSDecimalNumber decimalNumberWithString:headers[kWPAPIReponseHeaderTotal]];
            NSNumber *totalPages = [NSDecimalNumber decimalNumberWithString:headers[kWPAPIReponseHeaderTotalPages]];
            NSArray *responseLinks = [WPAPIResponseLink extractResponseLinksFromString:headers[kWPAPIReponseHeaderLink]];
            NSString *path = [WPAPIResponseLink nextPathForResponseLinks:responseLinks];
            

            if(completion) {
                completion(nil, objectNotation, total, totalPages, path);
            }
        } else {
            if(completion) {
                completion(error, nil, nil, nil, link);
            }
        }
        
    }];
}

- (void)executeDownloadTaskWithBaseUrl:(NSURL *)baseUrl completionHandler:(void (^)(NSDictionary *headers, NSString *objectNotation, NSError *error))completion {
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [sharedSession downloadTaskWithURL:baseUrl  completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if(completion) {
            
            if(error == nil) {
                NSDictionary *headerFiles = [((NSHTTPURLResponse *)response) allHeaderFields];
                NSData *dataObject = [NSData dataWithContentsOfURL:location];
                NSString *objectNotation = [[NSString alloc] initWithData:dataObject
                                                                 encoding:NSUTF8StringEncoding];
                
                completion(headerFiles, objectNotation, nil);
            } else {
                completion(nil, nil, error);
            }
        }
    }];
    [downloadTask resume];
}

@end