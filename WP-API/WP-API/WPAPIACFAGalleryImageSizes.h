//
//  WPAPIImageSize.h
//  WP_API
//
//  Created by Softamo S.L.U on 07/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPAPIACFAGalleryImageSizes : NSObject

@property (nonatomic, copy)NSString *thumbnail;
@property (nonatomic, copy)NSNumber *thumbnailWidth;
@property (nonatomic, copy)NSNumber *thumbnailHeight;

@property (nonatomic, copy)NSString *medium;
@property (nonatomic, copy)NSNumber *mediumWidth;
@property (nonatomic, copy)NSNumber *mediumHeight;

@property (nonatomic, copy)NSString *large;
@property (nonatomic, copy)NSNumber *largeWidth;
@property (nonatomic, copy)NSNumber *largeHeight;

@property (nonatomic, copy)NSString *postThumbnail;
@property (nonatomic, copy)NSNumber *postThumbnailWidth;
@property (nonatomic, copy)NSNumber *postThumbnailHeight;

@end
