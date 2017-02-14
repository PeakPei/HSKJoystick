//
//  Goblin.m
//  xiongmao
//
//  Created by scott on 16/9/20.
//  Copyright © 2016年 ZQ. All rights reserved.
//

#import "Goblin.h"

@interface Goblin (){
    NSArray *_idleFarams;
    NSArray *_walkFarams;
}
@end

@implementation Goblin

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
