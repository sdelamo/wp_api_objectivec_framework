//
//  WPAPIPostBuilder.h
//  WPAPI
//
//  Created by Softamo S.L.U on 06/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import "WPAPIElementBuilder.h"

#import "WPAPIElementBuilder.h"

extern NSString *WPAPIPostBuilderErrorDomain;

enum {
    WPAPIPostBuilderInvalidJSONError,
    WPAPIPostBuilderMissingDataError,
};

/**
 * Construct WPAPIPost objects from an external representation.
 * @see SPTMXSmartList
 */
@interface WPAPIPostBuilder : WPAPIElementBuilder

/**
 * Given a string containing a JSON dictionary, return a list of WPAPIPost objects.
 * @param objectNotation The JSON string
 * @param error By-ref error signalling
 * @return An array of smart lists objects, or nil (with error set) if objectNotation cannot be parsed.
 * @see WPAPIPost
 */
- (NSArray *)postsFromJSON:(NSString *)objectNotation customBuilder:(id (^)(NSDictionary *dict))customBuilderClock error: (NSError **)error;

@end