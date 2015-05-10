//
//  WPAPIFetchResponse.h
//  WP_API
//
//  Created by Softamo S.L.U on 09/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPAPIFetchResponse : NSObject

@property (nonatomic, copy)NSArray *elements;
@property (nonatomic, copy)NSString *nextPath;

@end
