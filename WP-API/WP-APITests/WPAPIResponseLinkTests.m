//
//  WPAPIResponseLinkTests.m
//  WP_API
//
//  Created by Softamo S.L.U on 09/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WPAPIResponseLink.h"

@interface WPAPIResponseLinkTests : XCTestCase

@property (nonatomic, strong)NSString *fixture;

@end

@implementation WPAPIResponseLinkTests

- (void)setUp {
    [super setUp];
    self.fixture = @"</wp-json/posts?type=alojamiento&page=2>; rel=\"next\", <http://appfadeta.com/wp-json/posts/1738>; rel=\"item\"; title=\"PARADOR 360\", <http://appfadeta.com/wp-json/posts/1470>; rel=\"item\"; title=\"Posada Los Cuatro Caños\", <http://appfadeta.com/wp-json/posts/1461>; rel=\"item\"; title=\"Pajaro Bobo\", <http://appfadeta.com/wp-json/posts/1458>; rel=\"item\"; title=\"Molingordo\", <http://appfadeta.com/wp-json/posts/1453>; rel=\"item\"; title=\"LAS RANAS CASA RURAL\", <http://appfadeta.com/wp-json/posts/1450>; rel=\"item\"; title=\"Las Hondonadas\", <http://appfadeta.com/wp-json/posts/1445>; rel=\"item\"; title=\"Las Herraduras\", <http://appfadeta.com/wp-json/posts/1440>; rel=\"item\"; title=\"La Ventana de Tejera Negra\", <http://appfadeta.com/wp-json/posts/1430>; rel=\"item\"; title=\"La Trucha Feliz\", <http://appfadeta.com/wp-json/posts/1424>; rel=\"item\"; title=\"La TravesaÃ±a Casa Rural\"";
}

- (void)tearDown {
    
    self.fixture = nil;
    
    [super tearDown];
}

- (void)testExtractResponseLinksFromString {
    // This is an example of a functional test case.

    NSArray *responseLinks = [WPAPIResponseLink extractResponseLinksFromString:self.fixture];
    
    NSUInteger expected = 11;
    XCTAssertEqual(expected, [responseLinks count]);
}

- (void)testNextPathForResponseLinks {

    NSString *expected = @"/wp-json/posts?type=alojamiento&page=2";
    
    NSArray *responseLinks = [WPAPIResponseLink extractResponseLinksFromString:self.fixture];
    NSString *result = [WPAPIResponseLink nextPathForResponseLinks:responseLinks];
    XCTAssertEqualObjects(expected, result);
}


@end
