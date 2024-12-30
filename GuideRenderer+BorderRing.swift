//
//  GuideRenderer+JiggleBorderRing.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/29/24.
//

import Foundation
import Metal

extension GuideRenderer {
    
    func renderBorderRingBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    if jiggle.isShowingGuideBorderRingsBloom {
                        if let guide = guide {
                            guide.solidLineBufferRegularBloom.render(renderEncoder: renderEncoder,
                                                                     pipelineState: .shapeNodeIndexed3DNoBlending)
                        }
                    }
                }
            }
        }
    }
    
    func renderBorderRingBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    
                    if jiggle.isShowingGuideBorderRingsBloom {
                        if let guide = guide {
                            guide.solidLineBufferPreciseBloom.render(renderEncoder: renderEncoder,
                                                                     pipelineState: .shapeNodeIndexed3DNoBlending)
                        }
                    }
                }
            }
        }
    }
    
    func renderBorderRingStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideBorderRings {
                if let guide = guide {
                    guide.solidLineBufferRegularStroke.render(renderEncoder: renderEncoder,
                                                              pipelineState: .shapeNodeIndexed2DNoBlending)
                }
            }
        }
    }
    
    func renderBorderRingStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideBorderRings {
                if let guide = guide {
                    guide.solidLineBufferPreciseStroke.render(renderEncoder: renderEncoder,
                                                              pipelineState: .shapeNodeIndexed2DNoBlending)
                }
            }
        }
    }
    
    func renderBorderRingFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideBorderRings {
                if let guide = guide {
                    guide.solidLineBufferRegularFill.render(renderEncoder: renderEncoder,
                                                            pipelineState: .shapeNodeIndexed2DNoBlending)
                }
            }
        }
    }
    
    func renderBorderRingFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideBorderRings {
                if let guide = guide {
                    guide.solidLineBufferPreciseFill.render(renderEncoder: renderEncoder,
                                                            pipelineState: .shapeNodeIndexed2DNoBlending)
                }
            }
        }
    }
    
}
