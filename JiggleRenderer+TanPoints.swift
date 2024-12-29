//
//  JiggleRenderer+JigglePointTanPoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/25/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    func pre_prepareTanPoints() {
        
        guard let jiggle = jiggle else { return }
        guard jiggle.isShowingJiggleControlPointTanHandles else { return }
        
        if isJiggleFrozen {
            color_tan_points_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_tan_points_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            return
        }
        
        switch jiggleTansCreatorModeFormat {
        case .invalid:
            //TODO: Don't harsh me bro
            print("FATAL ERROR: Should not render tan points in this case.")
            break
        case .regular:
            if isJiggleSelected {
                color_tan_points_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTJ.tanPointFillSel(isDarkMode: isDarkMode)
                color_tan_points_selected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_tan_points_selected_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
            } else {
                color_tan_points_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTJ.tanPointFillUns(isDarkMode: isDarkMode)
            }
        case .alternative:
            if isJiggleSelected {
                color_tan_points_unselected_stroke = RTJ.strokeAltSel(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTJ.fillAltSelUnm(isDarkMode: isDarkMode)
            } else {
                color_tan_points_unselected_stroke = RTJ.strokeAltUns(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTJ.fillAltUnsUnm(isDarkMode: isDarkMode)
            }
        }
    }
    
    // @Precondition: pre_prepareTanPoints()
    // @Precondition: pre_prepareTanLines
    @inline(__always)
    func prepareTanPoints(tanHandlePointsUnselectedBloomBuffer: IndexedSpriteBuffer3D,
                          tanHandlePointsUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                          tanHandlePointsUnselectedFillBuffer: IndexedSpriteBuffer2D,
                          tanHandlePointsSelectedBloomBuffer: IndexedSpriteBuffer3D,
                          tanHandlePointsSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                          tanHandlePointsSelectedFillBuffer: IndexedSpriteBuffer2D,
                          isPrecisePass: Bool) {
        
        guard let graphics = graphics else { return }
        guard let jiggle = jiggle else { return }
        guard jiggle.isShowingJiggleControlPointTanHandles else { return }
        
        switch jiggleTansCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && jiggle.isShowingJiggleControlPointTanHandlesBloom)
        
        if isBloom {
            tanHandlePointsUnselectedBloomBuffer.projectionMatrix = orthoMatrix
            tanHandlePointsUnselectedBloomBuffer.rgba = color_bloom
        }
        
        tanHandlePointsUnselectedStrokeBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsUnselectedStrokeBuffer.rgba = color_tan_points_unselected_stroke
        
        tanHandlePointsUnselectedFillBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsUnselectedFillBuffer.rgba = color_tan_points_unselected_fill
        
        if isBloom {
            tanHandlePointsSelectedBloomBuffer.projectionMatrix = orthoMatrix
            tanHandlePointsSelectedBloomBuffer.rgba = color_bloom
        }
        
        tanHandlePointsSelectedStrokeBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsSelectedStrokeBuffer.rgba = color_tan_points_selected_stroke
        
        tanHandlePointsSelectedFillBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsSelectedFillBuffer.rgba = color_tan_points_selected_fill
        
        for jiggleControlPointIndex in 0..<jiggle.jiggleControlPointCount {
            let jiggleControlPoint = jiggle.jiggleControlPoints[jiggleControlPointIndex]
            var renderCenterPointIn = Math.Point(x: jiggleControlPoint.renderTanInX,
                                                 y: jiggleControlPoint.renderTanInY)
            renderCenterPointIn = projectionMatrix.process2d(point: renderCenterPointIn,
                                                             screenWidth: graphics.width,
                                                             screenHeight: graphics.height)
            
            var renderCenterPointOut = Math.Point(x: jiggleControlPoint.renderTanOutX,
                                                  y: jiggleControlPoint.renderTanOutY)
            renderCenterPointOut = projectionMatrix.process2d(point: renderCenterPointOut,
                                                              screenWidth: graphics.width,
                                                              screenHeight: graphics.height)
            
            if jiggleControlPoint.renderTanInSelected {
                if isBloom {
                    tanHandlePointsSelectedBloomBuffer.add(translation: renderCenterPointIn)
                }
                tanHandlePointsSelectedStrokeBuffer.add(translation: renderCenterPointIn)
                tanHandlePointsSelectedFillBuffer.add(translation: renderCenterPointIn)
            } else {
                if isBloom {
                    tanHandlePointsUnselectedBloomBuffer.add(translation: renderCenterPointIn)
                }
                tanHandlePointsUnselectedStrokeBuffer.add(translation: renderCenterPointIn)
                tanHandlePointsUnselectedFillBuffer.add(translation: renderCenterPointIn)
            }
            
            if jiggleControlPoint.renderTanOutSelected {
                if isBloom {
                    tanHandlePointsSelectedBloomBuffer.add(translation: renderCenterPointOut)
                }
                tanHandlePointsSelectedStrokeBuffer.add(translation: renderCenterPointOut)
                tanHandlePointsSelectedFillBuffer.add(translation: renderCenterPointOut)
                
            } else {
                if isBloom {
                    tanHandlePointsUnselectedBloomBuffer.add(translation: renderCenterPointOut)
                }
                tanHandlePointsUnselectedStrokeBuffer.add(translation: renderCenterPointOut)
                tanHandlePointsUnselectedFillBuffer.add(translation: renderCenterPointOut)
            }
        }
    }
    
    func renderTanHandlePointsUnselectedBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleControlPointTanHandlesBloom {
                    tanHandlePointsUnselectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                       pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderTanHandlePointsUnselectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                tanHandlePointsUnselectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsUnselectedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                tanHandlePointsUnselectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsUnselectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleControlPointTanHandlesBloom {
                    tanHandlePointsUnselectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                       pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderTanHandlePointsUnselectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                tanHandlePointsUnselectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsUnselectedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                tanHandlePointsUnselectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsSelectedBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleControlPointTanHandlesBloom {
                    tanHandlePointsSelectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                     pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    
                }
            }
        }
    }
    
    func renderTanHandlePointsSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                tanHandlePointsSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                tanHandlePointsSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsSelectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleControlPointTanHandlesBloom {
                    tanHandlePointsSelectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                     pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    
                }
            }
        }
    }
    
    func renderTanHandlePointsSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                tanHandlePointsSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                tanHandlePointsSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
}
