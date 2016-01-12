
//
//  ShareOption.m
//  Peruticones
//
//  Created by RLoza on 12/1/15.
//  Copyright © 2015 Empresa Editora El Comercio. All rights reserved.
//

#import "ShareOption.h"

@implementation ShareOption

- (instancetype)initWithTitle:(NSString *)title img:(NSString *)img shareOptionType:(ShareOptionType)shareOptionType  {
    
    if ((self = [super init])) {
        
        _title = title;
        _img = img;
        _shareOptionType = shareOptionType;
    }
    
    return self;
}

+ (NSArray *)getAllShareOptions {
    
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [[ShareOption alloc] initWithTitle:NSLocalizedString(@"TextFacebook", nil) img:@"facebook-app-icon.png" shareOptionType:ShareOptionTypeFacebook],
                        [[ShareOption alloc] initWithTitle:NSLocalizedString(@"TextMessenger", nil) img:@"mesenger-app-icon.png" shareOptionType:ShareOptionTypeMessenger],
                        [[ShareOption alloc] initWithTitle:NSLocalizedString(@"TextTwitter", nil) img:@"twitter-app-icon.png" shareOptionType:ShareOptionTypeTwitter],
                        [[ShareOption alloc] initWithTitle:NSLocalizedString(@"TextWhatsapp", nil) img:@"whatsapp-app-icon.png"  shareOptionType:ShareOptionTypeWhatsapp],
                        [[ShareOption alloc] initWithTitle:NSLocalizedString(@"TextMail", nil) img:@"mail-app-icon.png"  shareOptionType:ShareOptionTypeMail],
                        nil];
    
    return options;
    
}

@end
