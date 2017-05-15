//
//  ACInstagramJsonParser.m
//  ACInsagramFeed
//
//  Created by Chemersky on 5/15/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import "ACInstagramJsonParser.h"

@implementation ACInstagramJsonParser

+(NSString *)fullNameFromDictionary:(NSDictionary *)dictionary {
    return [[dictionary objectForKey:@"user"] objectForKey:@"full_name"];
}

+(NSString *)thumbnailUrlFromDictionary:(NSDictionary *)dictionary {
    return [[[dictionary objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"];
}

+(NSString *)profileImageUrlFromDictionary:(NSDictionary *)dictionary {
    return [[dictionary objectForKey:@"user"] objectForKey:@"profile_picture"];
}

+(NSString *)likesFromDictionary:(NSDictionary *)dictionary {
    return [[[dictionary objectForKey:@"likes"] objectForKey:@"count"] stringValue];
}

+(NSString *)photoUrlFromDictionary:(NSDictionary *)dictionary {
    return [[[dictionary objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
}

@end
