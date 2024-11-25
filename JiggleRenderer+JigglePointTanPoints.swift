//
//  JiggleRenderer+JigglePointTanPoints.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 11/25/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    @MainActor
    @inline(__always)
    func prepareJigglePointTanPoints(jiggle: Jiggle,
                                     projectionMatrix: matrix_float4x4,
                                     modelViewMatrix: matrix_float4x4,
                                     pointScale: Float,
                                     isPrecisePass: Bool,
                                     isBloomEnabled: Bool,
                                     jiggleColorPack: JiggleRenderColorPack,
                                     selectedJigglePointTanType: TanType,
                                     jigglePointTanHandlePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                                     jigglePointTanHandlePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored,
                                     jigglePointTanHandlePointSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                                     jigglePointTanHandlePointSelectedFillBuffer: IndexedSpriteBuffer2DColored) {
        
        jigglePointTanHandlePointUnselectedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandlePointUnselectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandlePointUnselectedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointTanHandlePointUnselectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointTanHandlePointUnselectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointTanHandlePointUnselectedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandlePointUnselectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        jigglePointTanHandlePointSelectedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandlePointSelectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandlePointSelectedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointTanHandlePointSelectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointTanHandlePointSelectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointTanHandlePointSelectedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandlePointSelectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
            
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
            
            jigglePointTanHandlePointSelectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            jigglePointTanHandlePointSelectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            jigglePointTanHandlePointSelectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            jigglePointTanHandlePointSelectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            jigglePointTanHandlePointSelectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
        }
        
        for jiggleControlPointIndex in 0..<jiggle.jiggleControlPointCount {
            
            let jiggleControlPoint = jiggle.jiggleControlPoints[jiggleControlPointIndex]
            
            
            let renderCenterPointIn = Math.Point(x: jiggleControlPoint.renderTanInX,
                                                 y: jiggleControlPoint.renderTanInY)
            let renderCenterPointOut = Math.Point(x: jiggleControlPoint.renderTanOutX,
                                                  y: jiggleControlPoint.renderTanOutY)
            
            if (jiggleControlPoint.renderSelected == true) && (selectedJigglePointTanType == .in) {
                
                jigglePointTanHandlePointSelectedStrokeBuffer.add(translation: renderCenterPointIn,
                                                                  scale: pointScale,
                                                                  rotation: 0.0)
                jigglePointTanHandlePointSelectedFillBuffer.add(translation: renderCenterPointIn,
                                                                scale: pointScale,
                                                                rotation: 0.0,
                                                                red: jiggleColorPack.tanPointFillActiveRed,
                                                                green: jiggleColorPack.tanPointFillActiveGreen,
                                                                blue: jiggleColorPack.tanPointFillActiveBlue,
                                                                alpha: 1.0)
                
                if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                    jigglePointTanHandlePointSelectedStrokeBufferBloom.add(translation: renderCenterPointIn,
                                                                           scale: pointScale,
                                                                           rotation: 0.0)
                }
                
            } else {
                
                jigglePointTanHandlePointUnselectedStrokeBuffer.add(translation: renderCenterPointIn,
                                                                    scale: pointScale,
                                                                    rotation: 0.0)
                if (jiggleControlPoint.isManualTanHandleEnabled == true) || (jiggleControlPoint.renderSelected == true) {
                    jigglePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointIn,
                                                                      scale: pointScale,
                                                                      rotation: 0.0,
                                                                      red: jiggleColorPack.tanPointFillModifiedRed,
                                                                      green: jiggleColorPack.tanPointFillModifiedGreen,
                                                                      blue: jiggleColorPack.tanPointFillModifiedBlue,
                                                                      alpha: 1.0)
                } else {
                    jigglePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointIn,
                                                                      scale: pointScale,
                                                                      rotation: 0.0,
                                                                      red: jiggleColorPack.tanPointFillUnmodifiedRed,
                                                                      green: jiggleColorPack.tanPointFillUnmodifiedGreen,
                                                                      blue: jiggleColorPack.tanPointFillUnmodifiedBlue,
                                                                      alpha: 1.0)
                }
                
                if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                    jigglePointTanHandlePointUnselectedStrokeBufferBloom.add(translation: renderCenterPointIn,
                                                                             scale: pointScale,
                                                                             rotation: 0.0)
                }
            }
            
            if (jiggleControlPoint.renderSelected == true) && (selectedJigglePointTanType == .out) {
                
                jigglePointTanHandlePointSelectedStrokeBuffer.add(translation: renderCenterPointOut,
                                                                  scale: pointScale,
                                                                  rotation: 0.0)
                jigglePointTanHandlePointSelectedFillBuffer.add(translation: renderCenterPointOut,
                                                                scale: pointScale,
                                                                rotation: 0.0,
                                                                red: jiggleColorPack.tanPointFillActiveRed,
                                                                green: jiggleColorPack.tanPointFillActiveGreen,
                                                                blue: jiggleColorPack.tanPointFillActiveBlue,
                                                                alpha: 1.0)
                
                if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                    jigglePointTanHandlePointSelectedStrokeBufferBloom.add(translation: renderCenterPointOut,
                                                                           scale: pointScale,
                                                                           rotation: 0.0)
                }
                
            } else {
                
                jigglePointTanHandlePointUnselectedStrokeBuffer.add(translation: renderCenterPointOut,
                                                                    scale: pointScale,
                                                                    rotation: 0.0)
                if (jiggleControlPoint.isManualTanHandleEnabled == true) || (jiggleControlPoint.renderSelected == true) {
                    jigglePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointOut,
                                                                      scale: pointScale,
                                                                      rotation: 0.0,
                                                                      red: jiggleColorPack.tanPointFillModifiedRed,
                                                                      green: jiggleColorPack.tanPointFillModifiedGreen,
                                                                      blue: jiggleColorPack.tanPointFillModifiedBlue,
                                                                      alpha: 1.0)
                } else {
                    jigglePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointOut,
                                                                      scale: pointScale,
                                                                      rotation: 0.0,
                                                                      red: jiggleColorPack.tanPointFillUnmodifiedRed,
                                                                      green: jiggleColorPack.tanPointFillUnmodifiedGreen,
                                                                      blue: jiggleColorPack.tanPointFillUnmodifiedBlue,
                                                                      alpha: 1.0)
                }
                
                if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                    jigglePointTanHandlePointUnselectedStrokeBufferBloom.add(translation: renderCenterPointOut,
                                                                             scale: pointScale,
                                                                             rotation: 0.0)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointUnselectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                                         isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandlePointUnselectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointTanHandlePointUnselectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                                   pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointUnselectedFill(renderEncoder: MTLRenderCommandEncoder,
                                                       isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandlePointUnselectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointTanHandlePointUnselectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointSelectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                                       isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandlePointSelectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointTanHandlePointSelectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointSelectedFill(renderEncoder: MTLRenderCommandEncoder,
                                                     isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandlePointSelectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointTanHandlePointSelectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointUnselectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleControlPointTanHandlesBloom {
                    jigglePointTanHandlePointUnselectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointSelectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleControlPointTanHandlesBloom {
                    if !jiggle.isFrozen {
                        jigglePointTanHandlePointSelectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
}
