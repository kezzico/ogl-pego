//
//  Pond.m
//  Penguin Cross
//
//  Created by Lee Irvine on 12/29/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Pond.h"
#import "NSArray-Extensions.h"
#import "NSDictionary-Extensions.h"
#import "Ice.h"
#import "Peggy.h"
#import "Egg.h"

typedef struct {
  vec3 a,b,c,origin;
} IceTriangle;

@implementation Pond

+ (Pond *) pondWithName:(NSString *) name {
  NSDictionary *json = [NSDictionary jsonFromResource:name ofType:@"pond"];
  Pond *pond = [[Pond alloc] init];
  pond.name = [json valueForKey:@"name"];
  pond.peggyInitialPosition = [pond vec3FromJson: [json valueForKey:@"start"]];

  pond.iceInitialPositions = [[json valueForKey:@"ice"] mapObjects:^id(NSArray *obj) {
    IceTriangle triangle;
    vec3 a = [pond vec3FromJson: obj[0]],
         b = [pond vec3FromJson: obj[1]],
         c = [pond vec3FromJson: obj[2]];
    
    vec3 origin = centerOfTriangle(a, b, c);
    
    triangle.a = sub(a, origin);
    triangle.b = sub(b, origin);
    triangle.c = sub(c, origin);
    triangle.origin = origin;
    
    return [NSValue valueWithBytes:&triangle objCType:@encode(IceTriangle)];
  }];

  pond.eggInitialPositions = [[json valueForKey:@"eggs"] mapObjects:^id(NSDictionary *obj) {
    vec3 p = [pond vec3FromJson: obj];
    return [NSValue valueWithBytes:&p objCType:@encode(vec3)];
  }];
  
  return pond;
}

- (vec3) vec3FromJson: (NSDictionary *) json {
  vec3 output = (vec3){0.f, 0.f, 0.f};
  output.x = [[json valueForKey:@"x"] floatValue];
  output.y = [[json valueForKey:@"y"] floatValue];
  return output;
}

- (vec3) vec3FromValue: (NSValue *) value {
  vec3 output;
  [value getValue:&output];
  return output;
}

- (IceTriangle) iceTriangleFromValue: (NSValue *) value {
  IceTriangle triangle;
  [value getValue:&triangle];
  return triangle;
}

- (void) reset {

  self.peggy = [Peggy spawn: self.peggyInitialPosition];
  self.ices = [self.iceInitialPositions mapObjects:^id(NSValue *value) {
    IceTriangle t = [self iceTriangleFromValue: value];
    KZTriangle *triangle = [KZTriangle triangle:t.a :t.b :t.c];
    Ice *ice = [Ice spawn:t.origin withTriangle: triangle];
    return ice;
  }];
  self.eggs = [self.eggInitialPositions mapObjects:^id(NSValue *value) {
    return [Egg spawn: [self vec3FromValue:value]];
  }];
}

- (KZEntity *) findIceUnderPeggy {
//  Entity *underIce = nil;
//  float closest = INFINITY;
//  
//  for(Entity *ice in self.ices) {
//    ice.tint = _c(1, 1, 1, 1);
//    float buffer = ice.halfwidth + self.peggy.halfwidth;
//    float xdistance = fabsf(ice.origin.x - self.peggy.origin.x);
//    float ydistance = fabsf(ice.origin.y - self.peggy.origin.y);
//    float sum = xdistance + ydistance;
//    
//    if(buffer > xdistance && buffer > ydistance && closest > sum) {
//      closest = sum;
//      underIce = ice;
//    }
//  }
//
//  return underIce;
}

@end
