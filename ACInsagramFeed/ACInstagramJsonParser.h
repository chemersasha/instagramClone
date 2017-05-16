//
//  ACInstagramJsonParser.h
//  ACInsagramFeed
//
//  Created by Chemersky on 5/15/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACInstagramJsonParser : NSObject

+(NSString *)fullNameFromDictionary:(NSDictionary *)dictionary;
+(NSString *)thumbnailUrlFromDictionary:(NSDictionary *)dictionary;
+(NSString *)profileImageUrlFromDictionary:(NSDictionary *)dictionary;
+(NSString *)likesFromDictionary:(NSDictionary *)dictionary;
+(NSString *)photoUrlFromDictionary:(NSDictionary *)dictionary;
+(NSString *)paginationNextUrlFromDictionary:(NSDictionary *)dictionary;

@end
