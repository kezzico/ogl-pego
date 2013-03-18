//
//  KezziEngine.h
//  Kezzi-Engine
//
//  Created by Lee Irvine on 12/31/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#define rads(theta) (M_PI * theta / 180.f)
#define degs(x) (x * 180.f / M_PI)
#define _v(x,y,z) ((vec3){x,y,z})
#define _v2(x,y) ((vec2){x,y})
#define _c(r,g,b,a) ((rgba){r,g,b,a})
#define _r(tl, br) ((rect){tl, br});

#import "Vec3.h"
#import "Rect.h"
#import "KZEvent.h"
#import "KZAnimation.h"
#import "KZTexture.h"
#import "KZShader.h"
#import "KZCamera.h"
#import "KZMesh.h"
#import "KZText.h"
#import "KZSprite.h"
#import "KZTriangle.h"
#import "KZEntity.h"
#import "KZView.h"
#import "KZStage.h"
#import "KZScene.h"


