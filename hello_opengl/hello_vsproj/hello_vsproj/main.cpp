//
// mai.cpp : Ӧ�ó�����ڵ�
//

#include <iostream>

#include "glew.h"
#include "freeglut.h"
#include "LoadShaders.h"

using namespace std;

#define BUFFER_OFFSET(a) ((void*)(a))

/*
* ���OpenGL��Ϣ
*/
void printInfo()
{
    // ���ظ���ǰOpenGLʵ�ֳ��̵�����  
    const GLubyte* strVendor = glGetString(GL_VENDOR);
    // ����һ����Ⱦ����ʶ����ͨ���Ǹ�Ӳ��ƽ̨
    const GLubyte* strRenderer = glGetString(GL_RENDERER);
    // ���ص�ǰOpenGLʵ�ֵİ汾�� 
    const GLubyte* strGLVersion = glGetString(GL_VERSION);

    cout << "OpenGLʵ�ֳ��̵����֣�" << strVendor << "\n";
    cout << "��Ⱦ����ʶ����" << strRenderer << "\n";
    cout << "OpenGL�汾�ţ�" << strGLVersion << '\n';
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
* ��Ⱦͼ��
*/
void renderScene()
{
    // �����GL_COLOR_BUFFER_BIT��ʾ�����ɫ
    glClear(GL_COLOR_BUFFER_BIT);
    // ������ɫ�����������ֱ�ΪRGB
    glColor3f(0.0f, 1.0f, 1.0f);
    // ���ƾ���
    glRectf(-0.5f, -0.5f, 0.5f, 0.5f);
    // ��֤ǰ���OpenGL��������ִ�У��������������ڻ������еȴ���
    glFlush();
}

int main(int argc, char* argv[])
{
    

    // ��GLUT���г�ʼ�����������������������GLUTʹ��֮ǰ����һ��
    // ���������в������Ƴ�����glut�Ĳ���
    glutInit(&argc, (char**)argv);

    // ������ʾ��ʽ������GLUT_RGB��ʾʹ��RGB��ɫ��GLUT_SINGLE��ʾʹ�õ�����
    glutInitDisplayMode(GLUT_RGBA);
    // ���ô��ڴ�С
    glutInitWindowSize(512, 512);
    // ���ô�������Ļ�е�λ��
    glutInitWindowPosition(300, 300);

    //glutInitContextVersion(4, 3);
    glutInitContextProfile(GLUT_CORE_PROFILE);


    // ����ǰ�����õ���Ϣ��������
    glutCreateWindow("Hello OpenGL");

    // �����ڴ�������֮�����ʹ��OpenGL����
    // ���������ڰ����˴���OpenGL�������̣�
    printInfo();
    

    if (glewInit()) {
        cerr << "Unable to init GLEW ... exiting" << endl;
        exit(EXIT_FAILURE);
    }

    //init();

    // �����л�ͼʱ�����ݵĺ����ᱻ����
    glutDisplayFunc(renderScene);

    // ����һ����Ϣѭ�����ȴ����ڹرպ�Ż᷵��
    glutMainLoop();

    return 0;
}