//
//  LLFavoriteCollectionViewCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 2/12/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LLFavoriteCollectionViewCell.h"
#import "LLFavoriteCollectionViewLayoutAttributes.h"
#import "LLCommandPrototype.h"

@interface LLFavoriteCollectionViewCell ()
- (void)setupViews;
@end

@implementation LLFavoriteCollectionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)dealloc {
    self.delegate = nil;
}

- (void)setupViews {
    float dim = MIN(self.bounds.size.width, self.bounds.size.height);
    float cornerRadius = dim / 20;
    
    self.title.layer.cornerRadius = cornerRadius;
    self.icon.layer.cornerRadius = cornerRadius;
}

- (void)updateViewWithCommandPrototype:(LLCommandPrototype *)commandPrototype atIndexPath:(NSIndexPath *)indexPath andDelegate:(id<LLFavoriteCollectionViewCellDelegate>)delegate {
    self.indexPath = indexPath;
    self.delegate = delegate;
    self.icon.image = [UIImage imageNamed:commandPrototype.iconFileName];
    self.title.text = commandPrototype.desc;
}

- (void)delete:(id)sender {
    [self.delegate onDelete:self];
}

- (void)applyLayoutAttributes:(LLFavoriteCollectionViewLayoutAttributes *)layoutAttributes {
    if (layoutAttributes.deleteButtonHidden) {
        self.deleteBtn.hidden = YES;
        [self stopQuivering];
    } else {
        self.deleteBtn.hidden = NO;
        [self startQuivering];
    }
}

- (void)startQuivering {
    CABasicAnimation *quiverAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    float startAngle = (-2) * M_PI/180.0;
    float stopAngle = -startAngle;
    quiverAnim.fromValue = [NSNumber numberWithFloat:startAngle];
    quiverAnim.toValue = [NSNumber numberWithFloat:3 * stopAngle];
    quiverAnim.autoreverses = YES;
    quiverAnim.duration = 0.2;
    quiverAnim.repeatCount = HUGE_VALF;
    float timeOffset = (float)(arc4random() % 100)/100 - 0.50;
    quiverAnim.timeOffset = timeOffset;
    CALayer *layer = self.layer;
    [layer addAnimation:quiverAnim forKey:@"quivering"];
}

- (void)stopQuivering {
    CALayer *layer = self.layer;
    [layer removeAnimationForKey:@"quivering"];
}

@end
