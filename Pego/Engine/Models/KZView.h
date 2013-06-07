//
//  View.h
//  PenguinCross
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KZTexture;
@interface KZView : NSObject {
  BOOL _isHighlit;
}
@property (nonatomic, assign) SEL touchAction;
@property (nonatomic, strong) id touchTarget;
@property (nonatomic, assign) float x, y;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) rgba tint;
@property (nonatomic, strong) KZTexture *defaultTexture;
@property (nonatomic, strong) KZTexture *highlightTexture;
@property (nonatomic, strong) NSMutableArray *subviews;
@property (nonatomic, weak) KZView *superview;
@property (nonatomic, strong) NSArray *assets;

+ (KZView *) viewWithPosition:(float) x :(float) y size:(float)width : (float)height;
+ (KZView *) fullscreen;
- (KZTexture *) texture;

- (void) sendTouchAction:(SEL) action to:(id) target;
- (void) addSubview:(KZView *) subview;
- (void) removeFromSuperview;
- (CGRect) rect;
- (void) didTouchDown;
- (void) didTouchUp;
- (void) didTouchUpInside;
- (void) verts: (GLfloat *) buffer;
- (void) tverts: (GLfloat *) buffer;
- (NSInteger) numVerts;

@end
