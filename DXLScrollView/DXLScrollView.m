//
//  DXLScrollView.m
//  DXLScrollView
//
//  Created by Dai,Xianglong on 2018/12/27.
//  Copyright © 2018 Dai,Xianglong. All rights reserved.
//

#import "DXLScrollView.h"

@interface DXLScrollView()
@property (nonatomic, assign) CGRect startBounds;
@end

@implementation DXLScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initForDXLScrollView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initForDXLScrollView];
    }
    return self;
}

- (void)initForDXLScrollView {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestrue:)];
    [self addGestureRecognizer:panGesture];
}

- (void)handlePanGestrue:(UIPanGestureRecognizer*)panGesture {
    //Withing the process of pan ,change DXLScrollView's bounds
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.startBounds = self.bounds;
            break;
            
        case UIGestureRecognizerStateChanged : {
            CGPoint translation = [panGesture translationInView:self];
            CGRect bounds = self.startBounds;
            if (self.scrollVertical) {
                translation.x = 0;
            } else if (self.scrollHorizontal) {
                translation.y = 0;
            }
            
            CGFloat newBoundsOriginX = bounds.origin.x - translation.x;
            CGFloat minBoundsOriginX = 0;
            CGFloat maxBoundsOriginX = self.contentSize.width - bounds.size.width;
            CGFloat constrainsBoundsOriginX = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX));
            
            bounds.origin.x  = constrainsBoundsOriginX;
            
            CGFloat newBoundsOriginY = bounds.origin.y - translation.y;
            CGFloat minBoundsOriginY = 0;
            CGFloat maxBoundsOriginY = self.contentSize.height - bounds.size.height;
            CGFloat constrainsBoundsOriginY = fmax(minBoundsOriginY, fmin(newBoundsOriginY, maxBoundsOriginY));
            
            bounds.origin.y = constrainsBoundsOriginY;
            
            self.bounds = bounds;
            
        }
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
            
        default:
            break;
    }
}


@end
