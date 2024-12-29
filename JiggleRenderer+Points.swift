//
//  JiggleRenderer+JigglePoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/23/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    func getJigglePointsCreatorModeFormat(creatorMode: CreatorMode) -> JigglePointsCreatorModeFormat {
        let creatorModeFormat: JigglePointsCreatorModeFormat
        switch creatorMode {
        case .none:
            switch pointSelectionMode {
            case .tans:
                creatorModeFormat = .alternative
            default:
                creatorModeFormat = .regular
            }
        case .makeJiggle:
            creatorModeFormat = .invalid
        case .drawJiggle:
            creatorModeFormat = .invalid
        case .addJigglePoint:
            if isJiggleSelected {
                creatorModeFormat = .regular
            } else {
                creatorModeFormat = .alternative
            }
        case .removeJigglePoint:
            creatorModeFormat = .regular
        case .makeGuide:
            creatorModeFormat = .invalid
        case .drawGuide:
            creatorModeFormat = .invalid
        case .addGuidePoint:
            creatorModeFormat = .invalid
        case .removeGuidePoint:
            creatorModeFormat = .invalid
        case .moveJiggleCenter:
            creatorModeFormat = .alternative
        case .moveGuideCenter:
            creatorModeFormat = .alternative
        }
        return creatorModeFormat
    }
    
    // This is mainly just to compute the colors...
    // We only do it *ONCE* for both Precise and Regular...
    func pre_preparePoints() {
        
        guard let jiggle = jiggle else { return }
        guard jiggle.isShowingJigglePoints else { return }
        
        if isJiggleFrozen {
            color_points_unmodified_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_points_unmodified_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            color_points_modified_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_points_modified_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            return
        }
        
        switch jigglePointsCreatorModeFormat {
        case .invalid:
            //TODO: Don't harsh me bro
            print("FATAL ERROR: Should not render jiggle points in this case.")
            break
        case .regular:
            if isJiggleSelected {
                color_points_unmodified_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTJ.fillRegSelUnm(isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTJ.fillRegSelMod(isDarkMode: isDarkMode)
                color_points_selected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_selected_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
            } else {
                color_points_unmodified_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTJ.fillRegUnsUnm(isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTJ.fillRegUnsMod(isDarkMode: isDarkMode)
            }
        case .alternative:
            if isJiggleSelected {
                color_points_unmodified_unselected_stroke = RTJ.strokeAltSel(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTJ.fillAltSelUnm(isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeAltSel(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTJ.fillAltSelMod(isDarkMode: isDarkMode)
            } else {
                color_points_unmodified_unselected_stroke = RTJ.strokeAltUns(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTJ.fillAltUnsUnm(isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeAltUns(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTJ.fillAltUnsMod(isDarkMode: isDarkMode)
            }
        }
    }
    
    @inline(__always)
    func preparePoints(pointsUnselectedBloomBuffer: IndexedSpriteBuffer3D,
                             pointsUnselectedUnmodifiedStrokeBuffer: IndexedSpriteBuffer2D,
                             pointsUnselectedUnmodifiedFillBuffer: IndexedSpriteBuffer2D,
                             pointsUnselectedModifiedStrokeBuffer: IndexedSpriteBuffer2D,
                             pointsUnselectedModifiedFillBuffer: IndexedSpriteBuffer2D,
                             pointsSelectedBloomBuffer: IndexedSpriteBuffer3D,
                             pointsSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                             pointsSelectedFillBuffer: IndexedSpriteBuffer2D,
                             isPrecisePass: Bool) {
        
        guard let graphics = graphics else { return }
        guard let jiggle = jiggle else { return }
        guard jiggle.isShowingJigglePoints else { return }
        
        switch jigglePointsCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && jiggle.isShowingJigglePointsBloom)
        
        if isBloom {
            pointsUnselectedBloomBuffer.projectionMatrix = orthoMatrix
            pointsUnselectedBloomBuffer.rgba = color_bloom
        }
        
        pointsUnselectedUnmodifiedStrokeBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedUnmodifiedStrokeBuffer.rgba = color_points_unmodified_unselected_stroke
        
        pointsUnselectedUnmodifiedFillBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedUnmodifiedFillBuffer.rgba = color_points_unmodified_unselected_fill
        
        pointsUnselectedModifiedStrokeBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedModifiedStrokeBuffer.rgba = color_points_modified_unselected_stroke
        
        pointsUnselectedModifiedFillBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedModifiedFillBuffer.rgba = color_points_modified_unselected_fill
        
        if isBloom {
            pointsSelectedBloomBuffer.projectionMatrix = orthoMatrix
            pointsSelectedBloomBuffer.rgba = color_bloom
        }
        
        pointsSelectedStrokeBuffer.projectionMatrix = orthoMatrix
        pointsSelectedStrokeBuffer.rgba = color_points_selected_stroke
        
        pointsSelectedFillBuffer.projectionMatrix = orthoMatrix
        pointsSelectedFillBuffer.rgba = color_points_selected_fill
        
        for jiggleControlPointIndex in 0..<jiggle.jiggleControlPointCount {
            let jiggleControlPoint = jiggle.jiggleControlPoints[jiggleControlPointIndex]
            var renderCenterPoint = Math.Point(x: jiggleControlPoint.renderX,
                                               y: jiggleControlPoint.renderY)
            renderCenterPoint = projectionMatrix.process2d(point: renderCenterPoint,
                                                           screenWidth: graphics.width,
                                                           screenHeight: graphics.height)
            
            if jiggleControlPoint.renderPointSelected {
                if isBloom {
                    pointsSelectedBloomBuffer.add(translation: renderCenterPoint)
                }
                pointsSelectedStrokeBuffer.add(translation: renderCenterPoint)
                pointsSelectedFillBuffer.add(translation: renderCenterPoint)
            } else {
                
                if isBloom {
                    pointsUnselectedBloomBuffer.add(translation: renderCenterPoint)
                }
                
                if jiggleControlPoint.isManualTanHandleEnabled {
                    pointsUnselectedModifiedStrokeBuffer.add(translation: renderCenterPoint)
                    pointsUnselectedModifiedFillBuffer.add(translation: renderCenterPoint)
                } else {
                    pointsUnselectedUnmodifiedStrokeBuffer.add(translation: renderCenterPoint)
                    pointsUnselectedUnmodifiedFillBuffer.add(translation: renderCenterPoint)
                }
            }
        }
    }
    
    func renderPointsUnselectedBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJigglePointsBloom {
                    pointsUnselectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderPointsUnselectedUnmodifiedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsUnselectedUnmodifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                          pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedUnmodifiedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsUnselectedUnmodifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedModifiedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsUnselectedModifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedModifiedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsUnselectedModifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJigglePointsBloom {
                    pointsUnselectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderPointsUnselectedUnmodifiedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsUnselectedUnmodifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                          pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedUnmodifiedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsUnselectedUnmodifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedModifiedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsUnselectedModifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedModifiedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsUnselectedModifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsSelectedBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJigglePointsBloom {
                    pointsSelectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderPointsSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsSelectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJigglePointsBloom {
                    pointsSelectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderPointsSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                pointsSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
}
