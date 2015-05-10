//
//  WPAPIFetcherMock.h
//  WPAPI
//
//  Created by Softamo S.L.U on 10/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import "WPAPIFetcher.h"

@interface WPAPIFetcherMock : WPAPIFetcher

+ (NSString *)contentOfJSONFile:(NSString *)filename;

@end
