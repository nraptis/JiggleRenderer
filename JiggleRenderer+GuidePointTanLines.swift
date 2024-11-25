//
//  JiggleRenderer+GuidePointTans.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 11/24/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    @MainActor
    @inline(__always)
    func prepareGuidePointTanLines(jiggle: Jiggle,
                                   projectionMatrix: matrix_float4x4,
                                   modelViewMatrix: matrix_float4x4,
                                   worldScaleStandard: Float,
                                   worldScalePrecise: Float,
                                   isPrecisePass: Bool,
                                   isBloomEnabled: Bool,
                                   isCreatorModeGuideCenters: Bool,
                                   isCreatorModeAddGuidePoints: Bool,
                                   isCreatorModeDeleteGuidePoints: Bool,
                                   guidePointSelectionModality: PointSelectionModality,
                                   jiggleColorPack: JiggleRenderColorPack,
                                   guidePointTanHandleLineUnmodifiedFillBuffer: IndexedShapeBuffer2DColored,
                                   guidePointTanHandleLineUnmodifiedStrokeBuffer: IndexedShapeBuffer2D,
                                   guidePointTanHandleLineModifiedFillBuffer: IndexedShapeBuffer2DColored,
                                   guidePointTanHandleLineModifiedStrokeBuffer: IndexedShapeBuffer2D,
                                   guidePointTanHandleLineActiveFillBuffer: IndexedShapeBuffer2D,
                                   guidePointTanHandleLineActiveStrokeBuffer: IndexedShapeBuffer2D) {
        
        guidePointTanHandleLineUnmodifiedFillBuffer.projectionMatrix = projectionMatrix
        guidePointTanHandleLineUnmodifiedFillBuffer.modelViewMatrix = modelViewMatrix
        
        guidePointTanHandleLineUnmodifiedStrokeBuffer.projectionMatrix = projectionMatrix
        guidePointTanHandleLineUnmodifiedStrokeBuffer.modelViewMatrix = modelViewMatrix
        guidePointTanHandleLineUnmodifiedStrokeBuffer.red = jiggleColorPack.strokeRed
        guidePointTanHandleLineUnmodifiedStrokeBuffer.green = jiggleColorPack.strokeGreen
        guidePointTanHandleLineUnmodifiedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        guidePointTanHandleLineModifiedFillBuffer.projectionMatrix = projectionMatrix
        guidePointTanHandleLineModifiedFillBuffer.modelViewMatrix = modelViewMatrix
        
        guidePointTanHandleLineModifiedStrokeBuffer.projectionMatrix = projectionMatrix
        guidePointTanHandleLineModifiedStrokeBuffer.modelViewMatrix = modelViewMatrix
        guidePointTanHandleLineModifiedStrokeBuffer.red = jiggleColorPack.strokeRed
        guidePointTanHandleLineModifiedStrokeBuffer.green = jiggleColorPack.strokeGreen
        guidePointTanHandleLineModifiedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        guidePointTanHandleLineActiveFillBuffer.projectionMatrix = projectionMatrix
        guidePointTanHandleLineActiveFillBuffer.modelViewMatrix = modelViewMatrix
        guidePointTanHandleLineActiveFillBuffer.red = jiggleColorPack.tanLineFillActiveRed
        guidePointTanHandleLineActiveFillBuffer.green = jiggleColorPack.tanLineFillActiveGreen
        guidePointTanHandleLineActiveFillBuffer.blue = jiggleColorPack.tanLineFillActiveBlue
        
        guidePointTanHandleLineActiveStrokeBuffer.projectionMatrix = projectionMatrix
        guidePointTanHandleLineActiveStrokeBuffer.modelViewMatrix = modelViewMatrix
        guidePointTanHandleLineActiveStrokeBuffer.red = jiggleColorPack.strokeRed
        guidePointTanHandleLineActiveStrokeBuffer.green = jiggleColorPack.strokeGreen
        guidePointTanHandleLineActiveStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        if isBloomEnabled && jiggle.isShowingGuideControlPointTanHandlesBloom && !isPrecisePass {
            
            guidePointTanHandleLineRegularBloomBuffer.projectionMatrix = projectionMatrix
            guidePointTanHandleLineRegularBloomBuffer.modelViewMatrix = modelViewMatrix
            guidePointTanHandleLineRegularBloomBuffer.red = jiggleColorPack.bloomRed
            guidePointTanHandleLineRegularBloomBuffer.green = jiggleColorPack.bloomGreen
            guidePointTanHandleLineRegularBloomBuffer.blue = jiggleColorPack.bloomBlue
        }
        
        let thicknessStroke: Float
        let thicknessFill: Float
        
        if isPrecisePass {
            thicknessStroke = jiggle.solidLineBufferStroke.thickness * worldScalePrecise * JiggleViewModel.lineScalePrecise
            thicknessFill = jiggle.solidLineBuffer.thickness * worldScalePrecise * JiggleViewModel.lineScalePrecise
        } else {
            thicknessStroke = jiggle.solidLineBufferStroke.thickness * worldScaleStandard * JiggleViewModel.lineScaleStandard
            thicknessFill = jiggle.solidLineBuffer.thickness * worldScaleStandard * JiggleViewModel.lineScaleStandard
        }
        
        for guideIndex in 0..<jiggle.guideCount {
            let guide = jiggle.guides[guideIndex]
            
            let guideColorPack = getGuideColorPack(jiggle: jiggle,
                                                   isJiggleSelected: isSelected,
                                                   isDarkModeEnabled: isDarkModeEnabled,
                                                   guide: guide,
                                                   guideIndex: guideIndex,
                                                   isCreatorModeGuideCenters: isCreatorModeGuideCenters,
                                                   isCreatorModeAddGuidePoints: isCreatorModeAddGuidePoints,
                                                   isCreatorModeDeleteGuidePoints: isCreatorModeDeleteGuidePoints,
                                                   guidePointSelectionModality: guidePointSelectionModality)
            
            for guideControlPointIndex in 0..<guide.guideControlPointCount {
                let guideControlPoint = guide.guideControlPoints[guideControlPointIndex]
                
                let tanHandleInX = guideControlPoint.renderTanInX
                let tanHandleInY = guideControlPoint.renderTanInY
                let tanHandleOutX = guideControlPoint.renderTanOutX
                let tanHandleOutY = guideControlPoint.renderTanOutY
                let tanNormalX = guideControlPoint.renderTanNormalX
                let tanNormalY = guideControlPoint.renderTanNormalY
                
                let strokeBox = getLineBox(x1: tanHandleInX, y1: tanHandleInY,
                                           x2: tanHandleOutX, y2: tanHandleOutY,
                                           normalX: tanNormalX, normalY: tanNormalY,
                                           thickness: thicknessStroke)
                let fillBox = getLineBox(x1: tanHandleInX, y1: tanHandleInY,
                                         x2: tanHandleOutX, y2: tanHandleOutY,
                                         normalX: tanNormalX, normalY: tanNormalY,
                                         thickness: thicknessFill)
                
                if guideControlPoint.renderSelected {
                    guidePointTanHandleLineActiveStrokeBuffer.add(cornerX1: strokeBox.x1, cornerY1: strokeBox.y1,
                                                                  cornerX2: strokeBox.x2, cornerY2: strokeBox.y2,
                                                                  cornerX3: strokeBox.x3, cornerY3: strokeBox.y3,
                                                                  cornerX4: strokeBox.x4, cornerY4: strokeBox.y4)
                    guidePointTanHandleLineActiveFillBuffer.add(cornerX1: fillBox.x1, cornerY1: fillBox.y1,
                                                                cornerX2: fillBox.x2, cornerY2: fillBox.y2,
                                                                cornerX3: fillBox.x3, cornerY3: fillBox.y3,
                                                                cornerX4: fillBox.x4, cornerY4: fillBox.y4)
                } else if guideControlPoint.isManualTanHandleEnabled {
                    guidePointTanHandleLineModifiedStrokeBuffer.add(cornerX1: strokeBox.x1, cornerY1: strokeBox.y1,
                                                                    cornerX2: strokeBox.x2, cornerY2: strokeBox.y2,
                                                                    cornerX3: strokeBox.x3, cornerY3: strokeBox.y3,
                                                                    cornerX4: strokeBox.x4, cornerY4: strokeBox.y4)
                    guidePointTanHandleLineModifiedFillBuffer.add(cornerX1: fillBox.x1, cornerY1: fillBox.y1,
                                                                  cornerX2: fillBox.x2, cornerY2: fillBox.y2,
                                                                  cornerX3: fillBox.x3, cornerY3: fillBox.y3,
                                                                  cornerX4: fillBox.x4, cornerY4: fillBox.y4,
                                                                  red: guideColorPack.tanLineFillModifiedRed,
                                                                  green: guideColorPack.tanLineFillModifiedGreen,
                                                                  blue: guideColorPack.tanLineFillModifiedBlue,
                                                                  alpha: 1.0)
                } else {
                    guidePointTanHandleLineUnmodifiedStrokeBuffer.add(cornerX1: strokeBox.x1, cornerY1: strokeBox.y1,
                                                                      cornerX2: strokeBox.x2, cornerY2: strokeBox.y2,
                                                                      cornerX3: strokeBox.x3, cornerY3: strokeBox.y3,
                                                                      cornerX4: strokeBox.x4, cornerY4: strokeBox.y4)
                    guidePointTanHandleLineUnmodifiedFillBuffer.add(cornerX1: fillBox.x1, cornerY1: fillBox.y1,
                                                                    cornerX2: fillBox.x2, cornerY2: fillBox.y2,
                                                                    cornerX3: fillBox.x3, cornerY3: fillBox.y3,
                                                                    cornerX4: fillBox.x4, cornerY4: fillBox.y4,
                                                                    red: guideColorPack.tanLineFillUnmodifiedRed,
                                                                    green: guideColorPack.tanLineFillUnmodifiedGreen,
                                                                    blue: guideColorPack.tanLineFillUnmodifiedBlue,
                                                                    alpha: 1.0)
                }
                
                if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                    
                    guidePointTanHandleLineRegularBloomBuffer.add(cornerX1: strokeBox.x1, cornerY1: strokeBox.y1,
                                                                  cornerX2: strokeBox.x2, cornerY2: strokeBox.y2,
                                                                  cornerX3: strokeBox.x3, cornerY3: strokeBox.y3,
                                                                  cornerX4: strokeBox.x4, cornerY4: strokeBox.y4)
                }
            }
        }
    }
    
    func renderGuidePointTanHandleLinesFill(renderEncoder: MTLRenderCommandEncoder,
                                             isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandleLineUnmodifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .shapeNodeColoredIndexed2DNoBlending)
                    guidePointTanHandleLineModifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .shapeNodeColoredIndexed2DNoBlending)
                    guidePointTanHandleLineActivePreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .shapeNodeIndexed2DNoBlending)
                } else {
                    guidePointTanHandleLineUnmodifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .shapeNodeColoredIndexed2DNoBlending)
                    guidePointTanHandleLineModifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .shapeNodeColoredIndexed2DNoBlending)
                    guidePointTanHandleLineActiveRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .shapeNodeIndexed2DNoBlending)
                }
            }
        }
    }

    func renderGuidePointTanHandleLinesStroke(renderEncoder: MTLRenderCommandEncoder,
                                               isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandleLineUnmodifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .shapeNodeIndexed2DNoBlending)
                    guidePointTanHandleLineModifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .shapeNodeIndexed2DNoBlending)
                    guidePointTanHandleLineActivePreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
                } else {
                    guidePointTanHandleLineUnmodifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .shapeNodeIndexed2DNoBlending)
                    guidePointTanHandleLineModifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .shapeNodeIndexed2DNoBlending)
                    guidePointTanHandleLineActiveRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
                }
            }
        }
    }

    func renderGuidePointTanHandleLinesBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuideControlPointTanHandlesBloom {
                    guidePointTanHandleLineRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .shapeNodeIndexed3DNoBlending)
                }
            }
        }
    }
}
