//
//  WPAPIUseCase.h
//  WP_API
//
//  Created by Softamo S.L.U on 09/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPAPIFetcher;

@interface WPAPIUseCase : NSObject

@property (nonatomic, strong)WPAPIFetcher *fetcher;

- (void)fetchAllPostsBaseUrlStr:(NSString *)baseUrlStr type:(NSString *)type completion:(void (^)(NSError *error, NSArray *posts))completion;

@end
