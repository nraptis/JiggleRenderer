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
    
    func renderMesh2D(jiggle: Jiggle,
                      renderEncoder: MTLRenderCommandEncoder,
                      isPrecisePass: Bool) {
        
        if jiggle.isShowingMeshEditStandard {
            
            if Self.DIRTY_TRIANGLES_SHOW_DIRTY {
                if jiggle.currentHashMeshStandard.polyHash.triangulationType == .fast {
                    jiggle.jiggleMesh.editBufferStandard.red = 0.9
                    jiggle.jiggleMesh.editBufferStandard.green = 0.9
                    jiggle.jiggleMesh.editBufferStandard.blue = 0.9
                } else {
                    jiggle.jiggleMesh.editBufferStandard.red = 1.0
                    jiggle.jiggleMesh.editBufferStandard.green = 1.0
                    jiggle.jiggleMesh.editBufferStandard.blue = 1.0
                }
            }
            
            if isPrecisePass {
                jiggle.jiggleMesh.editBufferStandard_Precise.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
                
            } else {
                jiggle.jiggleMesh.editBufferStandard.render(renderEncoder: renderEncoder,
                                                            pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
            }
        } else if jiggle.isShowingMeshEditWeights {
            
            if Self.DIRTY_TRIANGLES_SHOW_DIRTY {
                if jiggle.currentHashMeshWeights.polyHash.triangulationType == .fast {
                    jiggle.jiggleMesh.editBufferWeights.red = 0.9
                    jiggle.jiggleMesh.editBufferWeights.green = 0.9
                    jiggle.jiggleMesh.editBufferWeights.blue = 0.9
                } else {
                    jiggle.jiggleMesh.editBufferWeights.red = 1.0
                    jiggle.jiggleMesh.editBufferWeights.green = 1.0
                    jiggle.jiggleMesh.editBufferWeights.blue = 1.0
                }
            }
            
            if isPrecisePass {
                jiggle.jiggleMesh.editBufferWeights_Precise.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
            } else {
                jiggle.jiggleMesh.editBufferWeights.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
            }
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
