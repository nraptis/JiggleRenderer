//
//  GuideRenderer.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/29/24.
//

import Foundation
import Metal
import simd

class GuideRenderer {
    
    static let DIRTY_TRIANGLES_SHOW_DIRTY = true
    
    weak var jiggleEngine: JiggleEngine?
    weak var graphics: Graphics?
    weak var jiggle: Jiggle?
    weak var guide: Guide?
    var weightDepthIndex = -1
    
    var color_bloom = RGBA()
    
    var color_points_unmodified_unselected_stroke = RGBA()
    var color_points_unmodified_unselected_fill = RGBA()
    var color_points_modified_unselected_stroke = RGBA()
    var color_points_modified_unselected_fill = RGBA()
    var color_points_selected_stroke = RGBA()
    var color_points_selected_fill = RGBA()
    
    var color_tan_lines_unselected_stroke = RGBA()
    var color_tan_lines_unselected_fill = RGBA()
    var color_tan_lines_selected_stroke = RGBA()
    var color_tan_lines_selected_fill = RGBA()
    
    var color_tan_points_unselected_stroke = RGBA()
    var color_tan_points_unselected_fill = RGBA()
    var color_tan_points_selected_stroke = RGBA()
    var color_tan_points_selected_fill = RGBA()
    
    var pointsCreatorModeFormat = PointsCreatorModeFormat.invalid
    var tansCreatorModeFormat = TansCreatorModeFormat.invalid
    
    var isJiggleSelected = false
    var isJiggleFrozen = false
    var isSelected = false
    
    var isGuideSelected = false
    var isGuideFrozen = false
    var isFrozen = false
    
    
    
    var isDarkMode = false
    var isStereoscopicMode = false
    var isBloomMode = false
    
    var isRenderingPrecise = false
    
    var orthoMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
    
    var worldScale = Float(1.0)
    
    var inverseRotation = Float(1.0)
    
    var weightMode = WeightMode.guides
    
    var selectedTanType = TanTypeOrNone.none
    var pointSelectionMode = PointSelectionModality.points
    
    var lineWidthFillBase = Float(8.0)
    var lineWidthStrokeBase = Float(12.0)
    
    
    
    // Points Unselected:
    let pointsUnselectedRegularBloomBuffer = IndexedSpriteBuffer3D()
    let pointsUnselectedUnmodifiedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedUnmodifiedRegularFillBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedModifiedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedModifiedRegularFillBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedPreciseBloomBuffer = IndexedSpriteBuffer3D()
    let pointsUnselectedUnmodifiedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedUnmodifiedPreciseFillBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedModifiedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedModifiedPreciseFillBuffer = IndexedSpriteBuffer2D()
    
    // Points Selected:
    let pointsSelectedRegularBloomBuffer = IndexedSpriteBuffer3D()
    let pointsSelectedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsSelectedRegularFillBuffer = IndexedSpriteBuffer2D()
    let pointsSelectedPreciseBloomBuffer = IndexedSpriteBuffer3D()
    let pointsSelectedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsSelectedPreciseFillBuffer = IndexedSpriteBuffer2D()
    
    
    // Tan Lines Unselected:
    let tanHandleLinesRegularBloomBuffer = IndexedShapeBuffer3D()
    let tanHandleLinesUnselectedRegularStrokeBuffer = IndexedShapeBuffer2D()
    let tanHandleLinesUnselectedRegularFillBuffer = IndexedShapeBuffer2D()
    
    let tanHandleLinesPreciseBloomBuffer = IndexedShapeBuffer3D()
    let tanHandleLinesUnselectedPreciseStrokeBuffer = IndexedShapeBuffer2D()
    let tanHandleLinesUnselectedPreciseFillBuffer = IndexedShapeBuffer2D()
    
    // Tan Lines Selected:
    let tanHandleLinesSelectedRegularStrokeBuffer = IndexedShapeBuffer2D()
    let tanHandleLinesSelectedRegularFillBuffer = IndexedShapeBuffer2D()
    
    let tanHandleLinesSelectedPreciseStrokeBuffer = IndexedShapeBuffer2D()
    let tanHandleLinesSelectedPreciseFillBuffer = IndexedShapeBuffer2D()
    
    
    // Tan Points Unselected:
    let tanHandlePointsUnselectedRegularBloomBuffer = IndexedSpriteBuffer3D()
    let tanHandlePointsUnselectedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let tanHandlePointsUnselectedRegularFillBuffer = IndexedSpriteBuffer2D()
    
    let tanHandlePointsUnselectedPreciseBloomBuffer = IndexedSpriteBuffer3D()
    let tanHandlePointsUnselectedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let tanHandlePointsUnselectedPreciseFillBuffer = IndexedSpriteBuffer2D()
    
    // Tan Points Selected:
    let tanHandlePointsSelectedRegularBloomBuffer = IndexedSpriteBuffer3D()
    let tanHandlePointsSelectedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let tanHandlePointsSelectedRegularFillBuffer = IndexedSpriteBuffer2D()
    
    let tanHandlePointsSelectedPreciseBloomBuffer = IndexedSpriteBuffer3D()
    let tanHandlePointsSelectedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let tanHandlePointsSelectedPreciseFillBuffer = IndexedSpriteBuffer2D()
    
    var isLoaded = false
    
    init(graphics: Graphics,
         jiggleEngine: JiggleEngine) {
        self.graphics = graphics
        self.jiggleEngine = jiggleEngine
    }
    
    func load() {
        
        if isLoaded {
            return
        }
        
        guard let jiggleEngine = jiggleEngine else {
            print("FATAL: Expected Jiggle Engine")
            return
        }
        guard let graphics = graphics else {
            print("FATAL: Expected Graphics")
            return
        }
        
        // Points Unselected:
        pointsUnselectedRegularBloomBuffer.load_t(graphics: graphics)
        pointsUnselectedUnmodifiedRegularStrokeBuffer.load_t(graphics: graphics)
        pointsUnselectedUnmodifiedRegularFillBuffer.load_t(graphics: graphics)
        pointsUnselectedModifiedRegularStrokeBuffer.load_t(graphics: graphics)
        pointsUnselectedModifiedRegularFillBuffer.load_t(graphics: graphics)
        
        pointsUnselectedPreciseBloomBuffer.load_t(graphics: graphics)
        pointsUnselectedUnmodifiedPreciseStrokeBuffer.load_t(graphics: graphics)
        pointsUnselectedUnmodifiedPreciseFillBuffer.load_t(graphics: graphics)
        pointsUnselectedModifiedPreciseStrokeBuffer.load_t(graphics: graphics)
        pointsUnselectedModifiedPreciseFillBuffer.load_t(graphics: graphics)
        
        // Points Selected:
        pointsSelectedRegularBloomBuffer.load_t(graphics: graphics)
        pointsSelectedRegularStrokeBuffer.load_t(graphics: graphics)
        pointsSelectedRegularFillBuffer.load_t(graphics: graphics)
        pointsSelectedPreciseBloomBuffer.load_t(graphics: graphics)
        pointsSelectedPreciseStrokeBuffer.load_t(graphics: graphics)
        pointsSelectedPreciseFillBuffer.load_t(graphics: graphics)
        
        
        
        // Tan Lines Unselected:
        tanHandleLinesRegularBloomBuffer.load_t_n(graphics: graphics)
        tanHandleLinesUnselectedRegularStrokeBuffer.load_t_n(graphics: graphics)
        tanHandleLinesUnselectedRegularFillBuffer.load_t_n(graphics: graphics)
        
        tanHandleLinesPreciseBloomBuffer.load_t_n(graphics: graphics)
        tanHandleLinesUnselectedPreciseStrokeBuffer.load_t_n(graphics: graphics)
        tanHandleLinesUnselectedPreciseFillBuffer.load_t_n(graphics: graphics)
        
        // Tan Lines Selected:
        tanHandleLinesSelectedRegularStrokeBuffer.load_t_n(graphics: graphics)
        tanHandleLinesSelectedRegularFillBuffer.load_t_n(graphics: graphics)
        
        tanHandleLinesSelectedPreciseStrokeBuffer.load_t_n(graphics: graphics)
        tanHandleLinesSelectedPreciseFillBuffer.load_t_n(graphics: graphics)
        
        
        
        // Tan Points Unselected:
        tanHandlePointsUnselectedRegularBloomBuffer.load_t(graphics: graphics)
        tanHandlePointsUnselectedRegularStrokeBuffer.load_t(graphics: graphics)
        tanHandlePointsUnselectedRegularFillBuffer.load_t(graphics: graphics)
        
        tanHandlePointsUnselectedPreciseBloomBuffer.load_t(graphics: graphics)
        tanHandlePointsUnselectedPreciseStrokeBuffer.load_t(graphics: graphics)
        tanHandlePointsUnselectedPreciseFillBuffer.load_t(graphics: graphics)
        
        // Tan Points Selected:
        tanHandlePointsSelectedRegularBloomBuffer.load_t(graphics: graphics)
        tanHandlePointsSelectedRegularStrokeBuffer.load_t(graphics: graphics)
        tanHandlePointsSelectedRegularFillBuffer.load_t(graphics: graphics)
        
        tanHandlePointsSelectedPreciseBloomBuffer.load_t(graphics: graphics)
        tanHandlePointsSelectedPreciseStrokeBuffer.load_t(graphics: graphics)
        tanHandlePointsSelectedPreciseFillBuffer.load_t(graphics: graphics)
        
        
        isLoaded = true
        
        refreshLines()
        refreshPoints()
    }
    
    func reset() {
        
        // Points Unselected:
        pointsUnselectedRegularBloomBuffer.reset()
        pointsUnselectedUnmodifiedRegularStrokeBuffer.reset()
        pointsUnselectedUnmodifiedRegularFillBuffer.reset()
        pointsUnselectedModifiedRegularStrokeBuffer.reset()
        pointsUnselectedModifiedRegularFillBuffer.reset()
        
        pointsUnselectedPreciseBloomBuffer.reset()
        pointsUnselectedUnmodifiedPreciseStrokeBuffer.reset()
        pointsUnselectedUnmodifiedPreciseFillBuffer.reset()
        pointsUnselectedModifiedPreciseStrokeBuffer.reset()
        pointsUnselectedModifiedPreciseFillBuffer.reset()
        
        // Points Selected:
        pointsSelectedRegularBloomBuffer.reset()
        pointsSelectedRegularStrokeBuffer.reset()
        pointsSelectedRegularFillBuffer.reset()
        pointsSelectedPreciseBloomBuffer.reset()
        pointsSelectedPreciseStrokeBuffer.reset()
        pointsSelectedPreciseFillBuffer.reset()
        
        
        // Tan Lines Unselected:
        tanHandleLinesRegularBloomBuffer.reset()
        tanHandleLinesUnselectedRegularStrokeBuffer.reset()
        tanHandleLinesUnselectedRegularFillBuffer.reset()
        
        tanHandleLinesPreciseBloomBuffer.reset()
        tanHandleLinesUnselectedPreciseStrokeBuffer.reset()
        tanHandleLinesUnselectedPreciseFillBuffer.reset()
        
        // Tan Lines Selected:
        tanHandleLinesSelectedRegularStrokeBuffer.reset()
        tanHandleLinesSelectedRegularFillBuffer.reset()
        
        tanHandleLinesSelectedPreciseStrokeBuffer.reset()
        tanHandleLinesSelectedPreciseFillBuffer.reset()
        
        
        // Tan Points Unselected:
        tanHandlePointsUnselectedRegularBloomBuffer.reset()
        tanHandlePointsUnselectedRegularStrokeBuffer.reset()
        tanHandlePointsUnselectedRegularFillBuffer.reset()
        
        tanHandlePointsUnselectedPreciseBloomBuffer.reset()
        tanHandlePointsUnselectedPreciseStrokeBuffer.reset()
        tanHandlePointsUnselectedPreciseFillBuffer.reset()
        
        // Tan Points Selected:
        tanHandlePointsSelectedRegularBloomBuffer.reset()
        tanHandlePointsSelectedRegularStrokeBuffer.reset()
        tanHandlePointsSelectedRegularFillBuffer.reset()
        
        tanHandlePointsSelectedPreciseBloomBuffer.reset()
        tanHandlePointsSelectedPreciseStrokeBuffer.reset()
        tanHandlePointsSelectedPreciseFillBuffer.reset()
    }
    
    /*
    func pre_prepare(jiggle: Jiggle,
                     guide: Guide,
                     guideIndex: Int,
                     isSelected: Bool,
                     isGuideSelected: Bool,
                     isStereoscopicEnabled: Bool,
                     projectionMatrix: matrix_float4x4,
                     modelViewMatrix: matrix_float4x4,
                     isCreatorModeJiggleCenters: Bool,
                     isCreatorModeAddJigglePoints: Bool,
                     isCreatorModeGuideCenters: Bool,
                     isCreatorModeAddGuidePoints: Bool,
                     isCreatorModeDeleteGuidePoints: Bool,
                     weightMode: WeightMode,
                     selectedJigglePointTanType: TanType,
                     selectedGuidePointTanType: TanType) {
        
        self.jiggle = jiggle
        self.guide = guide
        self.isSelected = isSelected
        self.isDarkMode = jiggle.isShowingDarkMode
        
        // Anything we can compute once, we will do outside of the 2 renderings...
        if jiggle.isShowingGuidePoints {
            

            guide.renderSelected = isGuideSelected
            
            let isGuideFrozen = (jiggle.isFrozen == true) ||
            (guide.isFrozen == true) ||
            (isCreatorModeGuideCenters == true) ||
            ((isCreatorModeAddGuidePoints == true) && (guide.renderSelected == false))
            
            guide.renderFrozen = isGuideFrozen
            
            for guideControlPointIndex in 0..<guide.guideControlPointCount {
                let guideControlPoint = guide.guideControlPoints[guideControlPointIndex]
                
                var renderPoint = guideControlPoint.point
                renderPoint = guide.transformPoint(point: renderPoint)
                renderPoint = jiggle.transformPoint(point: renderPoint)
                
                var isPointSelected = false
                if isGuideSelected {
                    if guide.selectedGuideControlPointIndex == guideControlPointIndex {
                        if weightMode == .points {
                            isPointSelected = true
                        }
                    }
                }
                
                guideControlPoint.renderX = renderPoint.x
                guideControlPoint.renderY = renderPoint.y
                guideControlPoint.renderSelected = isPointSelected
            }
            
        }
    */
        
    func pre_prepare(jiggle: Jiggle,
                     isJiggleSelected: Bool,
                     guide: Guide,
                     weightDepthIndex: Int,
                     isGuideSelected: Bool,
                     creatorMode: CreatorMode,
                     weightMode: WeightMode,
                     selectedTanType: TanTypeOrNone,
                     pointSelectionMode: PointSelectionModality,
                     isBloomMode: Bool) {
        
        guard let graphics = graphics else { return }
        
        orthoMatrix.ortho(width: graphics.width,
                          height: graphics.height)
        
        self.jiggle = jiggle
        self.isJiggleSelected = isJiggleSelected
        self.guide = guide
        self.weightDepthIndex = weightDepthIndex
        self.isGuideSelected = isGuideSelected
        self.isJiggleFrozen = jiggle.isFrozen
        self.isGuideFrozen = guide.isFrozen
        self.isDarkMode = jiggle.isShowingDarkMode
        self.isStereoscopicMode = jiggle.isShowingMeshViewStereoscopic
        self.weightMode = weightMode
        self.selectedTanType = selectedTanType
        self.pointSelectionMode = pointSelectionMode
        self.isBloomMode = isBloomMode
        isSelected = (isJiggleSelected && isGuideSelected)
        isFrozen = (isJiggleFrozen || isGuideFrozen)
        
        pointsCreatorModeFormat = getPointsCreatorModeFormat(creatorMode: creatorMode)
        tansCreatorModeFormat = getTansCreatorModeFormat(creatorMode: creatorMode)
        
        
        
        pre_preparePoints()
        pre_prepareTanLines()
        pre_prepareTanPoints()
        
        color_bloom = RTJ.bloom(isDarkMode: isDarkMode)
        
        
        // Anything we can compute once, we will do outside of the 2 renderings...
        if jiggle.isShowingGuidePoints {
            let isAbleToShowSelectedPoint: Bool
            let isAbleToShowSelectedTan: Bool
            
            if isFrozen {
                isAbleToShowSelectedPoint = false
                isAbleToShowSelectedTan = false
            } else {
                switch selectedTanType {
                case .none:
                    switch pointsCreatorModeFormat {
                    case .invalid:
                        isAbleToShowSelectedPoint = false
                    case .regular:
                        isAbleToShowSelectedPoint = true
                    case .alternative:
                        isAbleToShowSelectedPoint = false
                    }
                    isAbleToShowSelectedTan = false
                case .in:
                    isAbleToShowSelectedPoint = false
                    switch tansCreatorModeFormat {
                    case .invalid:
                        isAbleToShowSelectedTan = false
                    case .regular:
                        isAbleToShowSelectedTan = true
                    case .alternative:
                        isAbleToShowSelectedTan = false
                    }
                case .out:
                    isAbleToShowSelectedPoint = false
                    switch tansCreatorModeFormat {
                    case .invalid:
                        isAbleToShowSelectedTan = false
                    case .regular:
                        isAbleToShowSelectedTan = true
                    case .alternative:
                        isAbleToShowSelectedTan = false
                    }
                }
            }
            
            for guideControlPointIndex in 0..<guide.guideControlPointCount {
                let guideControlPoint = guide.guideControlPoints[guideControlPointIndex]
                
                var renderPoint = guideControlPoint.point
                renderPoint = guide.transformPoint(point: renderPoint)
                renderPoint = jiggle.transformPoint(point: renderPoint)
                
                let isPointSelected: Bool
                if isAbleToShowSelectedPoint == true {
                    if isSelected {
                        if guide.selectedGuideControlPointIndex == guideControlPointIndex {
                            isPointSelected = true
                        } else {
                            isPointSelected = false
                        }
                    } else {
                        isPointSelected = false
                    }
                } else {
                    isPointSelected = false
                }
                
                guideControlPoint.renderX = renderPoint.x
                guideControlPoint.renderY = renderPoint.y
                guideControlPoint.renderPointSelected = isPointSelected
                
                var isTanInSelected = false
                var isTanOutSelected = false
                if isAbleToShowSelectedTan {
                    if isSelected {
                        if guide.selectedGuideControlPointIndex == guideControlPointIndex {
                            switch selectedTanType {
                            case .none:
                                break
                            case .in:
                                isTanInSelected = true
                            case .out:
                                isTanOutSelected = true
                            }
                        }
                    }
                }
                
                guideControlPoint.renderTanInSelected = isTanInSelected
                guideControlPoint.renderTanOutSelected = isTanOutSelected
                
            }
        }
        
        // Anything we can compute once, we will do outside of the 2 renderings...
        if jiggle.isShowingGuideControlPointTanHandles {
            for guideControlPointIndex in 0..<guide.guideControlPointCount {
                let guideControlPoint = guide.guideControlPoints[guideControlPointIndex]
                
                var tanHandles = guideControlPoint.getTanHandles()
                tanHandles = guide.transformTanHandles(tanHandles)
                tanHandles = jiggle.transformTanHandles(tanHandles)
                
                
                guideControlPoint.renderTanInX = tanHandles.inX
                guideControlPoint.renderTanInY = tanHandles.inY
                
                guideControlPoint.renderTanOutX = tanHandles.outX
                guideControlPoint.renderTanOutY = tanHandles.outY
                
                var tanNormalsIn = guideControlPoint.getTanHandleNormalsIn()
                tanNormalsIn = guide.transformPointRotationOnly(vector: tanNormalsIn)
                tanNormalsIn = jiggle.transformPointRotationOnly(vector: tanNormalsIn)
                guideControlPoint.renderTanNormalInX = tanNormalsIn.x
                guideControlPoint.renderTanNormalInY = tanNormalsIn.y
                
                var tanNormalsOut = guideControlPoint.getTanHandleNormalsOut()
                tanNormalsOut = guide.transformPointRotationOnly(vector: tanNormalsOut)
                tanNormalsOut = jiggle.transformPointRotationOnly(vector: tanNormalsOut)
                guideControlPoint.renderTanNormalOutX = tanNormalsOut.x
                guideControlPoint.renderTanNormalOutY = tanNormalsOut.y
            }
        }
    }
    
    // We load up all the buffers for the render, this does not render anything...
    func prepare(jiggle: Jiggle,
                 guide: Guide,
                 projectionMatrix: matrix_float4x4,
                 isPrecisePass: Bool,
                 isRenderingPrecise: Bool) {
        
        guard let jiggleEngine = jiggleEngine else {
            return
        }
        guard let jiggleScene = jiggleEngine.jiggleScene else {
            return
        }
        
        self.projectionMatrix = projectionMatrix
        
        self.isRenderingPrecise = isRenderingPrecise
        
        if isPrecisePass {
            worldScale = jiggleScene.getWorldScalePrecise()
            inverseRotation = (-jiggleScene.normalBoxRotation)
        } else {
            worldScale = jiggleScene.getWorldScaleStandard(isPrecise: isRenderingPrecise)
            inverseRotation = (-jiggleScene.preciseMagnifiedRotation)
        }
        
        let pointsUnselectedBloomBuffer: IndexedSpriteBuffer3D
        let pointsUnselectedUnmodifiedStrokeBuffer: IndexedSpriteBuffer2D
        let pointsUnselectedUnmodifiedFillBuffer: IndexedSpriteBuffer2D
        let pointsUnselectedModifiedStrokeBuffer: IndexedSpriteBuffer2D
        let pointsUnselectedModifiedFillBuffer: IndexedSpriteBuffer2D
        
        let pointsSelectedBloomBuffer: IndexedSpriteBuffer3D
        let pointsSelectedStrokeBuffer: IndexedSpriteBuffer2D
        let pointsSelectedFillBuffer: IndexedSpriteBuffer2D
        
        let tanHandleLinesBloomBuffer: IndexedShapeBuffer3D
        let tanHandleLinesUnselectedStrokeBuffer: IndexedShapeBuffer2D
        let tanHandleLinesUnselectedFillBuffer: IndexedShapeBuffer2D
        let tanHandleLinesSelectedStrokeBuffer: IndexedShapeBuffer2D
        let tanHandleLinesSelectedFillBuffer: IndexedShapeBuffer2D
        
        let tanHandlePointsUnselectedBloomBuffer: IndexedSpriteBuffer3D
        let tanHandlePointsUnselectedStrokeBuffer: IndexedSpriteBuffer2D
        let tanHandlePointsUnselectedFillBuffer: IndexedSpriteBuffer2D
        let tanHandlePointsSelectedBloomBuffer: IndexedSpriteBuffer3D
        let tanHandlePointsSelectedStrokeBuffer: IndexedSpriteBuffer2D
        let tanHandlePointsSelectedFillBuffer: IndexedSpriteBuffer2D
        
        if isPrecisePass {
            
            pointsUnselectedBloomBuffer = pointsUnselectedPreciseBloomBuffer
            pointsUnselectedUnmodifiedStrokeBuffer = pointsUnselectedUnmodifiedPreciseStrokeBuffer
            pointsUnselectedUnmodifiedFillBuffer = pointsUnselectedUnmodifiedPreciseFillBuffer
            pointsUnselectedModifiedStrokeBuffer = pointsUnselectedModifiedPreciseStrokeBuffer
            pointsUnselectedModifiedFillBuffer = pointsUnselectedModifiedPreciseFillBuffer
            
            pointsSelectedBloomBuffer = pointsSelectedPreciseBloomBuffer
            pointsSelectedStrokeBuffer = pointsSelectedPreciseStrokeBuffer
            pointsSelectedFillBuffer = pointsSelectedPreciseFillBuffer
            
            tanHandleLinesBloomBuffer = tanHandleLinesPreciseBloomBuffer
            tanHandleLinesUnselectedStrokeBuffer = tanHandleLinesUnselectedPreciseStrokeBuffer
            tanHandleLinesUnselectedFillBuffer = tanHandleLinesUnselectedPreciseFillBuffer
            tanHandleLinesSelectedStrokeBuffer = tanHandleLinesSelectedPreciseStrokeBuffer
            tanHandleLinesSelectedFillBuffer = tanHandleLinesSelectedPreciseFillBuffer
            
            tanHandlePointsUnselectedBloomBuffer = tanHandlePointsUnselectedPreciseBloomBuffer
            tanHandlePointsUnselectedStrokeBuffer = tanHandlePointsUnselectedPreciseStrokeBuffer
            tanHandlePointsUnselectedFillBuffer = tanHandlePointsUnselectedPreciseFillBuffer
            
            tanHandlePointsSelectedBloomBuffer = tanHandlePointsSelectedPreciseBloomBuffer
            tanHandlePointsSelectedStrokeBuffer = tanHandlePointsSelectedPreciseStrokeBuffer
            tanHandlePointsSelectedFillBuffer = tanHandlePointsSelectedPreciseFillBuffer
            
        } else {
            
            pointsUnselectedBloomBuffer = pointsUnselectedRegularBloomBuffer
            pointsUnselectedUnmodifiedStrokeBuffer = pointsUnselectedUnmodifiedRegularStrokeBuffer
            pointsUnselectedUnmodifiedFillBuffer = pointsUnselectedUnmodifiedRegularFillBuffer
            pointsUnselectedModifiedStrokeBuffer = pointsUnselectedModifiedRegularStrokeBuffer
            pointsUnselectedModifiedFillBuffer = pointsUnselectedModifiedRegularFillBuffer
            
            pointsSelectedBloomBuffer = pointsSelectedRegularBloomBuffer
            pointsSelectedStrokeBuffer = pointsSelectedRegularStrokeBuffer
            pointsSelectedFillBuffer = pointsSelectedRegularFillBuffer
            
            tanHandleLinesBloomBuffer = tanHandleLinesRegularBloomBuffer
            tanHandleLinesUnselectedStrokeBuffer = tanHandleLinesUnselectedRegularStrokeBuffer
            tanHandleLinesUnselectedFillBuffer = tanHandleLinesUnselectedRegularFillBuffer
            tanHandleLinesSelectedStrokeBuffer = tanHandleLinesSelectedRegularStrokeBuffer
            tanHandleLinesSelectedFillBuffer = tanHandleLinesSelectedRegularFillBuffer
            
            tanHandlePointsUnselectedBloomBuffer = tanHandlePointsUnselectedRegularBloomBuffer
            tanHandlePointsUnselectedStrokeBuffer = tanHandlePointsUnselectedRegularStrokeBuffer
            tanHandlePointsUnselectedFillBuffer = tanHandlePointsUnselectedRegularFillBuffer
            tanHandlePointsSelectedBloomBuffer = tanHandlePointsSelectedRegularBloomBuffer
            tanHandlePointsSelectedStrokeBuffer = tanHandlePointsSelectedRegularStrokeBuffer
            tanHandlePointsSelectedFillBuffer = tanHandlePointsSelectedRegularFillBuffer
        }
        
        // 2.) The Guide Outline
        if jiggle.isShowingGuideBorderRings {
            if isPrecisePass {
                if isBloomMode && jiggle.isShowingGuideBorderRingsBloom {
                    guide.solidLineBufferPreciseBloom.shapeBuffer.projectionMatrix = projectionMatrix
                }
                guide.solidLineBufferPreciseStroke.shapeBuffer.projectionMatrix = projectionMatrix
                guide.solidLineBufferPreciseFill.shapeBuffer.projectionMatrix = projectionMatrix
            } else {
                if isBloomMode && jiggle.isShowingGuideBorderRingsBloom {
                    guide.solidLineBufferRegularBloom.shapeBuffer.projectionMatrix = projectionMatrix
                }
                guide.solidLineBufferRegularStroke.shapeBuffer.projectionMatrix = projectionMatrix
                guide.solidLineBufferRegularFill.shapeBuffer.projectionMatrix = projectionMatrix
            }
        }
        
        // 3.) The Jiggle Points
        preparePoints(pointsUnselectedBloomBuffer: pointsUnselectedBloomBuffer,
                      pointsUnselectedUnmodifiedStrokeBuffer: pointsUnselectedUnmodifiedStrokeBuffer,
                      pointsUnselectedUnmodifiedFillBuffer: pointsUnselectedUnmodifiedFillBuffer,
                      pointsUnselectedModifiedStrokeBuffer: pointsUnselectedModifiedStrokeBuffer,
                      pointsUnselectedModifiedFillBuffer: pointsUnselectedModifiedFillBuffer,
                      pointsSelectedBloomBuffer: pointsSelectedBloomBuffer,
                      pointsSelectedStrokeBuffer: pointsSelectedStrokeBuffer,
                      pointsSelectedFillBuffer: pointsSelectedFillBuffer,
                      isPrecisePass: isPrecisePass)
        
        // 4.) The Jiggle Tan Lines
        prepareTanLines(tanHandleLinesBloomBuffer: tanHandleLinesBloomBuffer,
                        tanHandleLinesUnselectedStrokeBuffer: tanHandleLinesUnselectedStrokeBuffer,
                        tanHandleLinesUnselectedFillBuffer: tanHandleLinesUnselectedFillBuffer,
                        tanHandleLinesSelectedStrokeBuffer: tanHandleLinesSelectedStrokeBuffer,
                        tanHandleLinesSelectedFillBuffer: tanHandleLinesSelectedFillBuffer,
                        isPrecisePass: isPrecisePass)
        
        // 5.) The Jiggle Tan Points
        prepareTanPoints(tanHandlePointsUnselectedBloomBuffer: tanHandlePointsUnselectedBloomBuffer,
                                    tanHandlePointsUnselectedStrokeBuffer: tanHandlePointsUnselectedStrokeBuffer,
                                    tanHandlePointsUnselectedFillBuffer: tanHandlePointsUnselectedFillBuffer,
                                    tanHandlePointsSelectedBloomBuffer: tanHandlePointsSelectedBloomBuffer,
                                    tanHandlePointsSelectedStrokeBuffer: tanHandlePointsSelectedStrokeBuffer,
                                    tanHandlePointsSelectedFillBuffer: tanHandlePointsSelectedFillBuffer,
                                    isPrecisePass: isPrecisePass)
        
    }
    
    func refreshPoints() {
        
        guard let jiggleEngine = jiggleEngine else {
            return
        }
        
        let lineThicknessType = ApplicationController.userLineThicknessType
        let pointSizeType = ApplicationController.userPointSizeType
        let sizeFill = ApplicationController.getPointFillBase(lineThicknessType: lineThicknessType,
                                                              pointSizeType: pointSizeType)
        let sizeStroke = ApplicationController.getPointStrokeBase(lineThicknessType: lineThicknessType,
                                                                  pointSizeType: pointSizeType)
        
        let unselectedStrokeSprite = jiggleEngine.circle(size: sizeStroke)
        let unselectedFillSprite = jiggleEngine.circle(size: sizeFill)
        let selectedStrokeSprite = jiggleEngine.circle(size: sizeStroke + 2)
        let selectedFillSprite = jiggleEngine.circle(size: sizeFill + 2)
        
        pointsUnselectedRegularBloomBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedUnmodifiedRegularStrokeBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedUnmodifiedRegularFillBuffer.sprite = unselectedFillSprite
        pointsUnselectedModifiedRegularStrokeBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedModifiedRegularFillBuffer.sprite = unselectedFillSprite
        
        pointsUnselectedPreciseBloomBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedUnmodifiedPreciseStrokeBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedUnmodifiedPreciseFillBuffer.sprite = unselectedFillSprite
        pointsUnselectedModifiedPreciseStrokeBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedModifiedPreciseFillBuffer.sprite = unselectedFillSprite
        
        
        pointsSelectedRegularBloomBuffer.sprite = selectedStrokeSprite
        pointsSelectedRegularStrokeBuffer.sprite = selectedStrokeSprite
        pointsSelectedRegularFillBuffer.sprite = selectedFillSprite
        pointsSelectedPreciseBloomBuffer.sprite = selectedStrokeSprite
        pointsSelectedPreciseStrokeBuffer.sprite = selectedStrokeSprite
        pointsSelectedPreciseFillBuffer.sprite = selectedFillSprite
        
        
        tanHandlePointsUnselectedRegularBloomBuffer.sprite = unselectedStrokeSprite
        tanHandlePointsUnselectedRegularStrokeBuffer.sprite = unselectedStrokeSprite
        tanHandlePointsUnselectedRegularFillBuffer.sprite = unselectedFillSprite
        
        tanHandlePointsUnselectedPreciseBloomBuffer.sprite = unselectedStrokeSprite
        tanHandlePointsUnselectedPreciseStrokeBuffer.sprite = unselectedStrokeSprite
        tanHandlePointsUnselectedPreciseFillBuffer.sprite = unselectedFillSprite
        
        
        tanHandlePointsSelectedRegularBloomBuffer.sprite = selectedStrokeSprite
        tanHandlePointsSelectedRegularStrokeBuffer.sprite = selectedStrokeSprite
        tanHandlePointsSelectedRegularFillBuffer.sprite = selectedFillSprite
        
        tanHandlePointsSelectedPreciseBloomBuffer.sprite = selectedStrokeSprite
        tanHandlePointsSelectedPreciseStrokeBuffer.sprite = selectedStrokeSprite
        tanHandlePointsSelectedPreciseFillBuffer.sprite = selectedFillSprite
    }
    
    func refreshLines() {
        let lineThicknessType = ApplicationController.userLineThicknessType
        lineWidthFillBase = ApplicationController.getLineThicknessFill(lineThicknessType: lineThicknessType) * 0.5
        lineWidthStrokeBase = ApplicationController.getLineThicknessStroke(lineThicknessType: lineThicknessType) * 0.5
    }
    
}
