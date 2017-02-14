//
//  HSKJoystick.h
//  CrazyTank
//
//  Created by scott on 2017/2/7.
//  Copyright © 2017年 zhouqiao. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class HSKJoystick;

@protocol HSKJoystickDelegate <NSObject>
@optional
- (void)joystick:(HSKJoystick *)joystick touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)joystick:(HSKJoystick *)joystick touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)joystick:(HSKJoystick *)joystick touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)joystick:(HSKJoystick *)joystick touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface HSKJoystick : SKSpriteNode

+ (instancetype)joystickWithBackdropImageNamed:(NSString *)backdropName
                               thumbImageNamed:(NSString *)thumbnName
                                     thumbSize:(CGSize)thumbSize
                                          size:(CGSize)size;

- (instancetype)initWithBackdropImageNamed:(NSString *)backdropName
                           thumbImageNamed:(NSString *)thumbnName
                                 thumbSize:(CGSize)thumbSize
                                      size:(CGSize)size;

@property (nonatomic, strong, readonly) NSString *thumbnName;
@property (nonatomic, strong, readonly) NSString *backdropName;
@property (nonatomic, assign, readonly) CGSize thumbSize;
@property (nonatomic, assign, readonly) CGFloat rotateAngle;
@property (nonatomic, assign, readonly) CGPoint velocity;
@property (nonatomic, copy) void (^trackingHandler)();
@property (nonatomic, weak) id<HSKJoystickDelegate> delegate;

@end
