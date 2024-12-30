//
//  JiggleRenderer+JiggleBorderRing.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/24/24.
//

import Foundation
import Metal

extension JiggleRenderer {
    
    func renderBorderRingBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleBorderRingsBloom {
                    jiggle.solidLineBufferRegularBloom.render(renderEncoder: renderEncoder,
                                                              pipelineState: .shapeNodeIndexed3DNoBlending)
                }
            }
        }
    }
    
    func renderBorderRingStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleBorderRings {
                jiggle.solidLineBufferRegularStroke.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeIndexed2DNoBlending)
            }
        }
    }
    
    func renderBorderRingFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleBorderRings {
                jiggle.solidLineBufferRegularFill.render(renderEncoder: renderEncoder,
                                                         pipelineState: .shapeNodeIndexed2DNoBlending)
            }
        }
    }
    
    func renderBorderRingBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleBorderRingsBloom {
                    if !jiggle.isFrozen {
                        jiggle.solidLineBufferPreciseBloom.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .shapeNodeIndexed3DNoBlending)
                    }
                }
            }
        }
    }
    
    func renderBorderRingStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleBorderRings {
                jiggle.solidLineBufferPreciseStroke.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeIndexed2DNoBlending)
            }
        }
    }
    
    func renderBorderRingFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleBorderRings {
                jiggle.solidLineBufferPreciseFill.render(renderEncoder: renderEncoder,
                                                         pipelineState: .shapeNodeIndexed2DNoBlending)
            }
        }
    }
    
}
