//
//  View.h
//  PenguinCross
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KZTexture;
@interface KZView : NSObject {
  BOOL _isHighlit;
}
@property (nonatomic, assign) SEL touchAction;
@property (nonatomic, retain) id touchTarget;
@property (nonatomic, assign) float x, y;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) rgba tint;
@property (nonatomic, retain) KZTexture *defaultTexture;
@property (nonatomic, retain) KZTexture *highlightTexture;
@property (nonatomic, retain) NSMutableArray *subviews;
@property (nonatomic, assign) KZView *superview;
+ (KZView *) viewWithPosition:(float) x :(float) y size:(float)width : (float)height;
- (KZTexture *) texture;
- (void) sendTouchAction:(SEL) action to:(id) target;
- (void) addSubview:(KZView *) subview;
- (void) removeFromSuperview;
- (CGRect) rect;
- (void) didTouchDown;
- (void) didTouchUp;
- (void) didTouchUpInside;
- (void) verts: (GLfloat *) buffer;
@end
