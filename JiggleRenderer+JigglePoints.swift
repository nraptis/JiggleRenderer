//
//  JiggleRenderer+JigglePoints.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 11/23/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    
    @MainActor
    @inline(__always)
    func prepareJigglePoints(jiggle: Jiggle,
                             pointScale: Float,
                             projectionMatrix: matrix_float4x4,
                             modelViewMatrix: matrix_float4x4,
                             baseAdjustRotation: Float,
                             isPrecisePass: Bool,
                             isBloomEnabled: Bool,
                             jiggleColorPack: JiggleRenderColorPack,
                             jigglePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                             jigglePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored,
                             jigglePointSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                             jigglePointSelectedFillBuffer: IndexedSpriteBuffer2DColored) {
        
        jigglePointUnselectedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointUnselectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointUnselectedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointUnselectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointUnselectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointUnselectedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointUnselectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        jigglePointSelectedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointSelectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointSelectedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointSelectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointSelectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointSelectedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointSelectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        if isBloomEnabled && jiggle.isShowingJigglePointsBloom && !isPrecisePass {
            
            jigglePointUnselectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            jigglePointUnselectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            jigglePointUnselectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            jigglePointUnselectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            jigglePointUnselectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
            
            jigglePointSelectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            jigglePointSelectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            jigglePointSelectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            jigglePointSelectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            jigglePointSelectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
            jigglePointSelectedStrokeBufferBloom.alpha = 1.0
        }
        
        for jiggleControlPointIndex in 0..<jiggle.jiggleControlPointCount {
            let jiggleControlPoint = jiggle.jiggleControlPoints[jiggleControlPointIndex]
            
            let renderCenterPoint = Math.Point(x: jiggleControlPoint.renderX,
                                               y: jiggleControlPoint.renderY)
            
            if jiggleControlPoint.renderSelected {
                jigglePointSelectedStrokeBuffer.add(translation: renderCenterPoint,
                                                    scale: pointScale,
                                                    rotation: baseAdjustRotation)
                jigglePointSelectedFillBuffer.add(translation: renderCenterPoint,
                                                  scale: pointScale,
                                                  rotation: baseAdjustRotation,
                                                  red: jiggleColorPack.fillSelectedRed,
                                                  green: jiggleColorPack.fillSelectedGreen,
                                                  blue: jiggleColorPack.fillSelectedBlue,
                                                  alpha: 1.0)
                
                if isBloomEnabled && jiggle.isShowingJigglePointsBloom && !isPrecisePass {
                    jigglePointSelectedStrokeBufferBloom.add(translation: renderCenterPoint,
                                                             scale: pointScale,
                                                             rotation: 0.0)
                }
            } else {
                
                jigglePointUnselectedStrokeBuffer.add(translation: renderCenterPoint,
                                                      scale: pointScale,
                                                      rotation: 0.0)
                
                if jiggleControlPoint.isManualTanHandleEnabled {
                    jigglePointUnselectedFillBuffer.add(translation: renderCenterPoint,
                                                        scale: pointScale,
                                                        rotation: 0.0,
                                                        red: jiggleColorPack.fillModifiedRed,
                                                        green: jiggleColorPack.fillModifiedGreen,
                                                        blue: jiggleColorPack.fillModifiedBlue,
                                                        alpha: 1.0)
                } else {
                    jigglePointUnselectedFillBuffer.add(translation: renderCenterPoint,
                                                        scale: pointScale,
                                                        rotation: 0.0,
                                                        red: jiggleColorPack.fillUnselectedRed,
                                                        green: jiggleColorPack.fillUnselectedGreen,
                                                        blue: jiggleColorPack.fillUnselectedBlue,
                                                        alpha: 1.0)
                }
                
                if isBloomEnabled && jiggle.isShowingJigglePointsBloom && !isPrecisePass {
                    jigglePointUnselectedStrokeBufferBloom.add(translation: renderCenterPoint,
                                                               scale: pointScale,
                                                               rotation: 0.0)
                }
            }
        }
    }
    
    func renderJigglePointUnselectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                           isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                if isPrecisePass {
                    jigglePointUnselectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointUnselectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                     pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJigglePointUnselectedFill(renderEncoder: MTLRenderCommandEncoder,
                                         isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                if isPrecisePass {
                    jigglePointUnselectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointUnselectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJigglePointSelectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                         isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                if isPrecisePass {
                    jigglePointSelectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointSelectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJigglePointSelectedFill(renderEncoder: MTLRenderCommandEncoder,
                                       isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                if isPrecisePass {
                    jigglePointSelectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointSelectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJigglePointUnselectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJigglePointsBloom {
                    jigglePointUnselectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderJigglePointSelectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJigglePointsBloom {
                    if !jiggle.isFrozen {
                        jigglePointSelectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
}
