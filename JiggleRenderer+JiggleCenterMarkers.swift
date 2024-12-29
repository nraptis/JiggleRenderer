//
//  JiggleRenderer+JiggleCenterMarkers.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/25/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    func getJiggleCenterCreatorModeFormat(creatorMode: CreatorMode) -> JiggleCenterCreatorModeFormat {
        let creatorModeFormat: JiggleCenterCreatorModeFormat
        switch creatorMode {
        case .none:
            creatorModeFormat = .regular
        case .makeJiggle:
            creatorModeFormat = .alternative
        case .drawJiggle:
            creatorModeFormat = .alternative
        case .addJigglePoint:
            creatorModeFormat = .alternative
        case .removeJigglePoint:
            creatorModeFormat = .alternative
        case .makeGuide:
            creatorModeFormat = .invalid
        case .drawGuide:
            creatorModeFormat = .invalid
        case .addGuidePoint:
            creatorModeFormat = .invalid
        case .removeGuidePoint:
            creatorModeFormat = .invalid
        case .moveJiggleCenter:
            creatorModeFormat = .jiggleCenter
        case .moveGuideCenter:
            creatorModeFormat = .invalid
        }
        return creatorModeFormat
    }
    
    // This is mainly just to compute the colors...
    // We only do it *ONCE* for both Precise and Regular...
    func pre_prepareJiggleCenter() {
        
        guard let jiggle = jiggle else { return }
        guard jiggle.isShowingCenterMarker else { return }
        
        if isJiggleFrozen {
            color_jiggle_center_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_jiggle_center_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            return
        }
        
        switch jiggleCenterCreatorModeFormat {
        case .invalid:
            //TODO: Don't harsh me bro
            print("FATAL ERROR: Should not render jiggle center in this case.")
            fatalError("Gay Tesla")
            break
        case .regular:
            if isJiggleSelected {
                switch editMode {
                case .jiggles:
                    color_jiggle_center_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                    color_jiggle_center_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
                case .points:
                    color_jiggle_center_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                    color_jiggle_center_fill = RTJ.fillRegSelUnm(isDarkMode: isDarkMode)
                }
            } else {
                color_jiggle_center_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_jiggle_center_fill = RTJ.fillRegUnsUnm(isDarkMode: isDarkMode)
            }
        case .alternative:
            if isJiggleSelected {
                color_jiggle_center_stroke = RTJ.strokeAltSel(isDarkMode: isDarkMode)
                color_jiggle_center_fill = RTJ.fillAltSelUnm(isDarkMode: isDarkMode)
            } else {
                color_jiggle_center_stroke = RTJ.strokeAltUns(isDarkMode: isDarkMode)
                color_jiggle_center_fill = RTJ.fillAltUnsUnm(isDarkMode: isDarkMode)
            }
        case .jiggleCenter:
            if isJiggleSelected {
                color_jiggle_center_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_jiggle_center_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
            } else {
                color_jiggle_center_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_jiggle_center_fill = RTJ.centerMarkerUnselectedActive(isDarkMode: isDarkMode)
            }
        }
    }
    
    // @Precondition: pre_prepareJiggleCenter()
    // @Precondition: color_bloom is calculated
    func prepareJiggleCenter(jiggleCenterMarkerUnselectedStrokeInstance: IndexedSpriteInstance2D,
                             jiggleCenterMarkerUnselectedFillInstance: IndexedSpriteInstance2D,
                             jiggleCenterMarkerSelectedBloomInstance: IndexedSpriteInstance3D,
                             jiggleCenterMarkerSelectedStrokeInstance: IndexedSpriteInstance2D,
                             jiggleCenterMarkerSelectedFillInstance: IndexedSpriteInstance2D,
                             isPrecisePass: Bool) {
        
        guard let graphics = graphics else { return }
        guard let jiggle = jiggle else { return }
        guard jiggle.isShowingCenterMarker else { return }

        let isBloom = (isBloomMode && jiggle.isShowingCenterMarkerBloom)
        
        var offsetCenter = jiggle.offsetCenter
        offsetCenter = jiggle.transformPoint(point: offsetCenter)
        offsetCenter = projectionMatrix.process2d(point: offsetCenter,
                                           screenWidth: graphics.width,
                                           screenHeight: graphics.height)
        
        var centerModelView = matrix_identity_float4x4
        centerModelView.translation(point: offsetCenter)
        
        if isJiggleSelected {
            jiggleCenterMarkerSelectedFillInstance.projectionMatrix = orthoMatrix
            jiggleCenterMarkerSelectedFillInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerSelectedFillInstance.rgba = color_jiggle_center_fill
            
            jiggleCenterMarkerSelectedStrokeInstance.projectionMatrix = orthoMatrix
            jiggleCenterMarkerSelectedStrokeInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerSelectedStrokeInstance.rgba = color_jiggle_center_stroke
            
            if isBloom {
                jiggleCenterMarkerSelectedBloomInstance.projectionMatrix = orthoMatrix
                jiggleCenterMarkerSelectedBloomInstance.modelViewMatrix = centerModelView
                jiggleCenterMarkerSelectedBloomInstance.rgba = color_bloom
            }
        } else {
            jiggleCenterMarkerUnselectedFillInstance.projectionMatrix = orthoMatrix
            jiggleCenterMarkerUnselectedFillInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerUnselectedFillInstance.rgba = color_jiggle_center_fill
            
            jiggleCenterMarkerUnselectedStrokeInstance.projectionMatrix = orthoMatrix
            jiggleCenterMarkerUnselectedStrokeInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerUnselectedStrokeInstance.rgba = color_jiggle_center_stroke
        }
    }
    
    func renderJiggleCenterMarkerBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if isJiggleSelected {
                    if jiggle.isShowingCenterMarkerBloom {
                        jiggleCenterMarkerSelectedRegularBloomInstance.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderJiggleCenterMarkerStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingCenterMarker {
                if isJiggleSelected {
                    jiggleCenterMarkerSelectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jiggleCenterMarkerUnselectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJiggleCenterMarkerFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingCenterMarker {
                if isJiggleSelected {
                    jiggleCenterMarkerSelectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                         pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jiggleCenterMarkerUnselectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    
    func renderJiggleCenterMarkerBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if isJiggleSelected {
                    if jiggle.isShowingCenterMarkerBloom {
                        jiggleCenterMarkerSelectedPreciseBloomInstance.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderJiggleCenterMarkerStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingCenterMarker {
                if isJiggleSelected {
                    jiggleCenterMarkerSelectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jiggleCenterMarkerUnselectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJiggleCenterMarkerFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingCenterMarker {
                if isJiggleSelected {
                    jiggleCenterMarkerSelectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                         pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jiggleCenterMarkerUnselectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
}
