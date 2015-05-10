//
//  MovilRuralFetcher.h
//  Movil Rural
//
//  Created by Softamo S.L.U on 30/03/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WPAPIFetcher : NSObject

- (void)fetchPostsBaseUrlStr:(NSString *)baseUrlStr type:(NSString *)type completion:(void (^)(NSError *error, NSString *objectNotation, NSNumber *total, NSNumber *totalPages, NSString *path))completion;

- (NSString *)linkforBaseUrlStr:(NSString *)baseUrlStr type:(NSString *)type;

- (void)fetchPostLink:(NSString *)link completion:(void (^)(NSError *error, NSString *objectNotation, NSNumber *total, NSNumber *totalPages, NSString *path))completion;

@end

