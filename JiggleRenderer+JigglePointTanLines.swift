//
//  JiggleRenderer+JigglePointTans.swift
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
    func prepareJigglePointTanLines(jiggle: Jiggle,
                                    projectionMatrix: matrix_float4x4,
                                    modelViewMatrix: matrix_float4x4,
                                    worldScaleStandard: Float,
                                    worldScalePrecise: Float,
                                    isPrecisePass: Bool,
                                    isBloomEnabled: Bool,
                                    jiggleColorPack: JiggleRenderColorPack,
                                    jigglePointTanHandleLineUnmodifiedFillBuffer: IndexedShapeBuffer2D,
                                    jigglePointTanHandleLineUnmodifiedStrokeBuffer: IndexedShapeBuffer2D,
                                    jigglePointTanHandleLineModifiedFillBuffer: IndexedShapeBuffer2D,
                                    jigglePointTanHandleLineModifiedStrokeBuffer: IndexedShapeBuffer2D,
                                    jigglePointTanHandleLineActiveFillBuffer: IndexedShapeBuffer2D,
                                    jigglePointTanHandleLineActiveStrokeBuffer: IndexedShapeBuffer2D) {
        
        jigglePointTanHandleLineUnmodifiedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandleLineUnmodifiedFillBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandleLineUnmodifiedFillBuffer.red = jiggleColorPack.tanLineFillUnmodifiedRed
        jigglePointTanHandleLineUnmodifiedFillBuffer.green = jiggleColorPack.tanLineFillUnmodifiedGreen
        jigglePointTanHandleLineUnmodifiedFillBuffer.blue = jiggleColorPack.tanLineFillUnmodifiedBlue
        
        jigglePointTanHandleLineUnmodifiedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandleLineUnmodifiedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandleLineUnmodifiedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointTanHandleLineUnmodifiedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointTanHandleLineUnmodifiedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointTanHandleLineModifiedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandleLineModifiedFillBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandleLineModifiedFillBuffer.red = jiggleColorPack.tanLineFillModifiedRed
        jigglePointTanHandleLineModifiedFillBuffer.green = jiggleColorPack.tanLineFillModifiedGreen
        jigglePointTanHandleLineModifiedFillBuffer.blue = jiggleColorPack.tanLineFillModifiedBlue
        
        jigglePointTanHandleLineModifiedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandleLineModifiedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandleLineModifiedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointTanHandleLineModifiedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointTanHandleLineModifiedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointTanHandleLineActiveFillBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandleLineActiveFillBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandleLineActiveFillBuffer.red = jiggleColorPack.tanLineFillActiveRed
        jigglePointTanHandleLineActiveFillBuffer.green = jiggleColorPack.tanLineFillActiveGreen
        jigglePointTanHandleLineActiveFillBuffer.blue = jiggleColorPack.tanLineFillActiveBlue
        
        jigglePointTanHandleLineActiveStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandleLineActiveStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandleLineActiveStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointTanHandleLineActiveStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointTanHandleLineActiveStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        if jiggle.isShowingJiggleControlPointTanHandlesBloom && isBloomEnabled && !isPrecisePass {
            jigglePointTanHandleLineRegularBloomBuffer.projectionMatrix = projectionMatrix
            jigglePointTanHandleLineRegularBloomBuffer.modelViewMatrix = modelViewMatrix
            jigglePointTanHandleLineRegularBloomBuffer.red = jiggleColorPack.bloomRed
            jigglePointTanHandleLineRegularBloomBuffer.green = jiggleColorPack.bloomGreen
            jigglePointTanHandleLineRegularBloomBuffer.blue = jiggleColorPack.bloomBlue
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
        
        
        for jiggleControlPointIndex in 0..<jiggle.jiggleControlPointCount {
            let jiggleControlPoint = jiggle.jiggleControlPoints[jiggleControlPointIndex]
            
            
            let tanHandleInX = jiggleControlPoint.renderTanInX
            let tanHandleInY = jiggleControlPoint.renderTanInY
            let tanHandleOutX = jiggleControlPoint.renderTanOutX
            let tanHandleOutY = jiggleControlPoint.renderTanOutY
            let tanNormalX = jiggleControlPoint.renderTanNormalX
            let tanNormalY = jiggleControlPoint.renderTanNormalY
            
            let strokeBox = getLineBox(x1: tanHandleInX, y1: tanHandleInY,
                                       x2: tanHandleOutX, y2: tanHandleOutY,
                                       normalX: tanNormalX, normalY: tanNormalY,
                                       thickness: thicknessStroke)
            let fillBox = getLineBox(x1: tanHandleInX, y1: tanHandleInY,
                                     x2: tanHandleOutX, y2: tanHandleOutY,
                                     normalX: tanNormalX, normalY: tanNormalY,
                                     thickness: thicknessFill)
            
            
            
            if jiggleControlPoint.renderSelected {
                jigglePointTanHandleLineActiveStrokeBuffer.add(cornerX1: strokeBox.x1, cornerY1: strokeBox.y1,
                                                               cornerX2: strokeBox.x2, cornerY2: strokeBox.y2,
                                                               cornerX3: strokeBox.x3, cornerY3: strokeBox.y3,
                                                               cornerX4: strokeBox.x4, cornerY4: strokeBox.y4)
                jigglePointTanHandleLineActiveFillBuffer.add(cornerX1: fillBox.x1, cornerY1: fillBox.y1,
                                                             cornerX2: fillBox.x2, cornerY2: fillBox.y2,
                                                             cornerX3: fillBox.x3, cornerY3: fillBox.y3,
                                                             cornerX4: fillBox.x4, cornerY4: fillBox.y4)
            } else if jiggleControlPoint.isManualTanHandleEnabled {
                jigglePointTanHandleLineModifiedStrokeBuffer.add(cornerX1: strokeBox.x1, cornerY1: strokeBox.y1,
                                                                 cornerX2: strokeBox.x2, cornerY2: strokeBox.y2,
                                                                 cornerX3: strokeBox.x3, cornerY3: strokeBox.y3,
                                                                 cornerX4: strokeBox.x4, cornerY4: strokeBox.y4)
                jigglePointTanHandleLineModifiedFillBuffer.add(cornerX1: fillBox.x1, cornerY1: fillBox.y1,
                                                               cornerX2: fillBox.x2, cornerY2: fillBox.y2,
                                                               cornerX3: fillBox.x3, cornerY3: fillBox.y3,
                                                               cornerX4: fillBox.x4, cornerY4: fillBox.y4)
            } else {
                jigglePointTanHandleLineUnmodifiedStrokeBuffer.add(cornerX1: strokeBox.x1, cornerY1: strokeBox.y1,
                                                                   cornerX2: strokeBox.x2, cornerY2: strokeBox.y2,
                                                                   cornerX3: strokeBox.x3, cornerY3: strokeBox.y3,
                                                                   cornerX4: strokeBox.x4, cornerY4: strokeBox.y4)
                jigglePointTanHandleLineUnmodifiedFillBuffer.add(cornerX1: fillBox.x1, cornerY1: fillBox.y1,
                                                                 cornerX2: fillBox.x2, cornerY2: fillBox.y2,
                                                                 cornerX3: fillBox.x3, cornerY3: fillBox.y3,
                                                                 cornerX4: fillBox.x4, cornerY4: fillBox.y4)
            }
            
            if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                
                jigglePointTanHandleLineRegularBloomBuffer.add(cornerX1: strokeBox.x1, cornerY1: strokeBox.y1,
                                                            cornerX2: strokeBox.x2, cornerY2: strokeBox.y2,
                                                            cornerX3: strokeBox.x3, cornerY3: strokeBox.y3,
                                                            cornerX4: strokeBox.x4, cornerY4: strokeBox.y4)
            }
        }
    }


    func renderJigglePointTanHandleLinesFill(renderEncoder: MTLRenderCommandEncoder,
                                             isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandleLineUnmodifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .shapeNodeIndexed2DNoBlending)
                    jigglePointTanHandleLineModifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
                    jigglePointTanHandleLineActivePreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .shapeNodeIndexed2DNoBlending)
                } else {
                    jigglePointTanHandleLineUnmodifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .shapeNodeIndexed2DNoBlending)
                    jigglePointTanHandleLineModifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
                    jigglePointTanHandleLineActiveRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                                           pipelineState: .shapeNodeIndexed2DNoBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandleLinesStroke(renderEncoder: MTLRenderCommandEncoder,
                                               isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandleLineUnmodifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .shapeNodeIndexed2DNoBlending)
                    jigglePointTanHandleLineModifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .shapeNodeIndexed2DNoBlending)
                    jigglePointTanHandleLineActivePreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
                } else {
                    jigglePointTanHandleLineUnmodifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .shapeNodeIndexed2DNoBlending)
                    jigglePointTanHandleLineModifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .shapeNodeIndexed2DNoBlending)
                    jigglePointTanHandleLineActiveRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .shapeNodeIndexed2DNoBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandleLinesBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleControlPointTanHandlesBloom {
                    jigglePointTanHandleLineRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .shapeNodeIndexed3DNoBlending)
                }
            }
        }
    }
    
}
