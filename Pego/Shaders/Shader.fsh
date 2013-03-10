//
//  Shader.fsh
//  Pego
//
//  Created by Lee Irvine on 3/10/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
