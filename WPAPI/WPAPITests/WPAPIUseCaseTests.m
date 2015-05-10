//
//  WPAPIUseCaseTests.m
//  WPAPI
//
//  Created by Softamo S.L.U on 09/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WPAPIUseCase.h"
#import "WPAPIFetcherMock.h"

@interface WPAPIUseCase (Tests)

- (void)setFetcher:(WPAPIFetcher *)fetcher;

@end

@interface WPAPIUseCaseTests : XCTestCase

@property (nonatomic, strong)WPAPIUseCase *useCase;

@end

@implementation WPAPIUseCaseTests

- (void)setUp {
    [super setUp];
    self.useCase = [[WPAPIUseCase alloc] init];
    [self.useCase setFetcher:[[WPAPIFetcherMock alloc] init] ];
}

- (void)tearDown {
    self.useCase = nil;
    [super tearDown];
}

- (void)testFetchAllPosts {
    NSString *baseUrlStr = @"http://appfadeta.com";
    NSString *type = @"alojamiento";
    
    [self measureMetrics:@[XCTPerformanceMetric_WallClockTime] automaticallyStartMeasuring:NO forBlock:^{
        
        XCTestExpectation *expectation = [self expectationWithDescription:@"Fetching all Posts from Network"];
        
        
        [self startMeasuring];
        [self.useCase fetchAllPostsBaseUrlStr:baseUrlStr type:type completion:^(NSError *error, NSArray *posts) {

            if(posts != nil) {
                XCTAssertEqual(88, [posts count]);
            } else {
                XCTAssert(NO);
            }
            
            [expectation fulfill];
        }];
        
        [self waitForExpectationsWithTimeout:10.0 handler:nil];
        [self stopMeasuring];
        
    }];

}


@end
