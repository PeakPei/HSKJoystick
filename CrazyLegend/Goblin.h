//
//  Goblin.h
//  xiongmao
//
//  Created by scott on 16/9/20.
//  Copyright © 2016年 ZQ. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Goblin : SKSpriteNode

+ (instancetype)goblin;

@property (nonatomic, strong, readonly) NSArray *idleFarams;
@property (nonatomic, strong, readonly) NSArray *walkFarams;

- (void)idle;
- (void)walk;
@end
 
