//
//  WP_APITests.m
//  WP-APITests
//
//  Created by Softamo S.L.U on 06/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WPAPIPostBuilder.h"

@interface WP_APITests : XCTestCase

@property (nonatomic, strong) WPAPIPostBuilder *builder;
@end

@implementation WP_APITests

- (void)setUp {
    [super setUp];
    
    self.builder = [[WPAPIPostBuilder alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPostsFromJSON {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    
    NSString* jsonStr = [self contentOfJSONFile:@"posts"];
   
    NSError *error;
    NSArray *posts = [self.builder postsFromJSON:jsonStr error:&error];
    XCTAssertNotNil(posts);
    NSInteger expected = 10;
    XCTAssertEqual([posts count], expected);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
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
