//
//  WPAPIElementBuilder.h
//  WP_API
//
//  Created by Softamo S.L.U on 06/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WPAPIElementBuilderProtocol <NSObject>

- (id)newElementWithDictionary:(NSDictionary *)dict
                         error:(NSError **)error
          invalidJSONErrorCode:(NSInteger)invalidJSONErrorCode
          missingDataErrorCode:(NSInteger)missingDataErrorCode
                   errorDomain:(NSString *)errorDomain;
@end

@interface WPAPIElementBuilder : NSObject

@property (copy, nonatomic)NSString *containerElementKey;

- (id)parseDict:(NSDictionary *)dict key:(NSString *)key;

- (NSArray *)arrayFromJSON:(NSString *)objectNotation
                       key:(NSString *)key
                     error:(NSError **)error
      invalidJSONErrorCode:(NSInteger)invalidJSONErrorCode
      missingDataErrorCode:(NSInteger)missingDataErrorCode
               errorDomain:(NSString *)errorDomain;

- (NSDictionary *)parseJSON:(NSString *)objectNotation
                      error:(NSError **)error
       invalidJSONErrorCode:(NSInteger)invalidJSONErrorCode
                errorDomain:(NSString *)errorDomain;

- (NSArray *)parseJSONArray:(NSString *)objectNotation
                      error:(NSError **)error
       invalidJSONErrorCode:(NSInteger)invalidJSONErrorCode
                errorDomain:(NSString *)errorDomain;

- (NSString *)parseStringWithKey:(NSString *)key inDict:(NSDictionary *)dict;

@end

