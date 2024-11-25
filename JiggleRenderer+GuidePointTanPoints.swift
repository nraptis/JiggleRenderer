//
//  JiggleRenderer+GuidePointTanPoints.swift
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
    func prepareGuidePointTanPoints(jiggle: Jiggle,
                                     projectionMatrix: matrix_float4x4,
                                     modelViewMatrix: matrix_float4x4,
                                     pointScale: Float,
                                     isPrecisePass: Bool,
                                     isBloomEnabled: Bool,
                                     jiggleColorPack: JiggleRenderColorPack,
                                     selectedGuidePointTanType: TanType,
                                     guidePointTanHandlePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                                     guidePointTanHandlePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored,
                                     guidePointTanHandlePointSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                                    guidePointTanHandlePointSelectedFillBuffer: IndexedSpriteBuffer2DColored) {
        
        
        
    }
    
    
    func renderGuidePointTanHandlePointUnselectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandlePointUnselectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointTanHandlePointUnselectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointUnselectedFill(renderEncoder: MTLRenderCommandEncoder,
                                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandlePointUnselectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointTanHandlePointUnselectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointSelectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandlePointSelectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointTanHandlePointSelectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointSelectedFill(renderEncoder: MTLRenderCommandEncoder,
                                                    isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandlePointSelectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointTanHandlePointSelectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointUnselectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuideControlPointTanHandlesBloom {
                    guidePointTanHandlePointUnselectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointSelectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuideControlPointTanHandlesBloom {
                    if !jiggle.isFrozen {
                        guidePointTanHandlePointSelectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
}
