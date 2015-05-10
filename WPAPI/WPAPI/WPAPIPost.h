//
//  WPAPIPost.h
//  WPAPI
//
//  Created by Softamo S.L.U on 06/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPAPIAuthor;

@interface WPAPIPost : NSObject

@property (nonatomic, copy)NSNumber *identifier;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)WPAPIAuthor *author;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *parent;
@property (nonatomic, copy)NSString *link;
@property (nonatomic, copy)NSDate *date;
@property (nonatomic, copy)NSDate *modified;
@property (nonatomic, copy)NSString *standard;
@property (nonatomic, copy)NSString *format;
@property (nonatomic, copy)NSString *slug;
@property (nonatomic, copy)NSString *guid;
@property (nonatomic, copy)NSString *excerpt;
@property (nonatomic, copy)NSNumber *menuOrder;
@property (nonatomic, copy)NSString *commentStatus;
@property (nonatomic, copy)NSString *pingStatus;
@property (nonatomic)BOOL sticky;

@property (nonatomic,strong)id custom;

@end
