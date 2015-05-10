//
//  WPAPIUseCase.m
//  WPAPI
//
//  Created by Softamo S.L.U on 09/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import "WPAPIUseCase.h"
#import "WPAPIFetcher.h"
#import "WPAPIPostBuilder.h"
#import "WPAPIFetchResponse.h"

@interface WPAPIUseCase ()

@property (nonatomic, copy)NSString *baseUrlStr;
@property (nonatomic, strong)WPAPIFetcher *fetcher;
@property (nonatomic, strong)WPAPIPostBuilder *postBuilder;
@property (nonatomic, copy) void (^returnPostsBlock)(NSError *error, NSArray *posts);
@property (nonatomic, copy) WPAPIFetchResponse* (^postsProcessingBlock)(WPAPIPostBuilder *postBuilder, NSInteger numberOfElementsAlreadyProcessed, NSError *error, NSString *objectNotation, NSNumber *total, NSNumber *totalPages, NSString *link);
@property (nonatomic, strong)NSMutableArray *allposts;

@end

@implementation WPAPIUseCase

- (void)fetchAllPostsBaseUrlStr:(NSString *)baseUrlStr type:(NSString *)type completion:(void (^)(NSError *error, NSArray *posts))completion {
    self.baseUrlStr = baseUrlStr;
    self.returnPostsBlock = completion;
    
    self.postsProcessingBlock = ^WPAPIFetchResponse *(WPAPIPostBuilder *postBuilder, NSInteger numberOfElementsAlreadyProcessed, NSError *error, NSString *objectNotation, NSNumber *total, NSNumber *totalPages, NSString *link) {
        if(error) {
            if(completion) {
                completion(error, nil);
            }
            
            return nil;
        }
        
        if(!objectNotation || !total || !totalPages || !link) {
            if(completion) {
                completion(error, nil);
            }
            
            return nil;
        }
        
        NSError *builderError;
        NSArray *posts = [postBuilder postsFromJSON:objectNotation
                                           customBuilder:nil
                                                   error:&builderError];
        
        if(builderError) {
            if(completion) {
                completion(error, nil);
            }
            
            return nil;
        }
        
        WPAPIFetchResponse *fetchResponse = [[WPAPIFetchResponse alloc] init];
        fetchResponse.elements = posts;
        fetchResponse.nextPath = ([total unsignedIntegerValue] > (numberOfElementsAlreadyProcessed + [posts count])) ? link : nil;
        
        return fetchResponse;

        
    };
    
    [self fetchPostsForLink:[self.fetcher linkforBaseUrlStr:baseUrlStr type:type]];
}
                                                       
- (void)fetchPostsForLink:(NSString *)link {
    
    __weak WPAPIUseCase *weakSelf = self;
 
    [self.fetcher fetchPostLink:link completion:^(NSError *error, NSString *objectNotation, NSNumber *total, NSNumber *totalPages, NSString *link) {
        if(weakSelf.postsProcessingBlock) {
            
            WPAPIFetchResponse *fetchResponse = self.postsProcessingBlock(weakSelf.postBuilder, [weakSelf.allposts count], error, objectNotation, total, totalPages, link);
            [self.allposts addObjectsFromArray:fetchResponse.elements];
            
            if(fetchResponse.nextPath) {
                NSString *nextLink = [NSString stringWithFormat:@"%@%@", weakSelf.baseUrlStr, fetchResponse.nextPath];
                [weakSelf fetchPostsForLink:nextLink];
                
            } else {
                if(weakSelf.returnPostsBlock) {
                    weakSelf.returnPostsBlock(nil, [weakSelf.allposts copy]);
                }
                [weakSelf.allposts removeAllObjects];
                
            }
        }
    }];
}

#pragma mark - Lazy

- (NSMutableArray *)allposts {
    if(!_allposts) {
        _allposts = [[NSMutableArray alloc] init];
    }
    return _allposts;
}
        
- (WPAPIPostBuilder *)postBuilder {
    if(!_postBuilder) {
        _postBuilder = [[WPAPIPostBuilder alloc] init];
    }
    
    return _postBuilder;
}

- (WPAPIFetcher *)fetcher {
    
    if(!_fetcher) {
        
        _fetcher = [[WPAPIFetcher alloc] init];
        
    }
    
    return _fetcher;
}

@end
