//
//  ShareOption.h
//  Peruticones
//
//  Created by RLoza on 12/1/15.
//  Copyright © 2015 Empresa Editora El Comercio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, ShareOptionType) {
    ShareOptionTypeFacebook    = 0,
    ShareOptionTypeTwitter   = 1 << 0,
    ShareOptionTypeMessenger   = 1 << 1,
    ShareOptionTypeWhatsapp   = 1 << 2,
    ShareOptionTypeMail = 1 << 3,
};

@interface ShareOption : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) ShareOptionType shareOptionType;

- (instancetype)initWithTitle:(NSString *)title img:(NSString *)img shareOptionType:(ShareOptionType)shareOptionType;

+ (NSArray *)getAllShareOptions;

@end
