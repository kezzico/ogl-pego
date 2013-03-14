//
//  Text.m
//  Cheapo
//
//  Created by Lee Irvine on 2/28/13.
//  Copyright (c) 2013 fareportal. All rights reserved.
//

#import "KZText.h"
#import "NSDictionary-Extensions.h"
#import "NSString-Extensions.h"

@interface KZText () {
  GLfloat *_verts, *_tverts, _numVerts;
}
@end

// TODO: render text to frame buffer to create texture.
@implementation KZText
- (void) dealloc {
  free(_verts);
  free(_tverts);
}

- (NSUInteger) numVerts {
  return _numVerts;
}

- (void) tverts:(GLfloat *) buffer {
  memcpy(buffer, _tverts, self.numVerts * sizeof(vec2));
}
- (void) verts: (GLfloat *) buffer {
  memcpy(buffer, _verts, self.numVerts *sizeof(vec3));
}
- (void) normals: (GLfloat *) buffer { }

+ (KZText *) textWithString:(NSString *) string scale:(GLfloat) scale {
  KZText *text = [[KZText alloc] init];
  text.texture = [KZTexture textureWithName:@"charmap"];
  text.shader = [KZShader defaultShader];
  text.string = string;
  text.scale = scale;
  text.tint = _c(1, 1, 1, 1);
  
  [text calculateGeometry];
  return text;
}

- (void) calculateGeometry {
  const char *chars = [self.string UTF8String];
  const char *c = chars;
  
  NSInteger numsquares = [[self.string search:@"\n| " replace:@""] length];
  GLfloat letterHeight = 50.f * _scale, letterWidth = 50.f * _scale;
  GLfloat padding = 4.f * _scale;
  GLfloat spacesize = 25.f * _scale;
  vec3 v = _v(0, 0, 0);
  
  _numVerts = numsquares * 6;
  _verts = (GLfloat *)malloc(sizeof(vec3) * numsquares * 6);
  _tverts = (GLfloat *)malloc(sizeof(vec2) * numsquares * 6);

  vec3 *verts = (vec3 *)(_verts);
  vec2 *tverts = (vec2 *)(_tverts);
  
  do {
    if(*c == ' ') {
      v.x += spacesize;
      continue;
    }
    
    if(*c == '\n') {
      v.x = 0.f;
      v.y += letterHeight;
      continue;
    }
    
    vec2 cp = [self characterPosition: *c];
    float kernWidth = letterWidth * [self characterKern: *c];
    float lefttrim = (letterWidth - kernWidth) * .5f;
    
    verts[0] = _v(0,1,0); verts[1] = _v(1,1,0); verts[2] = _v(0,0,0);
    verts[3] = _v(1,1,0); verts[4] = _v(1,0,0); verts[5] = _v(0,0,0);
    tverts[0] = _v2(0,0); tverts[1] = _v2(1,0); tverts[2] = _v2(0,1);
    tverts[3] = _v2(1,0); tverts[4] = _v2(1,1); tverts[5] = _v2(0,1);
    
    for(NSInteger j=0;j<6;j++) {
      tverts[j].x = cp.x + tverts[j].x / 12.f;
      tverts[j].y = cp.y + tverts[j].y / 6.f;
      
      verts[j].x = v.x + verts[j].x * letterWidth - lefttrim;
      verts[j].y = v.y + verts[j].y * letterHeight;
    }
    
    v.x += kernWidth + padding;
    verts += 6;
    tverts += 6;
    
  } while(*(++c));
}

- (vec2) characterPosition:(char) c {
  NSInteger rowlength = 12;
  NSInteger index = [self characterIndex:c];
  vec2 output = _v2(index % rowlength, 5 - index / rowlength);
  output.x /= 12.f;
  output.y /= 6.f;
  return output;
}

- (NSInteger) characterIndex:(char) c {
  const char *charmap = "0123456789()ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz$-?&!,.:";
  for(NSInteger i=0;i<strlen(charmap);i++) {
    if(charmap[i] == c) return i;
  }
  
  return 0;
}

- (float) characterKern:(char) c {
  static NSDictionary *kerns = nil;
  if(kerns == nil) {
    kerns = [NSDictionary jsonFromResource:@"kerning" ofType:@"json"];
  }
  
  NSString *kern = [kerns valueForKey: [NSString stringWithFormat:@"%c", c]];
  return kern == nil ? 1.f : [kern floatValue];
}

- (KZAnimation *) animation {
  return nil;
}

@end
