//
//  Monster.h
//  CrazyLegend
//
//  Created by scott on 2017/2/14.
//  Copyright © 2017年 zhouqiao. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Monster : SKSpriteNode

+ (instancetype)monster;

@property (nonatomic, strong, readonly) NSArray *idleFarams;
@property (nonatomic, strong, readonly) NSArray *walkFarams;

- (void)idle;
- (void)walk;

@end
