#pragma once


#include "glew.h"

typedef struct {
    GLenum       type;
    const char*  filename;
    GLuint       shader;
} ShaderInfo;

GLuint LoadShaders(ShaderInfo*);