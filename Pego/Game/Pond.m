//
//  Pond.m
//  Pego
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
#import "Water.h"

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
    
    vec3 origin = centerOfTriangle(_t(a, b, c));
    
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
  self.water = [Water spawn];
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

- (Ice *) findIceUnderPeggy {
  float closest = INFINITY;
  Ice *underIce = nil;
  
  for(Ice *ice in self.ices) {
    if([ice isTouching: self.peggy] == NO) continue;
    
    // calculate distance from peggy's origin to each line.
    line sides[3]; [ice sides: sides];
    for(NSInteger i=0;i<3;i++) {
      float distance = distanceToLine(sides[i], self.peggy.origin);
      // the closest ice will be the ice under peggy.
      if(distance < closest) {
        closest = distance;
        underIce = ice;
      }
    }
  }

  return underIce;
}

@end
