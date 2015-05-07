//
//  WPAPIAttachment.h
//  WP_API
//
//  Created by Softamo S.L.U on 07/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPAPIACFAGalleryImageSizes;

@interface WPAPIACFAGalleryImage : NSObject

@property (nonatomic, copy)NSString *identifer;
@property (nonatomic, copy)NSString *alt;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *caption;
@property (nonatomic, copy)NSString *descr;
@property (nonatomic, copy)NSString *mimeType;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *width;
@property (nonatomic, copy)NSString *height;
@property (nonatomic, strong)WPAPIACFAGalleryImageSizes *sizes;

@end
