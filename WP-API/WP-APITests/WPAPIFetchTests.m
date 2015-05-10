//
//  WPAPIFetchTests.m
//  WP_API
//
//  Created by Softamo S.L.U on 09/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WPAPIFetcherMock.h"

@interface WPAPIFetchTests : XCTestCase

@end

@implementation WPAPIFetchTests

- (void)setUp {
    [super setUp];


}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchPosts {
    
    NSString *baseUrlStr = @"http://appfadeta.com";
    NSString *type = @"alojamiento";
    
    [self measureMetrics:@[XCTPerformanceMetric_WallClockTime] automaticallyStartMeasuring:NO forBlock:^{
        
        XCTestExpectation *expectation = [self expectationWithDescription:@"Fetching from Network"];
        WPAPIFetcherMock *fetcher = [[WPAPIFetcherMock alloc] init];
        
        [self startMeasuring];
        [fetcher fetchPostsBaseUrlStr:baseUrlStr type:type completion:^(NSError *error, NSString *objectNotation, NSNumber *total, NSNumber *totalPages, NSString *link) {
            if(total != nil && totalPages != nil) {
                XCTAssert(YES);
            } else {
                XCTAssert(NO);
            }
            
            [expectation fulfill];
        }];
        
        [self waitForExpectationsWithTimeout:1.0 handler:nil];
        [self stopMeasuring];
        
    }];

}

@end
