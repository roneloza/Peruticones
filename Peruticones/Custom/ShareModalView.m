//
//  ShareModalView.m
//  Peruticones
//
//  Created by RLoza on 12/1/15.
//  Copyright © 2015 Empresa Editora El Comercio. All rights reserved.
//

#import "ShareModalView.h"

@interface ShareModalView()

@property (nonatomic, strong) UIView *view;
@end

@implementation ShareModalView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        [self xibSetup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        
        [self xibSetup];
    }
    
    return self;
}

- (void)xibSetup {
    
    self.view = [self loadViewFromNib];
    
    // use bounds not frame or it'll be offset
    self.view.frame = self.bounds;
    
    // Make the view stretch with containing view
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Adding custom subview on top of our view (over any custom drawing > see note below)
    [self addSubview:self.view];
}

- (UIView *)loadViewFromNib {
    
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                  owner:self
                                                options:nil] objectAtIndex:0];
    
    return view;
}

@end
