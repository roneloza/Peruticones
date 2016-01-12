//
//  Emoticon.m
//  Peruticones
//
//  Created by RLoza on 11/30/15.
//  Copyright © 2015 Empresa Editora El Comercio. All rights reserved.
//

#import "Emoticon.h"
#import "Constants.h"

@implementation Emoticon

- (instancetype)initWithPng:(NSString *)png facebook:(NSString *)facebook twitter:(NSString *)twitter whatsapp:(NSString *)whatsapp gif:(NSString *)gif title:(NSString *)title {
    
    self = [super init];
    
    if (self) {
        _png = png;
        _facebook = facebook;
        _twitter = twitter;
        _whatsapp = whatsapp;
        _gif = gif;
        _title = title;
    }
    
    return self;
}

+ (NSArray *)getAllEmoticons {
    
    NSString *img = [[NSString alloc] initWithFormat:@"1-politico.png"];
    NSString *gif = [[NSString alloc] initWithFormat:@"1-politico.gif"];
    NSString *imgFB = [[NSString alloc] initWithFormat:@"1-politico-%@.png", kFacebook];
    NSString *imgTW = [[NSString alloc] initWithFormat:@"1-politico-%@.png", kTwitter];
    NSString *imgWH = [[NSString alloc] initWithFormat:@"1-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon1 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"acuña"];
    
    img = [[NSString alloc] initWithFormat:@"2-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"2-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"2-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"2-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"2-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon2 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"lay"];
    
    img = [[NSString alloc] initWithFormat:@"3-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"3-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"3-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"3-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"3-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon3 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"lourdes"];
    
    img = [[NSString alloc] initWithFormat:@"4-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"4-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"4-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"4-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"4-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon4 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"keiko"];
    
    img = [[NSString alloc] initWithFormat:@"5-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"5-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"5-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"5-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"5-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon5 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"alberto fujimori"];
    
    img = [[NSString alloc] initWithFormat:@"6-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"6-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"6-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"6-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"6-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon6 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"antero"];
    
    img = [[NSString alloc] initWithFormat:@"7-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"7-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"7-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"7-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"7-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon7 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"alan"];
    
    img = [[NSString alloc] initWithFormat:@"8-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"8-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"8-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"8-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"8-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon8 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"julio guzmán"];
    
    img = [[NSString alloc] initWithFormat:@"9-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"9-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"9-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"9-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"9-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon9 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"nadine"];
    
    img = [[NSString alloc] initWithFormat:@"10-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"10-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"10-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"10-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"10-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon10 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"ollanta"];
    
    img = [[NSString alloc] initWithFormat:@"11-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"11-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"11-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"11-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"11-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon11 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"ppk"];
    
    img = [[NSString alloc] initWithFormat:@"12-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"12-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"12-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"12-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"12-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon12 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"veronika mendoza"];
    
    img = [[NSString alloc] initWithFormat:@"13-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"13-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"13-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"13-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"13-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon13 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"outsider"];
    
    img = [[NSString alloc] initWithFormat:@"14-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"14-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"14-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"14-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"14-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon14 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"toledo"];
    
    img = [[NSString alloc] initWithFormat:@"15-politico.png"];
    gif = [[NSString alloc] initWithFormat:@"15-politico.gif"];
    imgFB = [[NSString alloc] initWithFormat:@"15-politico-%@.png", kFacebook];
    imgTW = [[NSString alloc] initWithFormat:@"15-politico-%@.png", kTwitter];
    imgWH = [[NSString alloc] initWithFormat:@"15-politico-%@.png", kWhatsapp];
    
    Emoticon *emoticon15 = [[Emoticon alloc] initWithPng:img facebook:imgFB twitter:imgTW whatsapp:imgWH gif:gif title:@"urresti"];
    
    NSArray *emotions = [[NSArray alloc] initWithObjects:
                         emoticon1,
                         emoticon2,
                         emoticon3,
                         emoticon4,
                         emoticon5,
                         emoticon6,
                         emoticon7,
                         emoticon8,
                         emoticon9,
                         emoticon10,
                         emoticon11,
                         emoticon12,
                         emoticon13,
                         emoticon14,
                         emoticon15, nil];
    
    return emotions;
}

@end
