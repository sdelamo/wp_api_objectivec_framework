//
//  WPAPITests.m
//  WPAPITests
//
//  Created by Softamo S.L.U on 06/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WPAPIPostBuilder.h"
#import "WPAPIPost.h"
#import "WPAPIACFAGalleryImage.h"
#import "WPAPIACFAGalleryImageSizes.h"

@interface WPAPITests : XCTestCase

@property (nonatomic, strong) WPAPIPostBuilder *builder;
@end

@implementation WPAPITests

- (void)setUp {
    [super setUp];
    
    self.builder = [[WPAPIPostBuilder alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    self.builder = nil;
    [super tearDown];
}

- (void)testPostsFromJSON {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    
    NSString* jsonStr = [self contentOfJSONFile:@"posts"];
    
    typedef id (^CustomBuilderBlock)(NSDictionary *dict);
    CustomBuilderBlock block = ^id(NSDictionary *dict) {
        
        NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] init];
        
        id obj = [dict objectForKey:@"acf"];
        
        if([obj isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *acfDict = (NSDictionary *)obj;
            returnDict[@"url"]          = acfDict[@"url"];
            returnDict[@"email"]        = acfDict[@"email"];
            returnDict[@"phone"]        = acfDict[@"phone"];
            returnDict[@"latitude"]     = acfDict[@"latitude"];
            returnDict[@"longitude"]    = acfDict[@"longitude"];
            returnDict[@"street"]       = acfDict[@"street"];
            returnDict[@"town"]         = acfDict[@"town"];
            returnDict[@"region"]       = acfDict[@"region"];
            returnDict[@"postal_code"]  = acfDict[@"postal_code"];
            returnDict[@"countryname"]  = acfDict[@"countryname"];
            returnDict[@"toprural"]     = acfDict[@"toprural"];
            returnDict[@"facebook"]     = acfDict[@"facebook"];
            returnDict[@"twitter"]      = acfDict[@"twitter"];
            returnDict[@"tuenti"]       = acfDict[@"tuenti"];
            returnDict[@"google_plus"]  = acfDict[@"google_plus"];
            
            NSMutableArray *mutableAttArr = [[NSMutableArray alloc] init];
            
            for(id galeryObj in acfDict[@"galeria"]) {
                if([galeryObj isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *galeryDict = (NSDictionary *)galeryObj;
                    WPAPIACFAGalleryImage *att = [[WPAPIACFAGalleryImage alloc] init];
                    att.identifer   = galeryDict[@"id"];
                    att.alt         = galeryDict[@"alt"];
                    att.title       = galeryDict[@"title"];
                    att.caption     = galeryDict[@"caption"];
                    att.descr       = galeryDict[@"description"];
                    att.mimeType    = galeryDict[@"mime_tye"];
                    att.url         = galeryDict[@"url"];
                    att.width       = galeryDict[@"width"];
                    att.height      = galeryDict[@"height"];
                    WPAPIACFAGalleryImageSizes *sizes = [[WPAPIACFAGalleryImageSizes alloc] init];

                    
                    sizes.thumbnail             = galeryDict[@"sizes"][@"thumbnail"];
                    sizes.thumbnailWidth        = galeryDict[@"sizes"][@"thumbnail-width"];
                    sizes.thumbnailHeight       = galeryDict[@"sizes"][@"thumbnail-height"];
                    
                    sizes.medium                = galeryDict[@"sizes"][@"medium"];
                    sizes.mediumWidth           = galeryDict[@"sizes"][@"medium-width"];
                    sizes.mediumHeight          = galeryDict[@"sizes"][@"medium-height"];
                    
                    sizes.large                 = galeryDict[@"sizes"][@"large"];
                    sizes.largeWidth            = galeryDict[@"sizes"][@"large-width"];
                    sizes.largeHeight           = galeryDict[@"sizes"][@"large-height"];
                    
                    sizes.postThumbnail         = galeryDict[@"sizes"][@"post-thumbnail"];
                    sizes.postThumbnailWidth    = galeryDict[@"sizes"][@"post-thumbnail-width"];
                    sizes.postThumbnailHeight   = galeryDict[@"sizes"][@"post-thumbnail-height"];
                    
                    att.sizes = sizes;
                    
                    [mutableAttArr addObject:att];
                }
            }
            returnDict[@"gallery"] = mutableAttArr;
        }
        
        return returnDict;
    };
    
    NSError *error;
    NSArray *posts = [self.builder postsFromJSON:jsonStr
                                   customBuilder:block
                                   error:&error];
    XCTAssertNotNil(posts);
    NSInteger expected = 10;
    XCTAssertEqual([posts count], expected);
    
    id obj = [posts firstObject];
    
    XCTAssertTrue([obj isKindOfClass:[WPAPIPost class]]);
    
    WPAPIPost *post = (WPAPIPost *)obj;
    
    NSString *expectedStr = @"Restaurante Calle Mayor";
    XCTAssertEqualObjects(expectedStr, post.title);


    XCTAssertTrue([post.custom isKindOfClass:[NSDictionary class]]);
    
    expectedStr = @"<p>&nbsp;</p>";
    XCTAssertTrue([post.content hasPrefix:expectedStr]);
    
    NSDictionary *customDict = (NSDictionary *)post.custom;
    
    XCTAssertTrue([customDict[@"gallery"] isKindOfClass:[NSArray class]]);
    
    NSArray *gallery = customDict[@"gallery"];
    XCTAssertEqual([gallery count], 9);
}



- (NSString *)contentOfJSONFile:(NSString *)filename {
    
    NSString *contentPath = [[NSBundle bundleForClass:[self class]] pathForResource:filename
                                                                             ofType:@"json"];
    NSURL *contentURL = [NSURL fileURLWithPath:contentPath];
    return [NSString stringWithContentsOfURL:contentURL
                                    encoding:NSUTF8StringEncoding
                                       error:nil];
}


@end
