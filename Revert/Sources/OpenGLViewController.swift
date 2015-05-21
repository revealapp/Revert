//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import GLKit

final class OpenGLViewController: RevertGLKViewController {
  private var glkView: GLKView {
    return self.view as! GLKView
  }
  
  private var vertexBuffer: GLuint = 0
  private var indexBuffer: GLuint = 0
  private var vertexArray: GLuint = 0
  private let effect = GLKBaseEffect()
  private var rotation: Float = 0
  private var computedModelViewMatrix: GLKMatrix4 {
    var matrix = GLKMatrix4MakeTranslation(0, 0, -6)
    matrix = GLKMatrix4Rotate(matrix, GLKMathDegreesToRadians(25), 1, 0, 0)
    return GLKMatrix4Rotate(matrix, GLKMathDegreesToRadians(self.rotation), 0, 1, 0)
  }
  
  private func loadGL() {
    let options: [NSObject: AnyObject] = [GLKTextureLoaderOriginBottomLeft: false]
    var error: NSError?
    
    if let image = UIImage(named: "reveal_pretty_flipped.jpg") {
      let textureInfo = GLKTextureLoader.textureWithCGImage(image.CGImage, options: options, error: &error)
      assert(error == nil, "Unable to load texture")
      
      self.effect.texture2d0.name = textureInfo.name
      self.effect.texture2d0.enabled = GLboolean(GL_TRUE)
    } else {
      fatalError("Invalid texture image for OpenGLVC")
    }
    
    glEnable(GLenum(GL_CULL_FACE))
    
    glGenVertexArraysOES(1, &self.vertexArray)
    glBindVertexArrayOES(self.vertexArray)
    
    // Generate and bind vertex buffer
    glGenBuffers(1, &self.vertexBuffer)
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer)
    glBufferData(GLenum(GL_ARRAY_BUFFER), GLsizeiptr(sizeofValue(Vertices)), &Vertices, GLenum(GL_STATIC_DRAW))
    
    // Generate and bind index buffer
    glGenBuffers(1, &self.indexBuffer)
    glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), self.indexBuffer)
    glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), GLsizeiptr(sizeofValue(Indices)), &Indices, GLenum(GL_STATIC_DRAW))

    
    let positionUnsafePointer = UnsafePointer<Void>(bitPattern: 0)
    glEnableVertexAttribArray(GLuint(GLKVertexAttrib.Position.rawValue))
    glVertexAttribPointer(GLuint(GLKVertexAttrib.Position.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(sizeof(Vertex)), positionUnsafePointer)
    
    let coordUnsafePointer = UnsafePointer<Void>(bitPattern: 3 * sizeof(Float))
    glEnableVertexAttribArray(GLuint(GLKVertexAttrib.TexCoord0.rawValue))
    glVertexAttribPointer(GLuint(GLKVertexAttrib.TexCoord0.rawValue), 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(sizeof(Vertex)), coordUnsafePointer)
    
    glBindVertexArrayOES(0)
  }
  
  private func unloadGL() {
    let previousContext = EAGLContext.currentContext()
    
    self.setCurrentContext()
    
    glDeleteBuffers(1, &self.vertexBuffer)
    glDeleteBuffers(1, &self.indexBuffer)
    glDeleteVertexArraysOES(1, &self.vertexArray)

    EAGLContext.setCurrentContext(previousContext != self.glkView.context ? previousContext : nil)
  }
  
  private func setCurrentContext() {
    let isContextSet = EAGLContext.setCurrentContext(self.glkView.context)
    assert(isContextSet, "Failed to set current context")
  }
  
  deinit {
    self.unloadGL()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.glkView.context = EAGLContext(API: .OpenGLES2)
    assert(self.glkView.context != nil, "Failed to initialise context .OpenGLES2")

    self.setCurrentContext()
    
    self.glkView.delegate = self
    
    self.loadGL()
  }
  
  func update() {
    let aspect = Float(self.view.bounds.width / self.view.bounds.height)
    self.effect.transform.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65), aspect, 4, 10)
    
    self.rotation += 90 * Float(self.timeSinceLastUpdate)
    self.effect.transform.modelviewMatrix = self.computedModelViewMatrix
  }
  
  override func viewWillLayoutSubviews() {
    // Make CAEAGLLayer a square to ease the rotation process
    if self.view.layer.bounds.size.width > self.view.layer.bounds.size.height {
      self.view.layer.bounds.size.height = self.view.layer.bounds.size.width
    } else {
      self.view.layer.bounds.size.width = self.view.layer.bounds.size.height
    }

    super.viewWillLayoutSubviews()
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    self.paused = !self.paused
  }
}

extension OpenGLViewController: GLKViewDelegate {
  override func glkView(view: GLKView!, drawInRect rect: CGRect) {
    self.setCurrentContext()

    glClearColor(0.156862745, 0.156862745, 0.156862745, 1)
    glClear(GLenum(GL_COLOR_BUFFER_BIT))
    
    self.effect.prepareToDraw()
    
    glBindVertexArrayOES(self.vertexArray)
    glDrawElements(GLenum(GL_TRIANGLES), GLsizei(sizeofValue(Indices) / sizeofValue(Indices.0)), GLenum(GL_UNSIGNED_BYTE), nil)
  }
}
