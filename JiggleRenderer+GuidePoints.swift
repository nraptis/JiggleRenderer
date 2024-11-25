//
//  JiggleRenderer+GuidePoints.swift
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
    func prepareGuidePoints(jiggle: Jiggle,
                            pointScale: Float,
                            projectionMatrix: matrix_float4x4,
                            modelViewMatrix: matrix_float4x4,
                            baseAdjustRotation: Float,
                            isPrecisePass: Bool,
                            isBloomEnabled: Bool,
                            isCreatorModeGuideCenters: Bool,
                            isCreatorModeAddGuidePoints: Bool,
                            isCreatorModeDeleteGuidePoints: Bool,
                            guidePointSelectionModality: PointSelectionModality,
                            jiggleColorPack: JiggleRenderColorPack,
                            guidePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                            guidePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored,
                            guidePointSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                            guidePointSelectedFillBuffer: IndexedSpriteBuffer2DColored) {
        
        guidePointUnselectedStrokeBuffer.projectionMatrix = projectionMatrix
        guidePointUnselectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        guidePointUnselectedStrokeBuffer.red = jiggleColorPack.strokeRed
        guidePointUnselectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        guidePointUnselectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        guidePointUnselectedFillBuffer.projectionMatrix = projectionMatrix
        guidePointUnselectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        guidePointSelectedStrokeBuffer.projectionMatrix = projectionMatrix
        guidePointSelectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        guidePointSelectedStrokeBuffer.red = jiggleColorPack.strokeRed
        guidePointSelectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        guidePointSelectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        guidePointSelectedFillBuffer.projectionMatrix = projectionMatrix
        guidePointSelectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        if isBloomEnabled && jiggle.isShowingGuidePointsBloom && !isPrecisePass {
            
            guidePointUnselectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            guidePointUnselectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            guidePointUnselectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            guidePointUnselectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            guidePointUnselectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
            
            guidePointSelectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            guidePointSelectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            guidePointSelectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            guidePointSelectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            guidePointSelectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
        }
        
        for guideIndex in 0..<jiggle.guideCount {
            let guide = jiggle.guides[guideIndex]
            
            let guideColorPack = getGuideColorPack(jiggle: jiggle,
                                                   isJiggleSelected: isSelected,
                                                   isDarkModeEnabled: isDarkModeEnabled,
                                                   guide: guide,
                                                   guideIndex: guideIndex,
                                                   isCreatorModeGuideCenters: isCreatorModeGuideCenters,
                                                   isCreatorModeAddGuidePoints: isCreatorModeAddGuidePoints,
                                                   isCreatorModeDeleteGuidePoints: isCreatorModeDeleteGuidePoints,
                                                   guidePointSelectionModality: guidePointSelectionModality)
            
            for guideControlPointIndex in 0..<guide.guideControlPointCount {
                let guideControlPoint = guide.guideControlPoints[guideControlPointIndex]
                
                let renderCenterPoint = Math.Point(x: guideControlPoint.renderX,
                                                   y: guideControlPoint.renderY)
                
                // If frozen, no bloom, no selection.
                if guide.renderFrozen {
                    guidePointUnselectedStrokeBuffer.add(translation: renderCenterPoint,
                                                         scale: pointScale,
                                                         rotation: 0.0)
                    guidePointUnselectedFillBuffer.add(translation: renderCenterPoint,
                                                       scale: pointScale,
                                                       rotation: 0.0,
                                                       red: guideColorPack.fillUnselectedRed,
                                                       green: guideColorPack.fillUnselectedGreen,
                                                       blue: guideColorPack.fillUnselectedBlue,
                                                       alpha: 1.0)
                } else if guide.renderSelected && guideControlPoint.renderSelected && isSelected {
                    guidePointSelectedStrokeBuffer.add(translation: renderCenterPoint,
                                                       scale: pointScale,
                                                       rotation: 0.0)
                    guidePointSelectedFillBuffer.add(translation: renderCenterPoint,
                                                     scale: pointScale,
                                                     rotation: baseAdjustRotation,
                                                     red: guideColorPack.fillSelectedRed,
                                                     green: guideColorPack.fillSelectedGreen,
                                                     blue: guideColorPack.fillSelectedBlue,
                                                     alpha: 1.0)
                    if isBloomEnabled && jiggle.isShowingGuidePointsBloom && !isPrecisePass {
                        guidePointSelectedStrokeBufferBloom.add(translation: renderCenterPoint,
                                                                scale: pointScale,
                                                                rotation: 0.0)
                    }
                } else {
                    guidePointUnselectedStrokeBuffer.add(translation: renderCenterPoint,
                                                         scale: pointScale,
                                                         rotation: 0.0)
                    guidePointUnselectedFillBuffer.add(translation: renderCenterPoint,
                                                       scale: pointScale,
                                                       rotation: 0.0,
                                                       red: guideColorPack.fillUnselectedRed,
                                                       green: guideColorPack.fillUnselectedGreen,
                                                       blue: guideColorPack.fillUnselectedBlue,
                                                       alpha: 1.0)
                    
                    if guide.renderSelected && isSelected && isBloomEnabled && !isPrecisePass {
                        if jiggle.isShowingGuidePointsBloom {
                            guidePointUnselectedStrokeBufferBloom.add(translation: renderCenterPoint,
                                                                      scale: pointScale,
                                                                      rotation: 0.0)
                        }
                    }
                }
            } // End of guide points loop A
        }
    }
    
    func renderGuidePointUnselectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                          isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                if isPrecisePass {
                    guidePointUnselectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointUnselectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointUnselectedFill(renderEncoder: MTLRenderCommandEncoder,
                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                if isPrecisePass {
                    guidePointUnselectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointUnselectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointSelectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                if isPrecisePass {
                    guidePointSelectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointSelectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointSelectedFill(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                if isPrecisePass {
                    guidePointSelectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointSelectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointUnselectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuidePointsBloom {
                    guidePointUnselectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderGuidePointSelectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuidePointsBloom {
                    if !jiggle.isFrozen {
                        guidePointSelectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
}
