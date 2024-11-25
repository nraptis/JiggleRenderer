//
//  JiggleRenderer+GuideBorderRings.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 11/24/24.
//

import Foundation
import Metal

extension JiggleRenderer {
    
    func renderGuideBorderRingsBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuideBorderRingBloom {
                    if !jiggle.isFrozen {
                        if let selectedGuide = jiggle.getSelectedGuide() {
                            if selectedGuide.isFrozen == false {
                                let scale = getAdjustScale()
                                selectedGuide.solidLineBloomBuffer.render(renderEncoder: renderEncoder,
                                                                          pipelineState: .shapeNodeIndexed3DNoBlending,
                                                                          scale: scale)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func renderGuideBorderRingsStroke(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideBorderRings {
                let scale = getAdjustScale()
                if isPrecisePass {
                    for guideIndex in 0..<jiggle.guideCount {
                        let guide = jiggle.guides[guideIndex]
                        guide.solidLineBufferStroke_Precise.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .shapeNodeIndexed2DNoBlending,
                                                                   scale: scale)
                    }
                } else {
                    for guideIndex in 0..<jiggle.guideCount {
                        let guide = jiggle.guides[guideIndex]
                        guide.solidLineBufferStroke.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeIndexed2DNoBlending,
                                                           scale: scale)
                    }
                }
                
            }
        }
    }
    
    func renderGuideBorderRingFill(renderEncoder: MTLRenderCommandEncoder,
                                   isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideBorderRings {
                let scale = getAdjustScale()
                if isPrecisePass {
                    for guideIndex in 0..<jiggle.guideCount {
                        let guide = jiggle.guides[guideIndex]
                        guide.solidLineBuffer_Precise.render(renderEncoder: renderEncoder,
                                                             pipelineState: .shapeNodeIndexed2DNoBlending,
                                                             scale: scale)
                    }
                } else {
                    for guideIndex in 0..<jiggle.guideCount {
                        let guide = jiggle.guides[guideIndex]
                        guide.solidLineBuffer.render(renderEncoder: renderEncoder,
                                                     pipelineState: .shapeNodeIndexed2DNoBlending,
                                                     scale: scale)
                    }
                }
            }
        }
    }
}
