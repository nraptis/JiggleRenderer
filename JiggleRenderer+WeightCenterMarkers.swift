//
//  JiggleRenderer+WeightCenterMarkers.swift
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
    func prepareWeightCenter(jiggle: Jiggle,
                            worldScalePrecise: Float,
                            worldScaleStandard: Float,
                            projectionMatrix: matrix_float4x4,
                            modelViewMatrix: matrix_float4x4,
                            baseAdjustRotation: Float,
                            isPrecisePass: Bool,
                            isBloomEnabled: Bool,
                            jiggleColorPack: JiggleRenderColorPack,
                            weightCenterMarkerDotUnselectedFillInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerDotUnselectedStrokeInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerDotSelectedFillInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerDotSelectedStrokeInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerSpinnerUnselectedFillInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerSpinnerUnselectedStrokeInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerSpinnerSelectedFillInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerSpinnerSelectedStrokeInstance: IndexedSpriteInstance2D) {
        
        let weghtCenterScale: Float
        if isPrecisePass {
            weghtCenterScale = worldScalePrecise * JiggleViewModel.weightCenterScalePrecise
        } else {
            weghtCenterScale = worldScaleStandard * JiggleViewModel.weightCenterScaleStandard
        }
        
        var guideCenter = jiggle.guideCenter
        guideCenter = jiggle.transformPoint(point: guideCenter)
        var centerModelView = modelViewMatrix
        centerModelView.translation(x: guideCenter.x,
                                    y: guideCenter.y,
                                    z: 0.0)
        centerModelView.scale(weghtCenterScale)
        centerModelView.rotateZ(radians: baseAdjustRotation)
        
        var spinnerModelView = centerModelView
        spinnerModelView.rotateZ(radians: jiggle.guideCenterSpinnerRotation)
        
        if isSelected {
            
            weightCenterMarkerDotSelectedFillInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerDotSelectedFillInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotSelectedFillInstance.red = jiggleColorPack.fillWeightCenterRed
            weightCenterMarkerDotSelectedFillInstance.green = jiggleColorPack.fillWeightCenterGreen
            weightCenterMarkerDotSelectedFillInstance.blue = jiggleColorPack.fillWeightCenterBlue
            
            weightCenterMarkerDotSelectedStrokeInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerDotSelectedStrokeInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotSelectedStrokeInstance.red = jiggleColorPack.strokeRed
            weightCenterMarkerDotSelectedStrokeInstance.green = jiggleColorPack.strokeGreen
            weightCenterMarkerDotSelectedStrokeInstance.blue = jiggleColorPack.strokeBlue
            
            weightCenterMarkerSpinnerSelectedFillInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerSpinnerSelectedFillInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerSelectedFillInstance.red = jiggleColorPack.fillWeightCenterRed
            weightCenterMarkerSpinnerSelectedFillInstance.green = jiggleColorPack.fillWeightCenterGreen
            weightCenterMarkerSpinnerSelectedFillInstance.blue = jiggleColorPack.fillWeightCenterBlue
            
            weightCenterMarkerSpinnerSelectedStrokeInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerSpinnerSelectedStrokeInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerSelectedStrokeInstance.red = jiggleColorPack.strokeRed
            weightCenterMarkerSpinnerSelectedStrokeInstance.green = jiggleColorPack.strokeGreen
            weightCenterMarkerSpinnerSelectedStrokeInstance.blue = jiggleColorPack.strokeBlue
            
            if isBloomEnabled && jiggle.isShowingWeightCenterMarkerBloom && !isPrecisePass {
                
                weightCenterMarkerDotSelectedRegularBloomInstance.projectionMatrix = projectionMatrix
                weightCenterMarkerDotSelectedRegularBloomInstance.modelViewMatrix = centerModelView
                weightCenterMarkerDotSelectedRegularBloomInstance.red = jiggleColorPack.bloomRed
                weightCenterMarkerDotSelectedRegularBloomInstance.green = jiggleColorPack.bloomGreen
                weightCenterMarkerDotSelectedRegularBloomInstance.blue = jiggleColorPack.bloomBlue
                
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.projectionMatrix = projectionMatrix
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.modelViewMatrix = spinnerModelView
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.red = jiggleColorPack.bloomRed
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.green = jiggleColorPack.bloomGreen
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.blue = jiggleColorPack.bloomBlue
            }
            
        } else {
            weightCenterMarkerDotUnselectedFillInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerDotUnselectedFillInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotUnselectedFillInstance.red = jiggleColorPack.fillWeightCenterRed
            weightCenterMarkerDotUnselectedFillInstance.green = jiggleColorPack.fillWeightCenterGreen
            weightCenterMarkerDotUnselectedFillInstance.blue = jiggleColorPack.fillWeightCenterBlue
            
            weightCenterMarkerDotUnselectedStrokeInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerDotUnselectedStrokeInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotUnselectedStrokeInstance.red = jiggleColorPack.strokeRed
            weightCenterMarkerDotUnselectedStrokeInstance.green = jiggleColorPack.strokeGreen
            weightCenterMarkerDotUnselectedStrokeInstance.blue = jiggleColorPack.strokeBlue
            
            weightCenterMarkerSpinnerUnselectedFillInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerSpinnerUnselectedFillInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerUnselectedFillInstance.red = jiggleColorPack.fillWeightCenterRed
            weightCenterMarkerSpinnerUnselectedFillInstance.green = jiggleColorPack.fillWeightCenterGreen
            weightCenterMarkerSpinnerUnselectedFillInstance.blue = jiggleColorPack.fillWeightCenterBlue
            
            weightCenterMarkerSpinnerUnselectedStrokeInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerSpinnerUnselectedStrokeInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerUnselectedStrokeInstance.red = jiggleColorPack.strokeRed
            weightCenterMarkerSpinnerUnselectedStrokeInstance.green = jiggleColorPack.strokeGreen
            weightCenterMarkerSpinnerUnselectedStrokeInstance.blue = jiggleColorPack.strokeBlue
        }
    }
    
    func renderWeightCenterMarkerStroke(renderEncoder: MTLRenderCommandEncoder,
                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingWeightCenterMarker {
                if isSelected {
                    if isPrecisePass {
                        weightCenterMarkerDotSelectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerSelectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        weightCenterMarkerDotSelectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerSelectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                } else {
                    if isPrecisePass {
                        weightCenterMarkerDotUnselectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerUnselectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        weightCenterMarkerDotUnselectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerUnselectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                }
            }
        }
    }
    
    
    func renderWeightCenterMarkerFill(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingWeightCenterMarker {
                if isSelected {
                    if isPrecisePass {
                        weightCenterMarkerDotSelectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerSelectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        weightCenterMarkerDotSelectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerSelectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                } else {
                    if isPrecisePass {
                        weightCenterMarkerDotUnselectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerUnselectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        weightCenterMarkerDotUnselectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerUnselectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                }
            }
        }
    }
    
    func renderWeightCenterMarkerStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if isSelected {
                    if jiggle.isShowingWeightCenterMarkerBloom {
                        weightCenterMarkerDotSelectedRegularBloomInstance.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
                        weightCenterMarkerSpinnerSelectedRegularBloomInstance.render(renderEncoder: renderEncoder,
                                                                                     pipelineState: .spriteNodeIndexed3DAlphaBlending)
                        
                    }
                }
            }
        }
    }
    
}
