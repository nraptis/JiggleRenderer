//
//  JiggleRenderer+WeightCenterMarkers.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/25/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    func getWeightCenterCreatorModeFormat(creatorMode: CreatorMode) -> WeightCenterCreatorModeFormat {
        let creatorModeFormat: WeightCenterCreatorModeFormat
        switch creatorMode {
        case .none:
            creatorModeFormat = .regular
        case .makeJiggle:
            creatorModeFormat = .invalid
        case .drawJiggle:
            creatorModeFormat = .invalid
        case .addJigglePoint:
            creatorModeFormat = .invalid
        case .removeJigglePoint:
            creatorModeFormat = .invalid
        case .makeGuide:
            creatorModeFormat = .alternative
        case .drawGuide:
            creatorModeFormat = .alternative
        case .addGuidePoint:
            creatorModeFormat = .alternative
        case .removeGuidePoint:
            creatorModeFormat = .alternative
        case .moveJiggleCenter:
            creatorModeFormat = .invalid
        case .moveGuideCenter:
            creatorModeFormat = .weightCenter
        }
        return creatorModeFormat
    }
    
    func pre_prepareWeightCenter() {
        
        guard let jiggle = jiggle else { return }
        guard jiggle.isShowingWeightCenterMarker else { return }
        
        if isJiggleFrozen {
            color_weight_center_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_weight_center_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            return
        }
        
        switch weightCenterCreatorModeFormat {
        case .invalid:
            //TODO: Don't harsh me bro
            print("FATAL ERROR: Should not render weight center in this case.")
            fatalError("Gay Tesla")
            break
        case .regular:
            if isJiggleSelected {
                switch weightMode {
                case .guides:
                    color_weight_center_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                    color_weight_center_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
                case .points:
                    color_weight_center_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                    color_weight_center_fill = RTJ.fillRegSelUnm(isDarkMode: isDarkMode)
                }
            } else {
                color_weight_center_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_weight_center_fill = RTJ.fillRegUnsUnm(isDarkMode: isDarkMode)
            }
        case .alternative:
            if isJiggleSelected {
                color_weight_center_stroke = RTJ.strokeAltSel(isDarkMode: isDarkMode)
                color_weight_center_fill = RTJ.fillAltSelUnm(isDarkMode: isDarkMode)
            } else {
                color_weight_center_stroke = RTJ.strokeAltUns(isDarkMode: isDarkMode)
                color_weight_center_fill = RTJ.fillAltUnsUnm(isDarkMode: isDarkMode)
            }
        case .weightCenter:
            if isJiggleSelected {
                color_weight_center_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_weight_center_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
            } else {
                color_weight_center_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_weight_center_fill = RTJ.centerMarkerUnselectedActive(isDarkMode: isDarkMode)
            }
        }
    }
    
    @inline(__always)
    func prepareWeightCenter(weightCenterMarkerDotUnselectedStrokeInstance: IndexedSpriteInstance2D,
                             weightCenterMarkerDotUnselectedFillInstance: IndexedSpriteInstance2D,
                             weightCenterMarkerDotSelectedBloomInstance: IndexedSpriteInstance3D,
                             weightCenterMarkerDotSelectedFillInstance: IndexedSpriteInstance2D,
                             weightCenterMarkerDotSelectedStrokeInstance: IndexedSpriteInstance2D,
                             weightCenterMarkerSpinnerUnselectedStrokeInstance: IndexedSpriteInstance2D,
                             weightCenterMarkerSpinnerUnselectedFillInstance: IndexedSpriteInstance2D,
                             weightCenterMarkerSpinnerSelectedBloomInstance: IndexedSpriteInstance3D,
                             weightCenterMarkerSpinnerSelectedFillInstance: IndexedSpriteInstance2D,
                             weightCenterMarkerSpinnerSelectedStrokeInstance: IndexedSpriteInstance2D,
                             isPrecisePass: Bool) {
        
        guard let graphics = graphics else { return }
        guard let jiggle = jiggle else { return }
        guard jiggle.isShowingWeightCenterMarker else { return }
        
        let isBloom = (isBloomMode && jiggle.isShowingWeightCenterMarkerBloom)
        
        var guideCenter = jiggle.guideCenter
        guideCenter = jiggle.transformPoint(point: guideCenter)
        guideCenter = projectionMatrix.process2d(point: guideCenter,
                                           screenWidth: graphics.width,
                                           screenHeight: graphics.height)
        
        var centerModelView = matrix_identity_float4x4
        centerModelView.translation(point: guideCenter)
        
        centerModelView.rotateZ(radians: inverseRotation)
        var spinnerModelView = centerModelView
        spinnerModelView.rotateZ(radians: jiggle.guideCenterSpinnerRotation)
        
        if isJiggleSelected {
            
            if isBloom {
                weightCenterMarkerDotSelectedBloomInstance.projectionMatrix = orthoMatrix
                weightCenterMarkerDotSelectedBloomInstance.modelViewMatrix = centerModelView
                weightCenterMarkerDotSelectedBloomInstance.rgba = color_bloom
            }
            
            weightCenterMarkerDotSelectedStrokeInstance.projectionMatrix = orthoMatrix
            weightCenterMarkerDotSelectedStrokeInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotSelectedStrokeInstance.rgba = color_weight_center_stroke
            
            weightCenterMarkerDotSelectedFillInstance.projectionMatrix = orthoMatrix
            weightCenterMarkerDotSelectedFillInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotSelectedFillInstance.rgba = color_weight_center_fill
            
            if isBloom {
                weightCenterMarkerSpinnerSelectedBloomInstance.projectionMatrix = orthoMatrix
                weightCenterMarkerSpinnerSelectedBloomInstance.modelViewMatrix = spinnerModelView
                weightCenterMarkerSpinnerSelectedBloomInstance.rgba = color_bloom
            }
            
            weightCenterMarkerSpinnerSelectedStrokeInstance.projectionMatrix = orthoMatrix
            weightCenterMarkerSpinnerSelectedStrokeInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerSelectedStrokeInstance.rgba = color_weight_center_stroke
            
            weightCenterMarkerSpinnerSelectedFillInstance.projectionMatrix = orthoMatrix
            weightCenterMarkerSpinnerSelectedFillInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerSelectedFillInstance.rgba = color_weight_center_fill
            
        } else {
            weightCenterMarkerDotUnselectedStrokeInstance.projectionMatrix = orthoMatrix
            weightCenterMarkerDotUnselectedStrokeInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotUnselectedStrokeInstance.rgba = color_weight_center_stroke
            
            weightCenterMarkerDotUnselectedFillInstance.projectionMatrix = orthoMatrix
            weightCenterMarkerDotUnselectedFillInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotUnselectedFillInstance.rgba = color_weight_center_fill
            
            weightCenterMarkerSpinnerUnselectedStrokeInstance.projectionMatrix = orthoMatrix
            weightCenterMarkerSpinnerUnselectedStrokeInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerUnselectedStrokeInstance.rgba = color_weight_center_stroke
            
            weightCenterMarkerSpinnerUnselectedFillInstance.projectionMatrix = orthoMatrix
            weightCenterMarkerSpinnerUnselectedFillInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerUnselectedFillInstance.rgba = color_weight_center_fill
        }
    }
    
    func renderWeightCenterMarkerBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if isJiggleSelected {
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
    
    func renderWeightCenterMarkerStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingWeightCenterMarker {
                if isJiggleSelected {
                    weightCenterMarkerDotSelectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    weightCenterMarkerSpinnerSelectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
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
    
    func renderWeightCenterMarkerFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingWeightCenterMarker {
                if isJiggleSelected {
                    weightCenterMarkerDotSelectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    weightCenterMarkerSpinnerSelectedRegularFillInstance.render(renderEncoder: renderEncoder,
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
    
    func renderWeightCenterMarkerBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if isJiggleSelected {
                    if jiggle.isShowingWeightCenterMarkerBloom {
                        weightCenterMarkerDotSelectedPreciseBloomInstance.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeIndexed3DAlphaBlending)
                        weightCenterMarkerSpinnerSelectedPreciseBloomInstance.render(renderEncoder: renderEncoder,
                                                                                     pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderWeightCenterMarkerStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingWeightCenterMarker {
                if isJiggleSelected {
                    weightCenterMarkerDotSelectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    weightCenterMarkerSpinnerSelectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    weightCenterMarkerDotUnselectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    weightCenterMarkerSpinnerUnselectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderWeightCenterMarkerFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingWeightCenterMarker {
                if isJiggleSelected {
                    weightCenterMarkerDotSelectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    weightCenterMarkerSpinnerSelectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    weightCenterMarkerDotUnselectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    weightCenterMarkerSpinnerUnselectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
}
