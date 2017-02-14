//
//  Monster.m
//  CrazyLegend
//
//  Created by scott on 2017/2/14.
//  Copyright © 2017年 zhouqiao. All rights reserved.
//

#import "Monster.h"

@interface Monster (){
    NSArray *_idleFarams;
    NSArray *_walkFarams;
}
@end

@implementation Monster

+ (instancetype)monster{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"goblin_idle_0001"];
    return [Monster spriteNodeWithTexture:texture];
}

- (NSArray *)idleFarams{
    if(!_idleFarams){
        SKTextureAtlas *textureAtlas = [SKTextureAtlas atlasNamed:@"Goblin_Idle"];
        NSMutableArray *idleFarams = [NSMutableArray array];
        for(NSInteger i = 1; i < textureAtlas.textureNames.count; i++){
            SKTexture *texture = [textureAtlas textureNamed:[NSString stringWithFormat:@"goblin_idle_%04zd",i]];
            [idleFarams addObject:texture];
        }
        _idleFarams = idleFarams.copy;
    }
    return _idleFarams;
}

- (NSArray *)walkFarams{
    if(!_walkFarams){
        SKTextureAtlas *textureAtlas = [SKTextureAtlas atlasNamed:@"Goblin_Walk"];
        NSMutableArray *walkFarams = [NSMutableArray array];
        for(NSInteger i = 1; i < textureAtlas.textureNames.count; i++){
            SKTexture *texture = [textureAtlas textureNamed:[NSString stringWithFormat:@"goblin_walk_%04zd",i]];
            [walkFarams addObject:texture];
        }
        _walkFarams = walkFarams.copy;
    }
    return _walkFarams;
}

- (void)idle{
    SKAction *run = [SKAction animateWithTextures:self.idleFarams timePerFrame:0.05];
    [self runAction:[SKAction repeatActionForever:run]];
}

- (void)walk{
    SKAction *run = [SKAction animateWithTextures:self.walkFarams timePerFrame:0.05];
    [self runAction:[SKAction repeatActionForever:run]];
}

@end
