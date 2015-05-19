//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

/*
File: GLGravityView.h
File: GLGravityView.m
Abstract: This class wraps the CAEAGLLayer from CoreAnimation into a convenient
UIView subclass. The view content is basically an EAGL surface you render your
OpenGL scene into.  Note that setting the view non-opaque will only work if the
EAGL surface has an alpha channel.
Version: 2.2

Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
Inc. ("Apple") in consideration of your agreement to the following
terms, and your use, installation, modification or redistribution of
this Apple software constitutes acceptance of these terms.  If you do
not agree with these terms, please do not use, install, modify or
redistribute this Apple software.

In consideration of your agreement to abide by the following terms, and
subject to these terms, Apple grants you a personal, non-exclusive
license, under Apple's copyrights in this original Apple software (the
"Apple Software"), to use, reproduce, modify and redistribute the Apple
Software, with or without modifications, in source and/or binary forms;
provided that if you redistribute the Apple Software in its entirety and
without modifications, you must retain this notice and the following
text and disclaimers in all such redistributions of the Apple Software.
Neither the name, trademarks, service marks or logos of Apple Inc. may
be used to endorse or promote products derived from the Apple Software
without specific prior written permission from Apple.  Except as
expressly stated in this notice, no other rights or licenses, express or
implied, are granted by Apple herein, including but not limited to any
patent rights that may be infringed by your derivative works or by other
works in which the Apple Software may be incorporated.

The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

Copyright (C) 2010 Apple Inc. All Rights Reserved.

*/

import UIKit
import GLKit

final class TeaPotView: UIView {
  private let context = EAGLContext(API: .OpenGLES1)
  
  private var backingWidth: GLint = 0
  private var backingHeight: GLint = 0
  
  private var viewRenderbuffer: GLuint = 0
  private var viewFramebuffer: GLuint = 0
  private var depthRenderbuffer: GLuint = 0
  
  private let fieldOfView: GLfloat = 60
  private let zFar: GLfloat  = 1000
  private let zNear: GLfloat = 0.1
  private let scale: GLfloat = 3

  private var eaglLayer: CAEAGLLayer {
    return self.layer as! CAEAGLLayer
  }
  
  private func setupContext() {
    assert(self.context != nil, "Failed to initialise context .OpenGLES1")
    
    let isContextSet = EAGLContext.setCurrentContext(self.context)
    assert(isContextSet, "Failed to set current context.")
  }
  
  private func setupView() {
    let lightAmbient: [GLfloat] = [0.2, 0.2, 0.2, 1]
    let lightDiffuse: [GLfloat] = [1, 0.6, 0, 1]
    let matAmbient: [GLfloat] = [0.6, 0.6, 0.6, 1]
    let matDiffuse: [GLfloat] = [1, 1, 1, 1]
    let matSpecular: [GLfloat] = [1, 1, 1, 1]
    let lightPosition: [GLfloat] = [0, 0, 1, 0]
    let lightShininess: GLfloat = 100
    
    // Configure OpenGL lighting
    glEnable(GLenum(GL_LIGHTING))
    glEnable(GLenum(GL_LIGHT0))
    glMaterialfv(GLenum(GL_FRONT_AND_BACK), GLenum(GL_AMBIENT), matAmbient)
    glMaterialfv(GLenum(GL_FRONT_AND_BACK), GLenum(GL_DIFFUSE), matDiffuse)
    glMaterialfv(GLenum(GL_FRONT_AND_BACK), GLenum(GL_SPECULAR), matSpecular)
    glMaterialf(GLenum(GL_FRONT_AND_BACK), GLenum(GL_SHININESS), lightShininess)
    glLightfv(GLenum(GL_LIGHT0), GLenum(GL_AMBIENT), lightAmbient)
    glLightfv(GLenum(GL_LIGHT0), GLenum(GL_DIFFUSE), lightDiffuse)
    glLightfv(GLenum(GL_LIGHT0), GLenum(GL_POSITION), lightPosition)
    glShadeModel(GLenum(GL_SMOOTH))
    glEnable(GLenum(GL_DEPTH_TEST))
    
    // Configure OpenGL arrays
    glEnableClientState(GLenum(GL_VERTEX_ARRAY))
    glEnableClientState(GLenum(GL_NORMAL_ARRAY))
    glVertexPointer(3, GLenum(GL_FLOAT), 0, teapot_vertices)
    glNormalPointer(GLenum(GL_FLOAT), 0, teapot_normals)
    glEnable(GLenum(GL_NORMALIZE))
    
    // Set the OpenGL projection matrix
    glMatrixMode(GLenum(GL_PROJECTION))
  }
  
  private var lastViewportUpdateSize: CGSize?
  
  private func updateViewport() {
    if lastViewportUpdateSize == self.bounds.size {
      return
    }
    self.lastViewportUpdateSize = self.bounds.size
    
    let size = zNear * GLfloat(tan(Double(self.fieldOfView) / 180 * M_PI_2))
    let sizeByRatio = size / GLfloat(self.bounds.size.width / self.bounds.size.height)
    
    glFrustumf(-size, size, -sizeByRatio, sizeByRatio, self.zNear, self.zFar)
    glViewport(0, 0, GLsizei(self.bounds.size.width), GLsizei(self.bounds.size.height))
    
    // Make the OpenGL modelview matrix the default
    glMatrixMode(GLenum(GL_MODELVIEW))
  }
  
  private func drawView() {
    EAGLContext.setCurrentContext(self.context)

    glBindFramebufferOES(GLenum(GL_FRAMEBUFFER_OES), self.viewFramebuffer)
    
    glClearColor(0.156862745, 0.156862745, 0.156862745, 1)
    glClear(GLenum(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
    
    glLoadIdentity()
    glTranslatef(0, -0.25, -1)
    glScalef(self.scale, self.scale, self.scale)

    for teapot_indices in teapot_indicies {
      glDrawElements(GLenum(GL_TRIANGLE_STRIP), GLsizei(teapot_indices.count), GLenum(GL_UNSIGNED_SHORT), teapot_indices)
    }

    glBindRenderbufferOES(GLenum(GL_RENDERBUFFER_OES), self.viewRenderbuffer)
    self.context.presentRenderbuffer(Int(GL_RENDERBUFFER_OES))
  }

  private func createFrameBuffer() {
    // Generate IDs for a framebuffer object and a color renderbuffer
    glGenFramebuffersOES(1, &self.viewFramebuffer)
    glGenRenderbuffersOES(1, &self.viewRenderbuffer)

    glBindFramebufferOES(GLenum(GL_FRAMEBUFFER_OES), self.viewFramebuffer)
    glBindRenderbufferOES(GLenum(GL_RENDERBUFFER_OES), self.viewRenderbuffer)

    // This call associates the storage for the current render buffer with the EAGLDrawable (our CAEAGLLayer)
    // allowing us to draw into a buffer that will later be rendered to screen wherever the layer is (which corresponds with our view).
    self.context.renderbufferStorage(Int(GL_RENDERBUFFER_OES), fromDrawable: self.layer as! CAEAGLLayer)
    glFramebufferRenderbufferOES(GLenum(GL_FRAMEBUFFER_OES), GLenum(GL_COLOR_ATTACHMENT0_OES), GLenum(GL_RENDERBUFFER_OES), self.viewRenderbuffer)

    glGetRenderbufferParameterivOES(GLenum(GL_RENDERBUFFER_OES), GLenum(GL_RENDERBUFFER_WIDTH_OES), &self.backingWidth)
    glGetRenderbufferParameterivOES(GLenum(GL_RENDERBUFFER_OES), GLenum(GL_RENDERBUFFER_HEIGHT_OES), &self.backingHeight)
    
    // For this sample, we also need a depth buffer, so we'll create and attach one via another renderbuffer.
    glGenRenderbuffersOES(1, &self.depthRenderbuffer)
    glBindRenderbufferOES(GLenum(GL_RENDERBUFFER_OES), self.depthRenderbuffer)
    glRenderbufferStorageOES(GLenum(GL_RENDERBUFFER_OES), GLenum(GL_DEPTH_COMPONENT16_OES), self.backingWidth, self.backingHeight)
    glFramebufferRenderbufferOES(GLenum(GL_FRAMEBUFFER_OES), GLenum(GL_DEPTH_ATTACHMENT_OES), GLenum(GL_RENDERBUFFER_OES), self.depthRenderbuffer)
    
    if glCheckFramebufferStatusOES(GLenum(GL_FRAMEBUFFER_OES)) != GLenum(GL_FRAMEBUFFER_COMPLETE_OES) {
      println("failed to make complete framebuffer object")
    }
  }

  private func destroyFrameBuffer() {
    // Clean up any buffers we have allocated.
    glDeleteFramebuffersOES(1, &self.viewFramebuffer)
    self.viewFramebuffer = 0
    glDeleteRenderbuffersOES(1, &self.viewRenderbuffer)
    self.viewRenderbuffer = 0
    
    if self.depthRenderbuffer != 0 {
      glDeleteRenderbuffersOES(1, &self.depthRenderbuffer)
      self.depthRenderbuffer = 0
    }
  }
  
  deinit {
    if self.context == EAGLContext.currentContext() {
      EAGLContext.setCurrentContext(nil)
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.eaglLayer.opaque = true
    self.eaglLayer.drawableProperties = [
      kEAGLDrawablePropertyRetainedBacking : false,
      kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8
    ]
    
    self.setupContext()
    self.setupView()
  }
  
  override func layoutSubviews() {
    // If our view is resized, we'll be asked to layout subviews.
    // This is the perfect opportunity to also update the framebuffer so that it is
    // the same size as our display area.
    super.layoutSubviews()

    self.updateViewport()
    self.destroyFrameBuffer()
    self.createFrameBuffer()
    self.drawView()
  }
  
  override class func layerClass() -> AnyClass {
    return CAEAGLLayer.self
  }
}
