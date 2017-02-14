//
//  GameScene.m
//  CrazyLegend
//
//  Created by scott on 2017/2/14.
//  Copyright © 2017年 zhouqiao. All rights reserved.
//

#import "GameScene.h"
#import "Monster.h"
#import "HSKJoystick.h"

@interface GameScene() <HSKJoystickDelegate>{
    BOOL _isJoystickTouchEnded;
    Monster *_monster;
    HSKJoystick *_joystick;
}

@end

@implementation GameScene

- (void)didMoveToView:(SKView *)view {

    _isJoystickTouchEnded = YES;
    
    Monster *monster = [Monster monster];
    monster.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    _monster = monster;
    [self addChild:monster];
    [_monster idle];
    
    HSKJoystick *joystick = [HSKJoystick joystickWithBackdropImageNamed:@"dpad" thumbImageNamed:@"joystick" thumbSize:CGSizeMake(60, 60) size:CGSizeMake(120, 120)];
    joystick.position = CGPointMake(-250, -100);
    joystick.delegate = self;
    _joystick = joystick;
    [self addChild:joystick];
}

- (void)joystick:(HSKJoystick *)joystick touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    _monster.zRotation = joystick.rotateAngle;
    
    if(_isJoystickTouchEnded){
        [_monster walk];
        _isJoystickTouchEnded = NO;
    }
    
    if(CGPointEqualToPoint(joystick.velocity, CGPointMake(0, 0))){
        joystick.trackingHandler = ^(){
            SKAction *move = [SKAction moveTo:CGPointMake(_monster.position.x + (_joystick.velocity.x * 0.2), _monster.position.y + (_joystick.velocity.y * 0.2)) duration:0.1];
            [_monster runAction:move];
        };
    }
}

- (void)joystick:(HSKJoystick *)joystick touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    _isJoystickTouchEnded = YES;;
    [_monster idle];
}

@end
