//
//  KeyboardView.m
//  Peruticones
//
//  Created by RLoza on 1/8/16.
//  Copyright © 2016 Empresa Editora El Comercio. All rights reserved.
//

#import "KeyboardView.h"

@implementation KeyboardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        KeyboardView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
        view.frame = frame;
        
        [self addSubview:view];
    }
    
    return self;
}

@end
