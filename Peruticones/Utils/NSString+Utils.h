//
//  NSString+Utils.h
//  TromeEnterate
//
//  Created by RLoza on 8/13/15.
//  Copyright (c) 2015 Empresa Editora El Comercio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (BOOL)validateStringEmail;

- (NSString *)md5;
- (NSString *)sha1;

- (NSURL *)URLFromString;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

+ (NSString *)stringByCurrentLocalDate;
+ (NSString *)stringLocalDateByDateUtc:(NSDate *)dateUtc;
+ (NSDate *)localDateByStringDateUtc:(NSString *)stringDateUtcGtm;
+ (NSString *)stringDateUtcRemoveGmtByStringDate:(NSString *)stringDateWithGmt;
+ (NSString *)stringDateUtcRemoveGmtByDateUtc:(NSDate *)dateUtc;
+ (NSDate *)localDateByDateUtc:(NSDate *)dateUtc;
+ (NSDate *)dateUtcByStringDateUtc:(NSString *)stringDateUt;

//+ (NSDate *)newDateFrom:(NSDate *)date addingDays:(NSInteger)days;
//+ (NSDate *)newDateFrom:(NSDate *)date addingSeconds:(NSTimeInterval)seconds;

+ (NSString *)stringDBValueOrDBNullFromInt:(NSInteger)value;
+ (NSString *)stringDBValueOrNil:(id)value;
+ (NSString *)stringDBValueOrDBNull:(id)value;

- (NSString *)stringByStrippingHTML;
- (NSString *)stringByHTMLString;
- (NSString *)stringByDecodeHTMLCharacterEntities;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict;
+ (NSString*)jsonStringFrom:(NSDictionary *)dict withPrettyPrint:(BOOL)prettyPrint;
@end
