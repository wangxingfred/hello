//
// mai.cpp : 应用程序入口点
//

#include <iostream>

#include "glew.h"
#include "freeglut.h"
#include "LoadShaders.h"

using namespace std;

#define BUFFER_OFFSET(a) ((void*)(a))

/*
* 输出OpenGL信息
*/
void printInfo()
{
    // 返回负责当前OpenGL实现厂商的名字  
    const GLubyte* strVendor = glGetString(GL_VENDOR);
    // 返回一个渲染器标识符，通常是个硬件平台
    const GLubyte* strRenderer = glGetString(GL_RENDERER);
    // 返回当前OpenGL实现的版本号 
    const GLubyte* strGLVersion = glGetString(GL_VERSION);

    cout << "OpenGL实现厂商的名字：" << strVendor << "\n";
    cout << "渲染器标识符：" << strRenderer << "\n";
    cout << "OpenGL版本号：" << strGLVersion << '\n';
}


enum VAO_IDs { Triangles, NumVAOs };
enum Buffer_IDs { ArrayBuffer, NumBuffers };
enum Attrib_IDs { vPosition = 0 };

GLuint  VAOs[NumVAOs];
GLuint  Buffers[NumBuffers];

const GLuint  NumVertices = 6;

/*
void init(void)
{
    glGenVertexArrays(NumVAOs, VAOs);
    glBindVertexArray(VAOs[Triangles]);

    GLfloat  vertices[NumVertices][2] = {
        { -0.90f, -0.90f },{ 0.85f, -0.90f },{ -0.90f,  0.85f },  // Triangle 1
    { 0.90f, -0.85f },{ 0.90f,  0.90f },{ -0.85f,  0.90f }   // Triangle 2
    };

    glCreateBuffers(NumBuffers, Buffers);
    glBindBuffer(GL_ARRAY_BUFFER, Buffers[ArrayBuffer]);
    glBufferStorage(GL_ARRAY_BUFFER, sizeof(vertices), vertices, 0);

    ShaderInfo  shaders[] =
    {
        { GL_VERTEX_SHADER, "media/shaders/triangles/triangles.vert" },
    { GL_FRAGMENT_SHADER, "media/shaders/triangles/triangles.frag" },
    { GL_NONE, NULL }
    };

    GLuint program = LoadShaders(shaders);
    glUseProgram(program);

    glVertexAttribPointer(vPosition, 2, GL_FLOAT,
        GL_FALSE, 0, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(vPosition);
}
*/

/*
* 渲染图形
*/
void renderScene()
{
    // 清除，GL_COLOR_BUFFER_BIT表示清除颜色
    glClear(GL_COLOR_BUFFER_BIT);
    // 设置颜色，三个参数分别为RGB
    glColor3f(0.0f, 1.0f, 1.0f);
    // 绘制矩形
    glRectf(-0.5f, -0.5f, 0.5f, 0.5f);
    // 保证前面的OpenGL命令立即执行（而不是让它们在缓冲区中等待）
    glFlush();
}

int main(int argc, char* argv[])
{
    

    // 对GLUT进行初始化，这个函数必须在其它的GLUT使用之前调用一次
    // 处理命令行参数，移除控制glut的部分
    glutInit(&argc, (char**)argv);

    // 设置显示方式，其中GLUT_RGB表示使用RGB颜色，GLUT_SINGLE表示使用单缓冲
    glutInitDisplayMode(GLUT_RGBA);
    // 设置窗口大小
    glutInitWindowSize(512, 512);
    // 设置窗口在屏幕中的位置
    glutInitWindowPosition(300, 300);

    //glutInitContextVersion(4, 3);
    glutInitContextProfile(GLUT_CORE_PROFILE);


    // 根据前面设置的信息创建窗口
    glutCreateWindow("Hello OpenGL");

    // 必须在创建窗口之后才能使用OpenGL函数
    // （创建窗口包含了创建OpenGL环境过程）
    printInfo();
    

    if (glewInit()) {
        cerr << "Unable to init GLEW ... exiting" << endl;
        exit(EXIT_FAILURE);
    }

    //init();

    // 当进行画图时，传递的函数会被调用
    glutDisplayFunc(renderScene);

    // 进行一个消息循环，等待窗口关闭后才会返回
    glutMainLoop();

    return 0;
}