//
//  JiggleRenderer+JiggleCenterMarkers.swift
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
    func prepareJiggleCenter(jiggle: Jiggle,
                            worldScalePrecise: Float,
                            worldScaleStandard: Float,
                            projectionMatrix: matrix_float4x4,
                            modelViewMatrix: matrix_float4x4,
                            baseAdjustRotation: Float,
                            isPrecisePass: Bool,
                            isBloomEnabled: Bool,
                            jiggleColorPack: JiggleRenderColorPack,
                            jiggleCenterMarkerUnselectedFillInstance: IndexedSpriteInstance2D,
                            jiggleCenterMarkerUnselectedStrokeInstance: IndexedSpriteInstance2D,
                            jiggleCenterMarkerSelectedFillInstance: IndexedSpriteInstance2D,
                            jiggleCenterMarkerSelectedStrokeInstance: IndexedSpriteInstance2D) {
        let jiggleCenterScale: Float
        if isPrecisePass {
            jiggleCenterScale = worldScalePrecise * JiggleViewModel.jiggleCenterScalePrecise
        } else {
            jiggleCenterScale = worldScaleStandard * JiggleViewModel.jiggleCenterScaleStandard
        }
        var offsetCenter = jiggle.offsetCenter
        offsetCenter = jiggle.transformPoint(point: offsetCenter)
        var centerModelView = modelViewMatrix
        centerModelView.translation(x: offsetCenter.x,
                                    y: offsetCenter.y,
                                    z: 0.0)
        centerModelView.scale(jiggleCenterScale)
        centerModelView.rotateZ(radians: baseAdjustRotation)
        if isSelected {
            jiggleCenterMarkerSelectedFillInstance.projectionMatrix = projectionMatrix
            jiggleCenterMarkerSelectedFillInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerSelectedFillInstance.red = jiggleColorPack.fillUnselectedRed
            jiggleCenterMarkerSelectedFillInstance.green = jiggleColorPack.fillUnselectedBlue
            jiggleCenterMarkerSelectedFillInstance.blue = jiggleColorPack.fillUnselectedBlue
            jiggleCenterMarkerSelectedStrokeInstance.projectionMatrix = projectionMatrix
            jiggleCenterMarkerSelectedStrokeInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerSelectedStrokeInstance.red = jiggleColorPack.strokeRed
            jiggleCenterMarkerSelectedStrokeInstance.green = jiggleColorPack.strokeGreen
            jiggleCenterMarkerSelectedStrokeInstance.blue = jiggleColorPack.strokeBlue
            if jiggle.isShowingCenterMarkerBloom && isBloomEnabled && !isPrecisePass {
                jiggleCenterMarkerSelectedRegularBloomInstance.projectionMatrix = projectionMatrix
                jiggleCenterMarkerSelectedRegularBloomInstance.modelViewMatrix = centerModelView
                jiggleCenterMarkerSelectedRegularBloomInstance.red = jiggleColorPack.bloomRed
                jiggleCenterMarkerSelectedRegularBloomInstance.green = jiggleColorPack.bloomGreen
                jiggleCenterMarkerSelectedRegularBloomInstance.blue = jiggleColorPack.bloomBlue
            }
        } else {
            jiggleCenterMarkerUnselectedFillInstance.projectionMatrix = projectionMatrix
            jiggleCenterMarkerUnselectedFillInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerUnselectedFillInstance.red = jiggleColorPack.fillUnselectedRed
            jiggleCenterMarkerUnselectedFillInstance.green = jiggleColorPack.fillUnselectedBlue
            jiggleCenterMarkerUnselectedFillInstance.blue = jiggleColorPack.fillUnselectedBlue
            jiggleCenterMarkerUnselectedStrokeInstance.projectionMatrix = projectionMatrix
            jiggleCenterMarkerUnselectedStrokeInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerUnselectedStrokeInstance.red = jiggleColorPack.strokeRed
            jiggleCenterMarkerUnselectedStrokeInstance.green = jiggleColorPack.strokeGreen
            jiggleCenterMarkerUnselectedStrokeInstance.blue = jiggleColorPack.strokeBlue
        }
    }
    
    func renderJiggleCenterMarkerStroke(renderEncoder: MTLRenderCommandEncoder,
                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingCenterMarker {
                if isSelected {
                    if isPrecisePass {
                        jiggleCenterMarkerSelectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        jiggleCenterMarkerSelectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                } else {
                    if isPrecisePass {
                        jiggleCenterMarkerUnselectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        jiggleCenterMarkerUnselectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                }
            }
        }
    }
    
    func renderJiggleCenterMarkerFill(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingCenterMarker {
                if isSelected {
                    if isPrecisePass {
                        jiggleCenterMarkerSelectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        jiggleCenterMarkerSelectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                } else {
                    if isPrecisePass {
                        jiggleCenterMarkerUnselectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        jiggleCenterMarkerUnselectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                }
            }
        }
    }
    
    func renderJiggleCenterMarkerStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if isSelected {
                    if jiggle.isShowingCenterMarkerBloom {
                        jiggleCenterMarkerSelectedRegularBloomInstance.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
}

