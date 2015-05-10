//
//  WPAPIResponseLink.h
//  WPAPI
//
//  Created by Softamo S.L.U on 09/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WPAPIResponseLinkRel) {
    WPAPIResponseLinkRelNext,
    WPAPIResponseLinkRelPrev,
    WPAPIResponseLinkRelItem,
};

@interface WPAPIResponseLink : NSObject

@property (nonatomic, copy) NSString *path;
@property (nonatomic) WPAPIResponseLinkRel rel;
@property (nonatomic, copy) NSString *title;

+ (NSArray *)extractResponseLinksFromString:(NSString *)str;

+ (NSString *)nextPathForResponseLinks:(NSArray *)arr;

@end
