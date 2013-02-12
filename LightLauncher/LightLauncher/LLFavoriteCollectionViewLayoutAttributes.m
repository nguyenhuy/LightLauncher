//
//  LLFavoriteCollectionViewLayoutAttributes.m
//  LightLauncher
//
//  Created by Huy Nguyen on 2/12/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteCollectionViewLayoutAttributes.h"

@implementation LLFavoriteCollectionViewLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
    LLFavoriteCollectionViewLayoutAttributes *attributes = [super copyWithZone:zone];
    attributes.deleteButtonHidden = self.deleteButtonHidden;
    return attributes;
}

@end
