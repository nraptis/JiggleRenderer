//
//  JiggleRenderer+Mesh.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/28/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    func renderMesh2DRegular(renderEncoder: MTLRenderCommandEncoder) {
        
        guard let jiggle = jiggle else { return }
        
        if jiggle.isShowingMeshEditStandard {
            if Self.DIRTY_TRIANGLES_SHOW_DIRTY {
                if jiggle.currentHashMeshStandard.polyHash.triangulationType == .fast {
                    jiggle.jiggleMesh.editBufferStandardRegular.red = 0.9
                    jiggle.jiggleMesh.editBufferStandardRegular.green = 0.9
                    jiggle.jiggleMesh.editBufferStandardRegular.blue = 0.9
                } else {
                    jiggle.jiggleMesh.editBufferStandardRegular.red = 1.0
                    jiggle.jiggleMesh.editBufferStandardRegular.green = 1.0
                    jiggle.jiggleMesh.editBufferStandardRegular.blue = 1.0
                }
            }
            
            jiggle.jiggleMesh.editBufferStandardRegular.render(renderEncoder: renderEncoder,
                                                               pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
            
        } else if jiggle.isShowingMeshEditWeights {
            
            if Self.DIRTY_TRIANGLES_SHOW_DIRTY {
                if jiggle.currentHashMeshWeights.polyHash.triangulationType == .fast {
                    jiggle.jiggleMesh.editBufferWeightsRegular.red = 0.9
                    jiggle.jiggleMesh.editBufferWeightsRegular.green = 0.9
                    jiggle.jiggleMesh.editBufferWeightsRegular.blue = 0.9
                } else {
                    jiggle.jiggleMesh.editBufferWeightsRegular.red = 1.0
                    jiggle.jiggleMesh.editBufferWeightsRegular.green = 1.0
                    jiggle.jiggleMesh.editBufferWeightsRegular.blue = 1.0
                }
            }
            
            jiggle.jiggleMesh.editBufferWeightsRegular.render(renderEncoder: renderEncoder,
                                                              pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
        }
    }
    
    func renderMesh2DPrecise(renderEncoder: MTLRenderCommandEncoder) {
        
        guard let jiggle = jiggle else { return }
        
        
        if jiggle.isShowingMeshEditStandard {
            jiggle.jiggleMesh.editBufferStandardPrecise.render(renderEncoder: renderEncoder,
                                                               pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
        } else if jiggle.isShowingMeshEditWeights {
            jiggle.jiggleMesh.editBufferWeightsPrecise.render(renderEncoder: renderEncoder,
                                                              pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
        }
    }
    
    func renderMesh3D(jiggle: Jiggle, renderEncoder: MTLRenderCommandEncoder) {
        if jiggle.isShowingMeshViewStandard {
            
            /*
             if Self.DIRTY_TRIANGLES_SHOW_DIRTY {
             if jiggle.currentHashTrianglesViewStandard.polyHash.triangulationType == .fast {
             jiggle.jiggleMesh.viewBuffer.red = 1.0
             jiggle.jiggleMesh.viewBuffer.green = 0.5
             jiggle.jiggleMesh.viewBuffer.blue = 0.5
             } else {
             jiggle.jiggleMesh.viewBuffer.red = 1.0
             jiggle.jiggleMesh.viewBuffer.green = 1.0
             jiggle.jiggleMesh.viewBuffer.blue = 1.0
             }
             }
             
             //TODO: This is for test
             jiggle.jiggleMesh.viewBuffer.red = 0.8
             jiggle.jiggleMesh.viewBuffer.green = 0.5
             jiggle.jiggleMesh.viewBuffer.blue = 0.6
             */
            
            //jiggle.jiggleMesh.viewBuffer.render(renderEncoder: renderEncoder, pipelineState: .spriteNodeIndexed3DAdditiveBlending)
            jiggle.jiggleMesh.viewBuffer.render(renderEncoder: renderEncoder, pipelineState: .spriteNodeIndexed3DNoBlending)
            
        }
    }
    
    func renderMesh3DStereoscopicBlue(jiggle: Jiggle, renderEncoder: MTLRenderCommandEncoder) {
        if jiggle.isShowingMeshViewStereoscopic {
            jiggle.jiggleMesh.viewBufferStereoscopic.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeStereoscopicBlueIndexed3DNoBlending)
        }
    }
    
    func renderMesh3DStereoscopicRed(jiggle: Jiggle, renderEncoder: MTLRenderCommandEncoder) {
        if jiggle.isShowingMeshViewStereoscopic {
            jiggle.jiggleMesh.viewBufferStereoscopic.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeStereoscopicRedIndexed3DNoBlending)
        }
    }
    
}
