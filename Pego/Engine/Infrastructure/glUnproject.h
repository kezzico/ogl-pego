//
//  glUnproject.h
//  PenguinCross
//
//  Created by Lee Irvine on 8/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

GLint gluUnProject(GLfloat winx, GLfloat winy, GLfloat winz,
                   const GLfloat modelMatrix[16],
                   const GLfloat projMatrix[16],
                   const GLint viewport[4],
                   GLfloat *objx, GLfloat *objy, GLfloat *objz);
