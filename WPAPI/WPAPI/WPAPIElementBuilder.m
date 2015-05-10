//
//  WPAPIElementBuilder.m
//  WPAPI
//
//  Created by Softamo S.L.U on 06/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import "WPAPIElementBuilder.h"

@implementation WPAPIElementBuilder

- (id)parseDict:(NSDictionary *)dict key:(NSString *)key {
    
    if(![dict[key] isEqual:[NSNull null]] && dict[key] != nil) {
        if([dict[key] isKindOfClass:[NSNumber class]]) {
            return (NSNumber *)dict[key];
            
        } else if([dict[key] isKindOfClass:[NSString class]]) {
            return (NSString *)dict[key];
            
        } else if([dict[key] isKindOfClass:[NSArray class]]) {
            return (NSArray *)dict[key];
            
        }
    }
    return nil;
}


- (NSString *)parseStringWithKey:(NSString *)key inDict:(NSDictionary *)dict {
    if(![[dict objectForKey:key] isEqual:[NSNull null]] && [dict objectForKey:key] && ![[dict objectForKey:key] isEqualToString:@""]) {
        return [dict objectForKey:key];
    }
    return nil;
}


- (NSArray *)arrayFromJSON:(NSString *)objectNotation
                       key:(NSString *)key
                     error:(NSError **)error
      invalidJSONErrorCode:(NSInteger)invalidJSONErrorCode
      missingDataErrorCode:(NSInteger)missingDataErrorCode
               errorDomain:(NSString *)errorDomain {
    
    NSDictionary *parsedObject = [self parseJSON:objectNotation
                                           error:error
                            invalidJSONErrorCode:invalidJSONErrorCode
                                     errorDomain:errorDomain];
    if (parsedObject) {
        NSArray *elements = [parsedObject objectForKey:key];
        if(!elements && self.containerElementKey) {
            elements = [[parsedObject objectForKey:self.containerElementKey] objectForKey:key];
        }
        if (elements == nil) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:errorDomain code:missingDataErrorCode userInfo:nil];
            }
            return nil;
        }
        
        NSMutableArray *results = [NSMutableArray arrayWithCapacity:[elements count]];
        for (NSDictionary *parsedEl in elements) {
            id el = [self newElementWithDictionary:parsedEl
                                             error:error
                              invalidJSONErrorCode:invalidJSONErrorCode
                              missingDataErrorCode:missingDataErrorCode
                                       errorDomain:errorDomain];
            // Return nil becuase there has been an error in the previous method call
            if(!el) {
                return nil;
            }
            [results addObject:el];
        }
        return [results copy];
    }
    return nil;
}

- (NSArray *)parseJSONArray:(NSString *)objectNotation
                      error:(NSError **)error
       invalidJSONErrorCode:(NSInteger)invalidJSONErrorCode
                errorDomain:(NSString *)errorDomain  {
    id jsonObject;
    
    NSError *localError = nil;
    if(objectNotation != nil) {
        NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
        jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation
                                                     options:0
                                                       error:&localError];
    }
    NSArray *parsedObject = nil;
    if([jsonObject isKindOfClass:[NSArray class]]) {
        parsedObject = (NSArray *)jsonObject;
    }

    if (parsedObject == nil) {
        if (error != NULL) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
            if (localError != nil) {
                [userInfo setObject:localError forKey:NSUnderlyingErrorKey];
            }
            *error = [NSError errorWithDomain:errorDomain code:invalidJSONErrorCode userInfo:userInfo];
        }
        return nil;
    }
    return parsedObject;
}

- (NSDictionary *)parseJSON:(NSString *)objectNotation
                      error:(NSError **)error
       invalidJSONErrorCode:(NSInteger)invalidJSONErrorCode
                errorDomain:(NSString *)errorDomain  {
    
    NSParameterAssert(objectNotation != nil);
    id jsonObject;
    
    NSError *localError = nil;
    if(objectNotation != nil) {
        NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
        jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation
                                                     options:0
                                                       error:&localError];
    }
    NSDictionary *parsedObject = (id)jsonObject;
    if (parsedObject == nil) {
        if (error != NULL) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
            if (localError != nil) {
                [userInfo setObject:localError forKey:NSUnderlyingErrorKey];
            }
            *error = [NSError errorWithDomain:errorDomain code:invalidJSONErrorCode userInfo:userInfo];
        }
        return nil;
    }
    return parsedObject;
}

- (id)newElementWithDictionary:(NSDictionary *)dict
                         error:(NSError **)error
          invalidJSONErrorCode:(NSInteger)invalidJSONErrorCode
          missingDataErrorCode:(NSInteger)missingDataErrorCode
                   errorDomain:(NSString *)errorDomain {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end