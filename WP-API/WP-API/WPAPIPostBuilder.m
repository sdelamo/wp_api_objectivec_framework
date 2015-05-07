//
//  WPAPIPostBuilder.m
//  WP_API
//
//  Created by Softamo S.L.U on 06/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import "WPAPIPostBuilder.h"
#import "WPAPIPost.h"
#import "WPAPIAuthorBuilder.h"

static NSString *kID = @"ID";
static NSString *kTitle = @"title";
static NSString *kStatus = @"status";
static NSString *kType = @"type";
static NSString *kAuthor = @"author";
static NSString *kContent = @"content";
static NSString *kParent = @"parent";
static NSString *kLink = @"link";
static NSString *kDate = @"date";
static NSString *kModified = @"modified";
static NSString *kFormat = @"format";
static NSString *kSlug = @"slug";
static NSString *kGuid = @"guid";
static NSString *kExcerpt = @"excerpt";
static NSString *kMenuOrder = @"menu_order";
static NSString *kCommentStatus = @"comment_status";
static NSString *kPingStatus = @"ping_status";
static NSString *kSticky = @"sticky";
static NSString *kDateTz = @"date_tz";
static NSString *kDateGmt = @"date_gmt";
static NSString *kModifiedGmt = @"modified_gmt";
static NSString *kModifiedtz = @"modified_tz";
static NSString *kMeta = @"meta";
static NSString *kTerm = @"terms";

@interface WPAPIPostBuilder()

@property (nonatomic, strong)WPAPIAuthorBuilder *authorBuilder;

@end

@implementation WPAPIPostBuilder

- (NSArray *)postsFromJSON: (NSString *)objectNotation
             customBuilder:(id (^)(NSDictionary *dict))customBuilderClock
                     error: (NSError **)error {
    
    NSMutableArray *mutableArr = [[NSMutableArray alloc] init];

    
    NSArray *arr = [super parseJSONArray:objectNotation error:error
                    invalidJSONErrorCode:WPAPIPostBuilderInvalidJSONError
                             errorDomain:WPAPIPostBuilderErrorDomain];
    
    for(id obj in arr) {
        
        if([obj isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = (NSDictionary *)obj;
            
            NSError *error;
            id el = [self newElementWithDictionary:dict
                                             error:&error
                              invalidJSONErrorCode:WPAPIPostBuilderInvalidJSONError
                              missingDataErrorCode:WPAPIPostBuilderMissingDataError
                                       errorDomain:WPAPIPostBuilderErrorDomain];
            
            if([el isKindOfClass:[WPAPIPost class]]) {
                WPAPIPost *post = (WPAPIPost *)el;
                
                if(customBuilderClock) {
                    post.custom = customBuilderClock(dict);
                }
            }
            
            if(!error && el) {
                [mutableArr addObject:el];
            }
        }
        
    }
    return mutableArr;

}


- (id)newElementWithDictionary:(NSDictionary *)dict
                         error:(NSError **)error
          invalidJSONErrorCode:(NSInteger)invalidJSONErrorCode
          missingDataErrorCode:(NSInteger)missingDataErrorCode
                   errorDomain:(NSString *)errorDomain {
    
    WPAPIPost *post = [[WPAPIPost alloc] init];
    
    if([[dict objectForKey:kID] isKindOfClass:[NSNumber class]]) {
        post.identifier = (NSNumber *)[dict objectForKey:kID];
        
    } else {
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
        if(error != NULL) {
            *error = [NSError errorWithDomain:WPAPIPostBuilderErrorDomain
                                         code:WPAPIPostBuilderInvalidJSONError
                                     userInfo:userInfo];
        }
        return nil;
    }
    
    post.title = [super parseStringWithKey:kTitle inDict:dict];
    post.status = [super parseStringWithKey:kStatus inDict:dict];
    post.type = [super parseStringWithKey:kType inDict:dict];
    // Author
    post.content = [super parseStringWithKey:kContent inDict:dict];
    post.parent = [super parseStringWithKey:kParent inDict:dict];
    
    post.link = [super parseStringWithKey:kLink inDict:dict];
    // Date
    // Modified
    post.format = [super parseStringWithKey:kFormat inDict:dict];
    post.slug = [super parseStringWithKey:kSlug inDict:dict];
    post.guid = [super parseStringWithKey:kGuid inDict:dict];
    post.excerpt = [super parseStringWithKey:kExcerpt inDict:dict];
    // Menu Order
    // Comment status
    // Ping status
    
    return post;
}


#pragma mark - Lazy

- (WPAPIAuthorBuilder *)authorBuilder {
    if(!_authorBuilder) {
        _authorBuilder = [[WPAPIAuthorBuilder alloc] init];
        
    }
    return _authorBuilder;
}

@end

NSString *WPAPIPostBuilderErrorDomain = @"WPAPIPostBuilderErrorDomain";

