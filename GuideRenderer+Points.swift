//
//  GuideRenderer+JigglePoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/29/24.
//

import Foundation
import Metal
import simd

extension GuideRenderer {
    
    func getPointsCreatorModeFormat(creatorMode: CreatorMode) -> PointsCreatorModeFormat {
        let creatorModeFormat: PointsCreatorModeFormat
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
            creatorModeFormat = .invalid
        case .removeJigglePoint:
            creatorModeFormat = .invalid
        case .makeGuide:
            creatorModeFormat = .invalid
        case .drawGuide:
            creatorModeFormat = .invalid
        case .addGuidePoint:
            if isSelected {
                creatorModeFormat = .regular
            } else {
                creatorModeFormat = .alternative
            }
        case .removeGuidePoint:
            creatorModeFormat = .regular
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
        guard jiggle.isShowingGuidePoints else { return }
        
        if isFrozen {
            color_points_unmodified_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_points_unmodified_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            color_points_modified_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_points_modified_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            return
        }
        
        switch pointsCreatorModeFormat {
        case .invalid:
            //TODO: Don't harsh me bro
            print("FATAL ERROR: Should not render jiggle points in this case.")
            break
        case .regular:
            if isJiggleSelected {
                color_points_unmodified_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTG.fillRegSelUnm(index: weightDepthIndex,
                                                                            isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTG.fillRegSelMod(index: weightDepthIndex,
                                                                          isDarkMode: isDarkMode)
                color_points_selected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_selected_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
            } else {
                color_points_unmodified_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTG.fillRegUnsUnm(index: weightDepthIndex,
                                                                            isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTG.fillRegUnsMod(index: weightDepthIndex,
                                                                          isDarkMode: isDarkMode)
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
        guard let guide = guide else { return }
        guard jiggle.isShowingGuidePoints else { return }
        
        switch pointsCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && jiggle.isShowingGuidePointsBloom)
        
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
        
        for guideControlPointIndex in 0..<guide.guideControlPointCount {
            let guideControlPoint = guide.guideControlPoints[guideControlPointIndex]
            
            var renderCenterPoint = Math.Point(x: guideControlPoint.renderX,
                                               y: guideControlPoint.renderY)
            renderCenterPoint = projectionMatrix.process2d(point: renderCenterPoint,
                                                           screenWidth: graphics.width,
                                                           screenHeight: graphics.height)
            
            if guideControlPoint.renderPointSelected {
                if isBloom {
                    pointsSelectedBloomBuffer.add(translation: renderCenterPoint)
                }
                pointsSelectedStrokeBuffer.add(translation: renderCenterPoint)
                pointsSelectedFillBuffer.add(translation: renderCenterPoint)
            } else {
                
                if isBloom {
                    pointsUnselectedBloomBuffer.add(translation: renderCenterPoint)
                }
                
                if guideControlPoint.isManualTanHandleEnabled {
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
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    if jiggle.isShowingGuidePointsBloom {
                        pointsUnselectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderPointsUnselectedUnmodifiedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsUnselectedUnmodifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                          pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedUnmodifiedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsUnselectedUnmodifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedModifiedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsUnselectedModifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedModifiedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsUnselectedModifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    if jiggle.isShowingGuidePointsBloom {
                        pointsUnselectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderPointsUnselectedUnmodifiedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsUnselectedUnmodifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                          pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedUnmodifiedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsUnselectedUnmodifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedModifiedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsUnselectedModifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                        pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsUnselectedModifiedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsUnselectedModifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsSelectedBloomRegular(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    if jiggle.isShowingGuidePointsBloom {
                        pointsSelectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderPointsSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsSelectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if let jiggle = jiggle {
                    if jiggle.isShowingGuidePointsBloom {
                        pointsSelectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderPointsSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    func renderPointsSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                pointsSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
            }
        }
    }
    
    
}
