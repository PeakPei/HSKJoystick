//
//  HSKJoystick.m
//  CrazyTank
//
//  Created by scott on 2017/2/7.
//  Copyright © 2017年 zhouqiao. All rights reserved.
//

#import "HSKJoystick.h"

@interface HSKJoystick (){
    SKSpriteNode *_backdropNode;
    SKSpriteNode *_thumbNode;
    BOOL _isTracking;
}
@end

@implementation HSKJoystick

+ (instancetype)joystickWithBackdropImageNamed:(NSString *)backdropName
                               thumbImageNamed:(NSString *)thumbnName
                                     thumbSize:(CGSize)thumbSize
                                          size:(CGSize)size{
    return [[self alloc] initWithBackdropImageNamed:backdropName thumbImageNamed:thumbnName thumbSize:thumbSize size:size];
}

- (instancetype)initWithBackdropImageNamed:(NSString *)backdropName
                           thumbImageNamed:(NSString *)thumbnName
                                 thumbSize:(CGSize)thumbSize
                                      size:(CGSize)size{
    self = [super init];
    if(self){
        _backdropName = backdropName;
        _thumbnName = thumbnName;
        _thumbSize = thumbSize;
        self.size = size;
        self.userInteractionEnabled = YES;
        
        SKSpriteNode *backdropNode = [SKSpriteNode spriteNodeWithImageNamed:_backdropName];
        backdropNode.size = self.size;
        _backdropNode = backdropNode;
        [self addChild:backdropNode];
        
        SKSpriteNode *thumbNode = [SKSpriteNode spriteNodeWithImageNamed:_thumbnName];
        thumbNode.size = _thumbSize;
        _thumbNode = thumbNode;
        [self addChild:thumbNode];
        
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(listen)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if([self.delegate respondsToSelector:@selector(joystick:touchesBegan:withEvent:)]){
        [self.delegate joystick:self touchesBegan:touches withEvent:event];
    }
    for (UITouch *touch in touches){
        CGPoint touchPoint = [touch locationInNode:self];
        if (_isTracking == NO && CGRectContainsPoint(_thumbNode.frame, touchPoint)){
            _isTracking = YES;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if([self.delegate respondsToSelector:@selector(joystick:touchesMoved:withEvent:)]){
        [self.delegate joystick:self touchesMoved:touches withEvent:event];
    }
    for (UITouch *touch in touches){
        CGPoint touchPoint = [touch locationInNode:self];
        if (_isTracking == YES && sqrtf(powf((touchPoint.x - _thumbNode.position.x), 2) + powf((touchPoint.y - _thumbNode.position.y), 2)) < _backdropNode.size.width * 2){
            if (sqrtf(powf(touchPoint.x, 2) + powf(touchPoint.y, 2)) <= _thumbNode.size.width){
                CGPoint moveDifference = CGPointMake(touchPoint.x, touchPoint.y);
                _thumbNode.position = CGPointMake(moveDifference.x, moveDifference.y);
            }else {
                CGFloat magV = sqrt(touchPoint.x * touchPoint.x + touchPoint.y * touchPoint.y);
                CGFloat x = touchPoint.x / magV * _thumbNode.size.width;
                CGFloat y = touchPoint.y / magV * _thumbNode.size.width;
                _thumbNode.position = CGPointMake(x, y);
            }
        }
        _velocity = CGPointMake(_thumbNode.position.x, _thumbNode.position.y);
        _rotateAngle = -atan2(_thumbNode.position.x, _thumbNode.position.y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if([self.delegate respondsToSelector:@selector(joystick:touchesEnded:withEvent:)]){
        [self.delegate joystick:self touchesEnded:touches withEvent:event];
    }
    [self reduction];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if([self.delegate respondsToSelector:@selector(joystick:touchesCancelled:withEvent:)]){
        [self.delegate joystick:self touchesCancelled:touches withEvent:event];
    }
    [self reduction];
}

- (void)listen{
    if(_isTracking && self.trackingHandler){
        self.trackingHandler();
    }
}

- (void)reduction{
    _isTracking = NO;
    _velocity = CGPointZero;
    SKAction *reduction = [SKAction moveTo:CGPointZero duration:0.2];
    reduction.timingMode = SKActionTimingEaseOut;
    [_thumbNode runAction:reduction];
}

@end
