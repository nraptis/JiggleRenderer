//
//  JiggleRenderer+JiggleBorderRing.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 11/24/24.
//

import Foundation
import Metal

extension JiggleRenderer {
    
    func renderJiggleBorderRingBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleBorderRingsBloom {
                    if !jiggle.isFrozen {
                        let scale = getAdjustScale()
                        jiggle.solidLineBloomBuffer.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeIndexed3DNoBlending,
                                                           scale: scale)
                    }
                }
            }
        }
    }
    
    func renderJiggleBorderRingStroke(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleBorderRings {
                let scale = getAdjustScale()
                if isPrecisePass {
                    jiggle.solidLineBufferStroke_Precise.render(renderEncoder: renderEncoder,
                                                                pipelineState: .shapeNodeIndexed2DNoBlending,
                                                                scale: scale)
                } else {
                    jiggle.solidLineBufferStroke.render(renderEncoder: renderEncoder,
                                                        pipelineState: .shapeNodeIndexed2DNoBlending,
                                                        scale: scale)
                }
            }
        }
    }
    
    func renderJiggleBorderRingFill(renderEncoder: MTLRenderCommandEncoder,
                                isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleBorderRings {
                let scale = getAdjustScale()
                if isPrecisePass {
                    jiggle.solidLineBuffer_Precise.render(renderEncoder: renderEncoder,
                                                          pipelineState: .shapeNodeIndexed2DNoBlending,
                                                          scale: scale)
                } else {
                    jiggle.solidLineBuffer.render(renderEncoder: renderEncoder,
                                                  pipelineState: .shapeNodeIndexed2DNoBlending,
                                                  scale: scale)
                }
            }
        }
    }
    
}
