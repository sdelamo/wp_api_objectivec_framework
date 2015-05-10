//
//  WPAPILinks.h
//  WPAPI
//
//  Created by Softamo S.L.U on 06/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPAPILinks : NSObject

@property (nonatomic,copy) NSString *selfLink;
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *collection;
@property (nonatomic,copy) NSString *replies;
@property (nonatomic,copy) NSString *versionHistory;

@end
