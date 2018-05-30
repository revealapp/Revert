//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import GLKit

final class RevealOpenGLCube {
  let context: EAGLContext

  init() {
    guard let context = EAGLContext(api: .openGLES2) else {
      fatalError("Failed to initialise context `.OpenGLES2`")
    }

    self.context = context
  }

  deinit {
    self.unloadGL()
  }

  func draw() {
    self.setCurrentContext()

    #if os(tvOS)
      glClearColor(0.0, 0.0, 0.0, 0.0)
    #else
      glClearColor(0.156862745, 0.156862745, 0.156862745, 1)
    #endif

    glClear(GLenum(GL_COLOR_BUFFER_BIT))

    self.effect.prepareToDraw()

    glBindVertexArrayOES(self.vertexArray)
    glDrawElements(GLenum(GL_TRIANGLES), GLsizei(MemoryLayout.size(ofValue: Indices) / MemoryLayout.size(ofValue: Indices.0)), GLenum(GL_UNSIGNED_BYTE), nil)
  }

  func load() {
    self.setCurrentContext()
    self.loadGL()
  }

  func updateWithAspectRatio(_ aspectRatio: Float, rotation: Float) {
    self.effect.transform.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65), aspectRatio, 4, 10)
    self.rotation += rotation
    self.effect.transform.modelviewMatrix = self.computedModelViewMatrix
  }

  // MARK: Private

  fileprivate var vertexBuffer: GLuint = 0
  fileprivate var indexBuffer: GLuint = 0
  fileprivate var vertexArray: GLuint = 0
  fileprivate let effect = GLKBaseEffect()
  private var rotation: Float = 0
  private var computedModelViewMatrix: GLKMatrix4 {
    var matrix = GLKMatrix4MakeTranslation(0, 0, -6)
    matrix = GLKMatrix4Rotate(matrix, GLKMathDegreesToRadians(25), 1, 0, 0)
    return GLKMatrix4Rotate(matrix, GLKMathDegreesToRadians(self.rotation), 0, 1, 0)
  }
}

private extension RevealOpenGLCube {
  func setCurrentContext() {
    let isContextSet = EAGLContext.setCurrent(self.context)
    assert(isContextSet, "Failed to set current context")
  }

  func loadGL() {
    self.loadTexture()
    self.generateBindVertex()
    self.loadCube()
  }

  func unloadGL() {
    let previousContext = EAGLContext.current()

    self.setCurrentContext()

    glDeleteBuffers(1, &self.vertexBuffer)
    glDeleteBuffers(1, &self.indexBuffer)
    glDeleteVertexArraysOES(1, &self.vertexArray)

    EAGLContext.setCurrent(previousContext != self.context ? previousContext : nil)
  }

  func generateBindVertex() {
    glEnable(GLenum(GL_CULL_FACE))

    glGenVertexArraysOES(1, &self.vertexArray)
    glBindVertexArrayOES(self.vertexArray)

    // Generate and bind vertex buffer
    glGenBuffers(1, &self.vertexBuffer)
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer)
    glBufferData(GLenum(GL_ARRAY_BUFFER), GLsizeiptr(MemoryLayout.size(ofValue: Vertices)), &Vertices, GLenum(GL_STATIC_DRAW))

    // Generate and bind index buffer
    glGenBuffers(1, &self.indexBuffer)
    glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), self.indexBuffer)
    glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), GLsizeiptr(MemoryLayout.size(ofValue: Indices)), &Indices, GLenum(GL_STATIC_DRAW))
  }

  func loadCube() {
    let positionUnsafePointer = UnsafeRawPointer(bitPattern: 0)
    glEnableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue))
    glVertexAttribPointer(GLuint(GLKVertexAttrib.position.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), positionUnsafePointer)

    let coordUnsafePointer = UnsafeRawPointer(bitPattern: 3 * MemoryLayout<Float>.size)
    glEnableVertexAttribArray(GLuint(GLKVertexAttrib.texCoord0.rawValue))
    glVertexAttribPointer(GLuint(GLKVertexAttrib.texCoord0.rawValue), 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), coordUnsafePointer)

    glBindVertexArrayOES(0)
  }

  func loadTexture() {
    let options: [String: NSNumber] = [GLKTextureLoaderOriginBottomLeft: false]

    guard let image = UIImage(named: "reveal_pretty_flipped.jpg") else {
      fatalError("Invalid texture image for OpenGLVC")
    }

    let textureInfo: GLKTextureInfo
    do {
      textureInfo = try GLKTextureLoader.texture(with: image.cgImage!, options: options)
    } catch let error {
      fatalError("Unable to load texture \(error)")
    }

    self.effect.texture2d0.name = textureInfo.name
    self.effect.texture2d0.enabled = GLboolean(GL_TRUE)
  }
}
