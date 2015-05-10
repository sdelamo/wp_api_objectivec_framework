//
//  WPAPIResponseLink.m
//  WPAPI
//
//  Created by Softamo S.L.U on 09/05/15.
//  Copyright (c) 2015 Softamo S.L.U. All rights reserved.
//

#import "WPAPIResponseLink.h"

static NSString *kRelNext = @"next";
static NSString *kRelPrev = @"prev";
static NSString *kRelItem = @"prev";
static NSString *kRegex = @"^<(.*)>; rel=\"(item|next)\"(; title=\"(.*)\")?$";

@implementation WPAPIResponseLink

+ (NSArray *)extractResponseLinksFromString:(NSString *)str {
    NSMutableArray *responseLinks = [[NSMutableArray alloc] init];

    NSPredicate *responseLinkTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kRegex];
    
    NSError *error = NULL;
    // create the NSRegularExpression object and initialize it with a pattern
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kRegex options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *components = [str componentsSeparatedByString:@", "];
    for(NSString *component in components) {
        

        if([responseLinkTest evaluateWithObject:component]) {
            WPAPIResponseLink *responseLink = [[WPAPIResponseLink alloc] init];
            NSTextCheckingResult *match = [regex firstMatchInString:component options:0 range:NSMakeRange(0, component.length)];
            
            for (int groupNumber=1; groupNumber<match.numberOfRanges; groupNumber+=1) {
                NSRange groupRange = [match rangeAtIndex:groupNumber];
                if (groupRange.location != NSNotFound) {
                    NSString *value = [component substringWithRange:groupRange];
                    if(groupNumber == 1) {
                        responseLink.path = value;
                    } else if(groupNumber == 4) {
                        responseLink.title = value;
                    } else if(groupNumber == 2) {
                        if([value isEqualToString:kRelNext]) {
                            responseLink.rel = WPAPIResponseLinkRelNext;
                            
                        } else if([value isEqualToString:kRelItem]) {
                            
                            responseLink.rel = WPAPIResponseLinkRelItem;
                            
                        } else if([value isEqualToString:kRelPrev]) {
                            
                            responseLink.rel = WPAPIResponseLinkRelPrev;
                        }
                    }
                }
            }
            
            [responseLinks addObject:responseLink];
        }
    }
    
    return responseLinks;
}

+ (NSString *)nextPathForResponseLinks:(NSArray *)arr {
    
    for(id obj in arr) {
        if([obj isKindOfClass:[WPAPIResponseLink class]]) {
            WPAPIResponseLink *responseLink = (WPAPIResponseLink *)obj;
            
            if(responseLink.rel == WPAPIResponseLinkRelNext) {
                return [responseLink path];
            }
        }
    }
    return nil;
    
}


@end
