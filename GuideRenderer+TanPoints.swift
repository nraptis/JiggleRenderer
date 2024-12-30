//
//  GuideRenderer+JigglePointTanPoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/29/24.
//

import Foundation
import Metal
import simd

extension GuideRenderer {
    
    func pre_prepareTanPoints() {
        
        guard let jiggle = jiggle else { return }
        guard jiggle.isShowingGuideControlPointTanHandles else { return }
        
        if isFrozen {
            color_tan_points_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_tan_points_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            return
        }
        
        switch tansCreatorModeFormat {
        case .invalid:
            //TODO: Don't harsh me bro
            print("FATAL ERROR: Should not render tan points in this case.")
            break
        case .regular:
            if isJiggleSelected {
                color_tan_points_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTG.tanPointFillSel(index: weightDepthIndex,
                                                                       isDarkMode: isDarkMode)
                color_tan_points_selected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_tan_points_selected_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
            } else {
                color_tan_points_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTG.tanPointFillUns(index: weightDepthIndex,
                                                                       isDarkMode: isDarkMode)
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
        guard let guide = guide else { return }
        guard jiggle.isShowingGuideControlPointTanHandles else { return }
        
        switch tansCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && jiggle.isShowingGuideControlPointTanHandlesBloom)
        
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
        
        for guideControlPointIndex in 0..<guide.guideControlPointCount {
            let guideControlPoint = guide.guideControlPoints[guideControlPointIndex]
            
            var renderCenterPointIn = Math.Point(x: guideControlPoint.renderTanInX,
                                                 y: guideControlPoint.renderTanInY)
            renderCenterPointIn = projectionMatrix.process2d(point: renderCenterPointIn,
                                                             screenWidth: graphics.width,
                                                             screenHeight: graphics.height)
            
            var renderCenterPointOut = Math.Point(x: guideControlPoint.renderTanOutX,
                                                  y: guideControlPoint.renderTanOutY)
            renderCenterPointOut = projectionMatrix.process2d(point: renderCenterPointOut,
                                                              screenWidth: graphics.width,
                                                              screenHeight: graphics.height)
            
            if guideControlPoint.renderTanInSelected {
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
            
            if guideControlPoint.renderTanOutSelected {
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
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    if jiggle.isShowingGuideControlPointTanHandlesBloom {
                        tanHandlePointsUnselectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderTanHandlePointsUnselectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                tanHandlePointsUnselectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsUnselectedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                tanHandlePointsUnselectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsUnselectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    if jiggle.isShowingGuideControlPointTanHandlesBloom {
                        tanHandlePointsUnselectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderTanHandlePointsUnselectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                tanHandlePointsUnselectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsUnselectedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                tanHandlePointsUnselectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsSelectedBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    if jiggle.isShowingGuideControlPointTanHandlesBloom {
                        tanHandlePointsSelectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                         pipelineState: .spriteNodeIndexed3DAlphaBlending)
                        
                    }
                }
            }
        }
    }
    
    func renderTanHandlePointsSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                tanHandlePointsSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                tanHandlePointsSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsSelectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    if jiggle.isShowingGuideControlPointTanHandlesBloom {
                        tanHandlePointsSelectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                         pipelineState: .spriteNodeIndexed3DAlphaBlending)
                        
                    }
                }
            }
        }
    }
    
    func renderTanHandlePointsSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                tanHandlePointsSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderTanHandlePointsSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                tanHandlePointsSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
}
