//
//  JiggleRenderer.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 11/13/23.
//
//  Not Verified (Mostly Verified) on 11/9/2024 by Nick Raptis
//

import Foundation
import Metal
import simd

class JiggleRenderer {
    
    weak var graphics: Graphics?
    weak var jiggle: Jiggle?
    weak var jiggleEngine: JiggleEngine?
    
    // Jiggle Point Stroke (Unselected):
    let jigglePointUnselectedStrokeBufferStandard = IndexedSpriteBuffer2D()
    let jigglePointUnselectedStrokeBufferPrecise = IndexedSpriteBuffer2D()
    let jigglePointUnselectedStrokeBufferBloom = IndexedSpriteBuffer3D()
    
    // Jiggle Point Fill (Unselected):
    let jigglePointUnselectedFillBufferStandard = IndexedSpriteBuffer2DColored()
    let jigglePointUnselectedFillBufferPrecise = IndexedSpriteBuffer2DColored()
    
    // Jiggle Point Stroke (Selected):
    let jigglePointSelectedStrokeBufferStandard = IndexedSpriteBuffer2D()
    let jigglePointSelectedStrokeBufferPrecise = IndexedSpriteBuffer2D()
    let jigglePointSelectedStrokeBufferBloom = IndexedSpriteBuffer3D()
    
    // Jiggle Point Fill (Selected):
    let jigglePointSelectedFillBufferStandard = IndexedSpriteBuffer2DColored()
    let jigglePointSelectedFillBufferPrecise = IndexedSpriteBuffer2DColored()
    
    // Guide Point Stroke (Unselected):
    let guidePointUnselectedStrokeBufferStandard = IndexedSpriteBuffer2D()
    let guidePointUnselectedStrokeBufferPrecise = IndexedSpriteBuffer2D()
    let guidePointUnselectedStrokeBufferBloom = IndexedSpriteBuffer3D()
    
    // Guide Point Fill (Unselected):
    let guidePointUnselectedFillBufferStandard = IndexedSpriteBuffer2DColored()
    let guidePointUnselectedFillBufferPrecise = IndexedSpriteBuffer2DColored()
    
    // Guide Point Stroke (Selected):
    let guidePointSelectedStrokeBufferStandard = IndexedSpriteBuffer2D()
    let guidePointSelectedStrokeBufferPrecise = IndexedSpriteBuffer2D()
    let guidePointSelectedStrokeBufferBloom = IndexedSpriteBuffer3D()
    
    // Guide Point Fill (Selected):
    let guidePointSelectedFillBufferStandard = IndexedSpriteBuffer2DColored()
    let guidePointSelectedFillBufferPrecise = IndexedSpriteBuffer2DColored()
    
    // Jiggle Center Marker (Unselected):
    let jiggleCenterMarkerUnselectedPreciseFillInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerUnselectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerUnselectedRegularFillInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerUnselectedRegularStrokeInstance = IndexedSpriteInstance2D()
    
    // Jiggle Center Marker (Selected):
    let jiggleCenterMarkerSelectedPreciseFillInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerSelectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerSelectedRegularFillInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerSelectedRegularStrokeInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerSelectedRegularBloomInstance = IndexedSpriteInstance3D()
    
    // Weight Center Marker Dot (Unselected):
    let weightCenterMarkerDotUnselectedPreciseFillInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotUnselectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotUnselectedRegularFillInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotUnselectedRegularStrokeInstance = IndexedSpriteInstance2D()
    
    // Weight Center Marker Dot (Selected):
    let weightCenterMarkerDotSelectedPreciseFillInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotSelectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotSelectedRegularFillInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotSelectedRegularStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotSelectedRegularBloomInstance = IndexedSpriteInstance3D()
    
    // Weight Center Marker Spinner (Unselected):
    let weightCenterMarkerSpinnerUnselectedPreciseFillInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerUnselectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerUnselectedRegularFillInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerUnselectedRegularStrokeInstance = IndexedSpriteInstance2D()
    
    // Weight Center Marker Spinner (Selected):
    let weightCenterMarkerSpinnerSelectedPreciseFillInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerSelectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerSelectedRegularFillInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerSelectedRegularStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerSelectedRegularBloomInstance = IndexedSpriteInstance3D()
    
    // Jiggle Point Tan Handle Lines:
    let jigglePointTanHandleLineUnmodifiedRegularFillBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineUnmodifiedRegularStrokeBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineModifiedRegularFillBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineModifiedRegularStrokeBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineActiveRegularFillBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineActiveRegularStrokeBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineRegularBloomBuffer = IndexedShapeBuffer3D()
    let jigglePointTanHandleLineUnmodifiedPreciseFillBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineUnmodifiedPreciseStrokeBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineModifiedPreciseFillBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineModifiedPreciseStrokeBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineActivePreciseFillBuffer = IndexedShapeBuffer2D()
    let jigglePointTanHandleLineActivePreciseStrokeBuffer = IndexedShapeBuffer2D()
    
    // Jiggle Point Tan Handle Points Stroke (Unselected):
    let jigglePointTanHandlePointUnselectedStrokeBufferStandard = IndexedSpriteBuffer2D()
    let jigglePointTanHandlePointUnselectedStrokeBufferPrecise = IndexedSpriteBuffer2D()
    let jigglePointTanHandlePointUnselectedStrokeBufferBloom = IndexedSpriteBuffer3D()

    // Jiggle Point Tan Handle Points Fill (Unselected):
    let jigglePointTanHandlePointUnselectedFillBufferStandard = IndexedSpriteBuffer2DColored()
    let jigglePointTanHandlePointUnselectedFillBufferPrecise = IndexedSpriteBuffer2DColored()

    // Jiggle Point Tan Handle Points Stroke (Selected):
    let jigglePointTanHandlePointSelectedStrokeBufferStandard = IndexedSpriteBuffer2D()
    let jigglePointTanHandlePointSelectedStrokeBufferPrecise = IndexedSpriteBuffer2D()
    let jigglePointTanHandlePointSelectedStrokeBufferBloom = IndexedSpriteBuffer3D()

    // Jiggle Point Tan Handle Points Fill (Selected):
    let jigglePointTanHandlePointSelectedFillBufferStandard = IndexedSpriteBuffer2DColored()
    let jigglePointTanHandlePointSelectedFillBufferPrecise = IndexedSpriteBuffer2DColored()
    
    // Guide Point Tan Handle Lines:
    let guidePointTanHandleLineUnmodifiedRegularFillBuffer = IndexedShapeBuffer2DColored()
    let guidePointTanHandleLineUnmodifiedRegularStrokeBuffer = IndexedShapeBuffer2D()
    let guidePointTanHandleLineModifiedRegularFillBuffer = IndexedShapeBuffer2DColored()
    let guidePointTanHandleLineModifiedRegularStrokeBuffer = IndexedShapeBuffer2D()
    let guidePointTanHandleLineActiveRegularFillBuffer = IndexedShapeBuffer2D()
    let guidePointTanHandleLineActiveRegularStrokeBuffer = IndexedShapeBuffer2D()
    let guidePointTanHandleLineRegularBloomBuffer = IndexedShapeBuffer3D()
    let guidePointTanHandleLineUnmodifiedPreciseFillBuffer = IndexedShapeBuffer2DColored()
    let guidePointTanHandleLineUnmodifiedPreciseStrokeBuffer = IndexedShapeBuffer2D()
    let guidePointTanHandleLineModifiedPreciseFillBuffer = IndexedShapeBuffer2DColored()
    let guidePointTanHandleLineModifiedPreciseStrokeBuffer = IndexedShapeBuffer2D()
    let guidePointTanHandleLineActivePreciseFillBuffer = IndexedShapeBuffer2D()
    let guidePointTanHandleLineActivePreciseStrokeBuffer = IndexedShapeBuffer2D()
    
    // Guide Point Tan Handle Points Stroke (Unselected):
    let guidePointTanHandlePointUnselectedStrokeBufferStandard = IndexedSpriteBuffer2D()
    let guidePointTanHandlePointUnselectedStrokeBufferPrecise = IndexedSpriteBuffer2D()
    let guidePointTanHandlePointUnselectedStrokeBufferBloom = IndexedSpriteBuffer3D()

    // Guide Point Tan Handle Points Fill (Unselected):
    let guidePointTanHandlePointUnselectedFillBufferStandard = IndexedSpriteBuffer2DColored()
    let guidePointTanHandlePointUnselectedFillBufferPrecise = IndexedSpriteBuffer2DColored()

    // Guide Point Tan Handle Points Stroke (Selected):
    let guidePointTanHandlePointSelectedStrokeBufferStandard = IndexedSpriteBuffer2D()
    let guidePointTanHandlePointSelectedStrokeBufferPrecise = IndexedSpriteBuffer2D()
    let guidePointTanHandlePointSelectedStrokeBufferBloom = IndexedSpriteBuffer3D()

    // Guide Point Tan Handle Points Fill (Selected):
    let guidePointTanHandlePointSelectedFillBufferStandard = IndexedSpriteBuffer2DColored()
    let guidePointTanHandlePointSelectedFillBufferPrecise = IndexedSpriteBuffer2DColored()
    
    init(graphics: Graphics,
         jiggleEngine: JiggleEngine) {
        self.graphics = graphics
        self.jiggleEngine = jiggleEngine
    }
    
    func load() {
        
        guard let jiggleEngine = jiggleEngine else {
            print("FATAL: Expected Jiggle Engine")
            return
        }
        guard let graphics = graphics else {
            print("FATAL: Expected Graphics")
            return
        }
        
        // Jiggle Point Stroke (Unselected):
        jigglePointUnselectedStrokeBufferStandard.load(graphics: graphics, sprite: jiggleEngine.jiggleUnselectedPointRegularStrokeSprite)
        jigglePointUnselectedStrokeBufferStandard.primitiveType = .triangle
        jigglePointUnselectedStrokeBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.jiggleUnselectedPointRegularStrokeSprite)
        jigglePointUnselectedStrokeBufferPrecise.primitiveType = .triangle
        jigglePointUnselectedStrokeBufferBloom.load(graphics: graphics, sprite: jiggleEngine.jiggleUnselectedPointRegularStrokeSprite)
        jigglePointUnselectedStrokeBufferBloom.primitiveType = .triangle
        
        // Jiggle Point Fill (Unselected):
        jigglePointUnselectedFillBufferStandard.load(graphics: graphics, sprite: jiggleEngine.jiggleUnselectedPointRegularFillSprite)
        jigglePointUnselectedFillBufferStandard.primitiveType = .triangle
        jigglePointUnselectedFillBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.jiggleUnselectedPointRegularFillSprite)
        jigglePointUnselectedFillBufferPrecise.primitiveType = .triangle
        
        // Jiggle Point Stroke (Selected):
        jigglePointSelectedStrokeBufferStandard.load(graphics: graphics, sprite: jiggleEngine.jiggleSelectedPointRegularStrokeSprite)
        jigglePointSelectedStrokeBufferStandard.primitiveType = .triangle
        jigglePointSelectedStrokeBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.jiggleSelectedPointRegularStrokeSprite)
        jigglePointSelectedStrokeBufferPrecise.primitiveType = .triangle
        jigglePointSelectedStrokeBufferBloom.load(graphics: graphics, sprite: jiggleEngine.jiggleSelectedPointRegularStrokeSprite)
        jigglePointSelectedStrokeBufferBloom.primitiveType = .triangle
        
        // Jiggle Point Fill (Selected):
        jigglePointSelectedFillBufferStandard.load(graphics: graphics, sprite: jiggleEngine.jiggleSelectedPointRegularFillSprite)
        jigglePointSelectedFillBufferStandard.primitiveType = .triangle
        jigglePointSelectedFillBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.jiggleSelectedPointRegularFillSprite)
        jigglePointSelectedFillBufferPrecise.primitiveType = .triangle
        
        // Guide Point Stroke (Unselected):
        guidePointUnselectedStrokeBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularStrokeSprite)
        guidePointUnselectedStrokeBufferStandard.primitiveType = .triangle
        guidePointUnselectedStrokeBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularStrokeSprite)
        guidePointUnselectedStrokeBufferPrecise.primitiveType = .triangle
        guidePointUnselectedStrokeBufferBloom.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularStrokeSprite)
        guidePointUnselectedStrokeBufferBloom.primitiveType = .triangle
        
        // Guide Point Fill (Unselected):
        guidePointUnselectedFillBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularFillSprite)
        guidePointUnselectedFillBufferStandard.primitiveType = .triangle
        guidePointUnselectedFillBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularFillSprite)
        guidePointUnselectedFillBufferPrecise.primitiveType = .triangle
        
        // Guide Point Stroke (Selected):
        guidePointSelectedStrokeBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularStrokeSprite)
        guidePointSelectedStrokeBufferStandard.primitiveType = .triangle
        guidePointSelectedStrokeBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularStrokeSprite)
        guidePointSelectedStrokeBufferPrecise.primitiveType = .triangle
        guidePointSelectedStrokeBufferBloom.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularStrokeSprite)
        guidePointSelectedStrokeBufferBloom.primitiveType = .triangle
        
        // Guide Point Fill (Selected):
        guidePointSelectedFillBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularFillSprite)
        guidePointSelectedFillBufferStandard.primitiveType = .triangle
        guidePointSelectedFillBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularFillSprite)
        guidePointSelectedFillBufferPrecise.primitiveType = .triangle
        
        
        // Jiggle Center Marker (Unselected):
        jiggleCenterMarkerUnselectedPreciseFillInstance.load(graphics: graphics, sprite: jiggleEngine.jiggleCenterMarkerUnselectedRegularFill)
        jiggleCenterMarkerUnselectedPreciseStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.jiggleCenterMarkerUnselectedRegularStroke)
        jiggleCenterMarkerUnselectedRegularFillInstance.load(graphics: graphics, sprite: jiggleEngine.jiggleCenterMarkerUnselectedRegularFill)
        jiggleCenterMarkerUnselectedRegularStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.jiggleCenterMarkerUnselectedRegularStroke)
        
        // Jiggle Center Marker (Selected):
        jiggleCenterMarkerSelectedPreciseFillInstance.load(graphics: graphics, sprite: jiggleEngine.jiggleCenterMarkerSelectedRegularFill)
        jiggleCenterMarkerSelectedPreciseStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.jiggleCenterMarkerSelectedRegularStroke)
        jiggleCenterMarkerSelectedRegularFillInstance.load(graphics: graphics, sprite: jiggleEngine.jiggleCenterMarkerSelectedRegularFill)
        jiggleCenterMarkerSelectedRegularStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.jiggleCenterMarkerSelectedRegularStroke)
        jiggleCenterMarkerSelectedRegularBloomInstance.load(graphics: graphics, sprite: jiggleEngine.jiggleCenterMarkerSelectedRegularStroke)
        
        // Weight Center Marker Dot (Unselected):
        weightCenterMarkerDotUnselectedPreciseFillInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerDotUnselectedRegularFill)
        weightCenterMarkerDotUnselectedPreciseStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerDotUnselectedRegularStroke)
        weightCenterMarkerDotUnselectedRegularFillInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerDotUnselectedRegularFill)
        weightCenterMarkerDotUnselectedRegularStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerDotUnselectedRegularStroke)
        
        // Weight Center Marker Dot (Selected):
        weightCenterMarkerDotSelectedPreciseFillInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerDotSelectedRegularFill)
        weightCenterMarkerDotSelectedPreciseStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerDotSelectedRegularStroke)
        weightCenterMarkerDotSelectedRegularFillInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerDotSelectedRegularFill)
        weightCenterMarkerDotSelectedRegularStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerDotSelectedRegularStroke)
        weightCenterMarkerDotSelectedRegularBloomInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerDotSelectedRegularStroke)
        
        // Weight Center Marker Spinner (Unselected):
        weightCenterMarkerSpinnerUnselectedPreciseFillInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerSpinnerUnselectedRegularFill)
        weightCenterMarkerSpinnerUnselectedPreciseStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerSpinnerUnselectedRegularStroke)
        weightCenterMarkerSpinnerUnselectedRegularFillInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerSpinnerUnselectedRegularFill)
        weightCenterMarkerSpinnerUnselectedRegularStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerSpinnerUnselectedRegularStroke)
        
        // Weight Center Marker Spinner (Selected):
        weightCenterMarkerSpinnerSelectedPreciseFillInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerSpinnerSelectedRegularFill)
        weightCenterMarkerSpinnerSelectedPreciseStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerSpinnerSelectedRegularStroke)
        weightCenterMarkerSpinnerSelectedRegularFillInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerSpinnerSelectedRegularFill)
        weightCenterMarkerSpinnerSelectedRegularStrokeInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerSpinnerSelectedRegularStroke)
        weightCenterMarkerSpinnerSelectedRegularBloomInstance.load(graphics: graphics, sprite: jiggleEngine.weightCenterMarkerSpinnerSelectedRegularStroke)
        
        
        // Jiggle Point Tan Handle Lines:
        jigglePointTanHandleLineUnmodifiedRegularFillBuffer.load(graphics: graphics)
        jigglePointTanHandleLineUnmodifiedRegularFillBuffer.primitiveType = .triangle
        jigglePointTanHandleLineUnmodifiedRegularFillBuffer.cullMode = .none
        jigglePointTanHandleLineUnmodifiedRegularStrokeBuffer.load(graphics: graphics)
        jigglePointTanHandleLineUnmodifiedRegularStrokeBuffer.primitiveType = .triangle
        jigglePointTanHandleLineUnmodifiedRegularStrokeBuffer.cullMode = .none
        jigglePointTanHandleLineModifiedRegularFillBuffer.load(graphics: graphics)
        jigglePointTanHandleLineModifiedRegularFillBuffer.primitiveType = .triangle
        jigglePointTanHandleLineModifiedRegularFillBuffer.cullMode = .none
        jigglePointTanHandleLineModifiedRegularStrokeBuffer.load(graphics: graphics)
        jigglePointTanHandleLineModifiedRegularStrokeBuffer.primitiveType = .triangle
        jigglePointTanHandleLineModifiedRegularStrokeBuffer.cullMode = .none
        jigglePointTanHandleLineActiveRegularFillBuffer.load(graphics: graphics)
        jigglePointTanHandleLineActiveRegularFillBuffer.primitiveType = .triangle
        jigglePointTanHandleLineActiveRegularFillBuffer.cullMode = .none
        jigglePointTanHandleLineActiveRegularStrokeBuffer.load(graphics: graphics)
        jigglePointTanHandleLineActiveRegularStrokeBuffer.primitiveType = .triangle
        jigglePointTanHandleLineActiveRegularStrokeBuffer.cullMode = .none
        jigglePointTanHandleLineRegularBloomBuffer.load(graphics: graphics)
        jigglePointTanHandleLineRegularBloomBuffer.primitiveType = .triangle
        jigglePointTanHandleLineRegularBloomBuffer.cullMode = .none
        jigglePointTanHandleLineUnmodifiedPreciseFillBuffer.load(graphics: graphics)
        jigglePointTanHandleLineUnmodifiedPreciseFillBuffer.primitiveType = .triangle
        jigglePointTanHandleLineUnmodifiedPreciseFillBuffer.cullMode = .none
        jigglePointTanHandleLineUnmodifiedPreciseStrokeBuffer.load(graphics: graphics)
        jigglePointTanHandleLineUnmodifiedPreciseStrokeBuffer.primitiveType = .triangle
        jigglePointTanHandleLineUnmodifiedPreciseStrokeBuffer.cullMode = .none
        jigglePointTanHandleLineModifiedPreciseFillBuffer.load(graphics: graphics)
        jigglePointTanHandleLineModifiedPreciseFillBuffer.primitiveType = .triangle
        jigglePointTanHandleLineModifiedPreciseFillBuffer.cullMode = .none
        jigglePointTanHandleLineModifiedPreciseStrokeBuffer.load(graphics: graphics)
        jigglePointTanHandleLineModifiedPreciseStrokeBuffer.primitiveType = .triangle
        jigglePointTanHandleLineModifiedPreciseStrokeBuffer.cullMode = .none
        jigglePointTanHandleLineActivePreciseFillBuffer.load(graphics: graphics)
        jigglePointTanHandleLineActivePreciseFillBuffer.primitiveType = .triangle
        jigglePointTanHandleLineActivePreciseFillBuffer.cullMode = .none
        jigglePointTanHandleLineActivePreciseStrokeBuffer.load(graphics: graphics)
        jigglePointTanHandleLineActivePreciseStrokeBuffer.primitiveType = .triangle
        jigglePointTanHandleLineActivePreciseStrokeBuffer.cullMode = .none
        
        
        
        // Jiggle Point Tan Handle Points Stroke (Unselected):
        jigglePointTanHandlePointUnselectedStrokeBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularStrokeSprite)
        jigglePointTanHandlePointUnselectedStrokeBufferStandard.primitiveType = .triangle
        jigglePointTanHandlePointUnselectedStrokeBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularStrokeSprite)
        jigglePointTanHandlePointUnselectedStrokeBufferPrecise.primitiveType = .triangle
        jigglePointTanHandlePointUnselectedStrokeBufferBloom.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularStrokeSprite)
        jigglePointTanHandlePointUnselectedStrokeBufferBloom.primitiveType = .triangle

        // Jiggle Point Tan Handle Points Fill (Unselected):
        jigglePointTanHandlePointUnselectedFillBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularFillSprite)
        jigglePointTanHandlePointUnselectedFillBufferStandard.primitiveType = .triangle
        jigglePointTanHandlePointUnselectedFillBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularFillSprite)
        jigglePointTanHandlePointUnselectedFillBufferPrecise.primitiveType = .triangle

        // Jiggle Point Tan Handle Points Stroke (Selected):
        jigglePointTanHandlePointSelectedStrokeBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularStrokeSprite)
        jigglePointTanHandlePointSelectedStrokeBufferStandard.primitiveType = .triangle
        jigglePointTanHandlePointSelectedStrokeBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularStrokeSprite)
        jigglePointTanHandlePointSelectedStrokeBufferPrecise.primitiveType = .triangle
        jigglePointTanHandlePointSelectedStrokeBufferBloom.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularStrokeSprite)
        jigglePointTanHandlePointSelectedStrokeBufferBloom.primitiveType = .triangle

        // Jiggle Point Tan Handle Points Fill (Selected):
        jigglePointTanHandlePointSelectedFillBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularFillSprite)
        jigglePointTanHandlePointSelectedFillBufferStandard.primitiveType = .triangle
        jigglePointTanHandlePointSelectedFillBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularFillSprite)
        jigglePointTanHandlePointSelectedFillBufferPrecise.primitiveType = .triangle
        
        // Guide Point Tan Handle Lines:
        guidePointTanHandleLineUnmodifiedRegularFillBuffer.load(graphics: graphics)
        guidePointTanHandleLineUnmodifiedRegularFillBuffer.primitiveType = .triangle
        guidePointTanHandleLineUnmodifiedRegularFillBuffer.cullMode = .none
        guidePointTanHandleLineUnmodifiedRegularStrokeBuffer.load(graphics: graphics)
        guidePointTanHandleLineUnmodifiedRegularStrokeBuffer.primitiveType = .triangle
        guidePointTanHandleLineUnmodifiedRegularStrokeBuffer.cullMode = .none
        guidePointTanHandleLineModifiedRegularFillBuffer.load(graphics: graphics)
        guidePointTanHandleLineModifiedRegularFillBuffer.primitiveType = .triangle
        guidePointTanHandleLineModifiedRegularFillBuffer.cullMode = .none
        guidePointTanHandleLineModifiedRegularStrokeBuffer.load(graphics: graphics)
        guidePointTanHandleLineModifiedRegularStrokeBuffer.primitiveType = .triangle
        guidePointTanHandleLineModifiedRegularStrokeBuffer.cullMode = .none
        guidePointTanHandleLineActiveRegularFillBuffer.load(graphics: graphics)
        guidePointTanHandleLineActiveRegularFillBuffer.primitiveType = .triangle
        guidePointTanHandleLineActiveRegularFillBuffer.cullMode = .none
        guidePointTanHandleLineActiveRegularStrokeBuffer.load(graphics: graphics)
        guidePointTanHandleLineActiveRegularStrokeBuffer.primitiveType = .triangle
        guidePointTanHandleLineActiveRegularStrokeBuffer.cullMode = .none
        guidePointTanHandleLineRegularBloomBuffer.load(graphics: graphics)
        guidePointTanHandleLineRegularBloomBuffer.primitiveType = .triangle
        guidePointTanHandleLineRegularBloomBuffer.cullMode = .none
        guidePointTanHandleLineUnmodifiedPreciseFillBuffer.load(graphics: graphics)
        guidePointTanHandleLineUnmodifiedPreciseFillBuffer.primitiveType = .triangle
        guidePointTanHandleLineUnmodifiedPreciseFillBuffer.cullMode = .none
        guidePointTanHandleLineUnmodifiedPreciseStrokeBuffer.load(graphics: graphics)
        guidePointTanHandleLineUnmodifiedPreciseStrokeBuffer.primitiveType = .triangle
        guidePointTanHandleLineUnmodifiedPreciseStrokeBuffer.cullMode = .none
        guidePointTanHandleLineModifiedPreciseFillBuffer.load(graphics: graphics)
        guidePointTanHandleLineModifiedPreciseFillBuffer.primitiveType = .triangle
        guidePointTanHandleLineModifiedPreciseFillBuffer.cullMode = .none
        guidePointTanHandleLineModifiedPreciseStrokeBuffer.load(graphics: graphics)
        guidePointTanHandleLineModifiedPreciseStrokeBuffer.primitiveType = .triangle
        guidePointTanHandleLineModifiedPreciseStrokeBuffer.cullMode = .none
        guidePointTanHandleLineActivePreciseFillBuffer.load(graphics: graphics)
        guidePointTanHandleLineActivePreciseFillBuffer.primitiveType = .triangle
        guidePointTanHandleLineActivePreciseFillBuffer.cullMode = .none
        guidePointTanHandleLineActivePreciseStrokeBuffer.load(graphics: graphics)
        guidePointTanHandleLineActivePreciseStrokeBuffer.primitiveType = .triangle
        guidePointTanHandleLineActivePreciseStrokeBuffer.cullMode = .none
        
        // Guide Point Tan Handle Points Stroke (Unselected):
        guidePointTanHandlePointUnselectedStrokeBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularStrokeSprite)
        guidePointTanHandlePointUnselectedStrokeBufferStandard.primitiveType = .triangle
        guidePointTanHandlePointUnselectedStrokeBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularStrokeSprite)
        guidePointTanHandlePointUnselectedStrokeBufferPrecise.primitiveType = .triangle
        guidePointTanHandlePointUnselectedStrokeBufferBloom.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularStrokeSprite)
        guidePointTanHandlePointUnselectedStrokeBufferBloom.primitiveType = .triangle

        // Guide Point Tan Handle Points Fill (Unselected):
        guidePointTanHandlePointUnselectedFillBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularFillSprite)
        guidePointTanHandlePointUnselectedFillBufferStandard.primitiveType = .triangle
        guidePointTanHandlePointUnselectedFillBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideUnselectedPointRegularFillSprite)
        guidePointTanHandlePointUnselectedFillBufferPrecise.primitiveType = .triangle

        // Guide Point Tan Handle Points Stroke (Selected):
        guidePointTanHandlePointSelectedStrokeBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularStrokeSprite)
        guidePointTanHandlePointSelectedStrokeBufferStandard.primitiveType = .triangle
        guidePointTanHandlePointSelectedStrokeBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularStrokeSprite)
        guidePointTanHandlePointSelectedStrokeBufferPrecise.primitiveType = .triangle
        guidePointTanHandlePointSelectedStrokeBufferBloom.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularStrokeSprite)
        guidePointTanHandlePointSelectedStrokeBufferBloom.primitiveType = .triangle

        // Guide Point Tan Handle Points Fill (Selected):
        guidePointTanHandlePointSelectedFillBufferStandard.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularFillSprite)
        guidePointTanHandlePointSelectedFillBufferStandard.primitiveType = .triangle
        guidePointTanHandlePointSelectedFillBufferPrecise.load(graphics: graphics, sprite: jiggleEngine.guideSelectedPointRegularFillSprite)
        guidePointTanHandlePointSelectedFillBufferPrecise.primitiveType = .triangle
    }
    
    func reset() {
        
        // Jiggle Point Stroke (Unselected):
        jigglePointUnselectedStrokeBufferStandard.reset()
        jigglePointUnselectedStrokeBufferPrecise.reset()
        jigglePointUnselectedStrokeBufferBloom.reset()
        
        // Jiggle Point Fill (Unselected):
        jigglePointUnselectedFillBufferStandard.reset()
        jigglePointUnselectedFillBufferPrecise.reset()
        
        // Jiggle Point Stroke (Selected):
        jigglePointSelectedStrokeBufferStandard.reset()
        jigglePointSelectedStrokeBufferPrecise.reset()
        jigglePointSelectedStrokeBufferBloom.reset()
        
        // Jiggle Point Fill (Selected):
        jigglePointSelectedFillBufferStandard.reset()
        jigglePointSelectedFillBufferPrecise.reset()
        
        // Guide Point Stroke (Unselected):
        guidePointUnselectedStrokeBufferStandard.reset()
        guidePointUnselectedStrokeBufferPrecise.reset()
        guidePointUnselectedStrokeBufferBloom.reset()
        
        // Guide Point Fill (Unselected):
        guidePointUnselectedFillBufferStandard.reset()
        guidePointUnselectedFillBufferPrecise.reset()
        
        // Guide Point Stroke (Selected):
        guidePointSelectedStrokeBufferStandard.reset()
        guidePointSelectedStrokeBufferPrecise.reset()
        guidePointSelectedStrokeBufferBloom.reset()
        
        // Guide Point Fill (Selected):
        guidePointSelectedFillBufferStandard.reset()
        guidePointSelectedFillBufferPrecise.reset()
        
        // Jiggle Point Tan Handle Lines:
        jigglePointTanHandleLineUnmodifiedRegularFillBuffer.reset()
        jigglePointTanHandleLineUnmodifiedRegularStrokeBuffer.reset()
        jigglePointTanHandleLineModifiedRegularFillBuffer.reset()
        jigglePointTanHandleLineModifiedRegularStrokeBuffer.reset()
        jigglePointTanHandleLineActiveRegularFillBuffer.reset()
        jigglePointTanHandleLineActiveRegularStrokeBuffer.reset()
        jigglePointTanHandleLineRegularBloomBuffer.reset()
        jigglePointTanHandleLineUnmodifiedPreciseFillBuffer.reset()
        jigglePointTanHandleLineUnmodifiedPreciseStrokeBuffer.reset()
        jigglePointTanHandleLineModifiedPreciseFillBuffer.reset()
        jigglePointTanHandleLineModifiedPreciseStrokeBuffer.reset()
        jigglePointTanHandleLineActivePreciseFillBuffer.reset()
        jigglePointTanHandleLineActivePreciseStrokeBuffer.reset()
        
        // Jiggle Point Tan Handle Points Stroke (Unselected):
        jigglePointTanHandlePointUnselectedStrokeBufferStandard.reset()
        jigglePointTanHandlePointUnselectedStrokeBufferPrecise.reset()
        jigglePointTanHandlePointUnselectedStrokeBufferBloom.reset()

        // Jiggle Point Tan Handle Points Fill (Unselected):
        jigglePointTanHandlePointUnselectedFillBufferStandard.reset()
        jigglePointTanHandlePointUnselectedFillBufferPrecise.reset()

        // Jiggle Point Tan Handle Points Stroke (Selected):
        jigglePointTanHandlePointSelectedStrokeBufferStandard.reset()
        jigglePointTanHandlePointSelectedStrokeBufferPrecise.reset()
        jigglePointTanHandlePointSelectedStrokeBufferBloom.reset()

        // Jiggle Point Tan Handle Points Fill (Selected):
        jigglePointTanHandlePointSelectedFillBufferStandard.reset()
        jigglePointTanHandlePointSelectedFillBufferPrecise.reset()
        
        // Guide Point Tan Handle Lines:
        guidePointTanHandleLineUnmodifiedRegularFillBuffer.reset()
        guidePointTanHandleLineUnmodifiedRegularStrokeBuffer.reset()
        guidePointTanHandleLineModifiedRegularFillBuffer.reset()
        guidePointTanHandleLineModifiedRegularStrokeBuffer.reset()
        guidePointTanHandleLineActiveRegularFillBuffer.reset()
        guidePointTanHandleLineActiveRegularStrokeBuffer.reset()
        guidePointTanHandleLineRegularBloomBuffer.reset()
        guidePointTanHandleLineUnmodifiedPreciseFillBuffer.reset()
        guidePointTanHandleLineUnmodifiedPreciseStrokeBuffer.reset()
        guidePointTanHandleLineModifiedPreciseFillBuffer.reset()
        guidePointTanHandleLineModifiedPreciseStrokeBuffer.reset()
        guidePointTanHandleLineActivePreciseFillBuffer.reset()
        guidePointTanHandleLineActivePreciseStrokeBuffer.reset()
        
        // Guide Point Tan Handle Points Stroke (Unselected):
        guidePointTanHandlePointUnselectedStrokeBufferStandard.reset()
        guidePointTanHandlePointUnselectedStrokeBufferPrecise.reset()
        guidePointTanHandlePointUnselectedStrokeBufferBloom.reset()

        // Guide Point Tan Handle Points Fill (Unselected):
        guidePointTanHandlePointUnselectedFillBufferStandard.reset()
        guidePointTanHandlePointUnselectedFillBufferPrecise.reset()

        // Guide Point Tan Handle Points Stroke (Selected):
        guidePointTanHandlePointSelectedStrokeBufferStandard.reset()
        guidePointTanHandlePointSelectedStrokeBufferPrecise.reset()
        guidePointTanHandlePointSelectedStrokeBufferBloom.reset()

        // Guide Point Tan Handle Points Fill (Selected):
        guidePointTanHandlePointSelectedFillBufferStandard.reset()
        guidePointTanHandlePointSelectedFillBufferPrecise.reset()
    }
    
    func getLineBox(x1: Float, y1: Float,
                    x2: Float, y2: Float,
                    normalX: Float, normalY: Float,
                    thickness: Float) -> LineBox {
        let _x1 = x1 - thickness * normalX; let _y1 = y1 - thickness * normalY
        let _x2 = x1 + thickness * normalX; let _y2 = y1 + thickness * normalY
        let _x3 = x2 - thickness * normalX; let _y3 = y2 - thickness * normalY
        let _x4 = x2 + thickness * normalX; let _y4 = y2 + thickness * normalY
        return LineBox(x1: _x1, y1: _y1, x2: _x2, y2: _y2,
                       x3: _x3, y3: _y3, x4: _x4, y4: _y4)
    }
    
    var isSelected = false
    var isDarkModeEnabled = false
    
    @MainActor func pre_prepare(jiggle: Jiggle,
                                isSelected: Bool,
                                isStereoscopicEnabled: Bool,
                                projectionMatrixBase: matrix_float4x4,
                                modelViewMatrixBase: matrix_float4x4,
                                isCreatorModeJiggleCenters: Bool,
                                isCreatorModeAddJigglePoints: Bool,
                                isCreatorModeGuideCenters: Bool,
                                isCreatorModeAddGuidePoints: Bool,
                                isCreatorModeDeleteGuidePoints: Bool,
                                weightMode: WeightMode,
                                selectedJigglePointTanType: TanType,
                                selectedGuidePointTanType: TanType) {
        
        self.jiggle = jiggle
        self.isSelected = isSelected
        self.isDarkModeEnabled = jiggle.isShowingDarkMode
        
        if jiggle.isShowingJiggleControlPointTanHandles || jiggle.isShowingJigglePoints {
            for jiggleControlPointIndex in 0..<jiggle.jiggleControlPointCount {
                let jiggleControlPoint = jiggle.jiggleControlPoints[jiggleControlPointIndex]
                
                var renderPoint = jiggleControlPoint.point
                renderPoint = jiggle.transformPoint(point: renderPoint)
                let isPointSelected: Bool
                if (isSelected == true) && (jiggle.selectedJiggleControlPointIndex == jiggleControlPointIndex) {
                    isPointSelected = true
                } else {
                    isPointSelected = false
                }
                
                jiggleControlPoint.renderX = renderPoint.x
                jiggleControlPoint.renderY = renderPoint.y
                jiggleControlPoint.renderSelected = isPointSelected
            }
        }
        
        if jiggle.isShowingGuidePoints {
            for guideIndex in 0..<jiggle.guideCount {
                let guide = jiggle.guides[guideIndex]
                
                var isGuideSelected = false
                if isSelected {
                    if jiggle.selectedWeightCurveControlIndex == (guideIndex + 1) {
                        isGuideSelected = true
                    }
                }
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
        }
        
        if jiggle.isShowingJiggleControlPointTanHandles {
            for jiggleControlPointIndex in 0..<jiggle.jiggleControlPointCount {
                let jiggleControlPoint = jiggle.jiggleControlPoints[jiggleControlPointIndex]
                
                var tanHandles = jiggleControlPoint.getTanHandles()
                tanHandles = jiggle.transformTanHandles(tanHandles)
                
                var tanNormals = jiggleControlPoint.getTanHandleNormals()
                tanNormals = jiggle.transformPointRotationOnly(vector: tanNormals)
                
                jiggleControlPoint.renderTanInX = tanHandles.inX
                jiggleControlPoint.renderTanInY = tanHandles.inY
                
                jiggleControlPoint.renderTanOutX = tanHandles.outX
                jiggleControlPoint.renderTanOutY = tanHandles.outY
                
                jiggleControlPoint.renderTanNormalX = tanNormals.x
                jiggleControlPoint.renderTanNormalY = tanNormals.y
            }
        }
        
        if jiggle.isShowingGuideControlPointTanHandles {
            for guideIndex in 0..<jiggle.guideCount {
                let guide = jiggle.guides[guideIndex]
                
                for guideControlPointIndex in 0..<guide.guideControlPointCount {
                    let guideControlPoint = guide.guideControlPoints[guideControlPointIndex]
                    
                    var guideControlPointCenterTransformed = guideControlPoint.point
                    guideControlPointCenterTransformed = guide.transformPoint(point: guideControlPointCenterTransformed)
                    guideControlPointCenterTransformed = jiggle.transformPoint(point: guideControlPointCenterTransformed)
                    
                    var tanHandles = guideControlPoint.getTanHandles()
                    tanHandles = guide.transformTanHandles(tanHandles)
                    tanHandles = jiggle.transformTanHandles(tanHandles)
                    
                    var tanNormals = guideControlPoint.getTanHandleNormals()
                    tanNormals = guide.transformPointRotationOnly(vector: tanNormals)
                    tanNormals = jiggle.transformPointRotationOnly(vector: tanNormals)

                    guideControlPoint.renderTanInX = tanHandles.inX
                    guideControlPoint.renderTanInY = tanHandles.inY
                    
                    guideControlPoint.renderTanOutX = tanHandles.outX
                    guideControlPoint.renderTanOutY = tanHandles.outY
                    
                    guideControlPoint.renderTanNormalX = tanNormals.x
                    guideControlPoint.renderTanNormalY = tanNormals.y
                }
            }
        }
    }
    
    @MainActor func prepare(jiggle: Jiggle,
                            isSelected: Bool,
                            isStereoscopicEnabled: Bool,
                            projectionMatrixBase: matrix_float4x4,
                            modelViewMatrixBase: matrix_float4x4,
                            isCreatorModeJiggleCenters: Bool,
                            isCreatorModeAddJigglePoints: Bool,
                            isCreatorModeGuideCenters: Bool,
                            isCreatorModeAddGuidePoints: Bool,
                            isCreatorModeDeleteGuidePoints: Bool,
                            weightMode: WeightMode,
                            selectedJigglePointTanType: TanType,
                            selectedGuidePointTanType: TanType,
                            jigglePointSelectionModality: PointSelectionModality,
                            guidePointSelectionModality: PointSelectionModality,
                            sceneScaleBase: Float,
                            isPrecisePass: Bool) {
        
        guard let jiggleEngine = jiggleEngine else {
            return
        }
        guard let jiggleScene = jiggleEngine.jiggleScene else {
            return
        }
        
        let jigglePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D
        let jigglePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored
        let jigglePointSelectedStrokeBuffer: IndexedSpriteBuffer2D
        let jigglePointSelectedFillBuffer: IndexedSpriteBuffer2DColored
        
        let guidePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D
        let guidePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored
        let guidePointSelectedStrokeBuffer: IndexedSpriteBuffer2D
        let guidePointSelectedFillBuffer: IndexedSpriteBuffer2DColored
        
        let jiggleCenterMarkerUnselectedFillInstance: IndexedSpriteInstance2D
        let jiggleCenterMarkerUnselectedStrokeInstance: IndexedSpriteInstance2D
        let jiggleCenterMarkerSelectedFillInstance: IndexedSpriteInstance2D
        let jiggleCenterMarkerSelectedStrokeInstance: IndexedSpriteInstance2D
        
        let weightCenterMarkerDotUnselectedFillInstance: IndexedSpriteInstance2D
        let weightCenterMarkerDotUnselectedStrokeInstance: IndexedSpriteInstance2D
        let weightCenterMarkerDotSelectedFillInstance: IndexedSpriteInstance2D
        let weightCenterMarkerDotSelectedStrokeInstance: IndexedSpriteInstance2D
    
        let weightCenterMarkerSpinnerUnselectedFillInstance: IndexedSpriteInstance2D
        let weightCenterMarkerSpinnerUnselectedStrokeInstance: IndexedSpriteInstance2D
        let weightCenterMarkerSpinnerSelectedFillInstance: IndexedSpriteInstance2D
        let weightCenterMarkerSpinnerSelectedStrokeInstance: IndexedSpriteInstance2D
        
        let jigglePointTanHandleLineUnmodifiedFillBuffer: IndexedShapeBuffer2D
        let jigglePointTanHandleLineUnmodifiedStrokeBuffer: IndexedShapeBuffer2D
        let jigglePointTanHandleLineModifiedFillBuffer: IndexedShapeBuffer2D
        let jigglePointTanHandleLineModifiedStrokeBuffer: IndexedShapeBuffer2D
        let jigglePointTanHandleLineActiveFillBuffer: IndexedShapeBuffer2D
        let jigglePointTanHandleLineActiveStrokeBuffer: IndexedShapeBuffer2D
        
        let jigglePointTanHandlePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D
        let jigglePointTanHandlePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored
        let jigglePointTanHandlePointSelectedStrokeBuffer: IndexedSpriteBuffer2D
        let jigglePointTanHandlePointSelectedFillBuffer: IndexedSpriteBuffer2DColored
        
        let guidePointTanHandleLineUnmodifiedFillBuffer: IndexedShapeBuffer2DColored
        let guidePointTanHandleLineUnmodifiedStrokeBuffer: IndexedShapeBuffer2D
        let guidePointTanHandleLineModifiedFillBuffer: IndexedShapeBuffer2DColored
        let guidePointTanHandleLineModifiedStrokeBuffer: IndexedShapeBuffer2D
        let guidePointTanHandleLineActiveFillBuffer: IndexedShapeBuffer2D
        let guidePointTanHandleLineActiveStrokeBuffer: IndexedShapeBuffer2D
        
        let guidePointTanHandlePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D
        let guidePointTanHandlePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored
        let guidePointTanHandlePointSelectedStrokeBuffer: IndexedSpriteBuffer2D
        let guidePointTanHandlePointSelectedFillBuffer: IndexedSpriteBuffer2DColored
        
        if isPrecisePass {
            jigglePointUnselectedStrokeBuffer = jigglePointUnselectedStrokeBufferPrecise
            jigglePointUnselectedFillBuffer = jigglePointUnselectedFillBufferPrecise
            jigglePointSelectedStrokeBuffer = jigglePointSelectedStrokeBufferPrecise
            jigglePointSelectedFillBuffer = jigglePointSelectedFillBufferPrecise
            
            guidePointUnselectedStrokeBuffer = guidePointUnselectedStrokeBufferPrecise
            guidePointUnselectedFillBuffer = guidePointUnselectedFillBufferPrecise
            guidePointSelectedStrokeBuffer = guidePointSelectedStrokeBufferPrecise
            guidePointSelectedFillBuffer = guidePointSelectedFillBufferPrecise
            
            jiggleCenterMarkerUnselectedFillInstance = jiggleCenterMarkerUnselectedPreciseFillInstance
            jiggleCenterMarkerUnselectedStrokeInstance = jiggleCenterMarkerUnselectedPreciseStrokeInstance
            jiggleCenterMarkerSelectedFillInstance = jiggleCenterMarkerSelectedPreciseFillInstance
            jiggleCenterMarkerSelectedStrokeInstance = jiggleCenterMarkerSelectedPreciseStrokeInstance
            
            weightCenterMarkerDotUnselectedFillInstance = weightCenterMarkerDotUnselectedPreciseFillInstance
            weightCenterMarkerDotUnselectedStrokeInstance = weightCenterMarkerDotUnselectedPreciseStrokeInstance
            weightCenterMarkerDotSelectedFillInstance = weightCenterMarkerDotSelectedPreciseFillInstance
            weightCenterMarkerDotSelectedStrokeInstance = weightCenterMarkerDotSelectedPreciseStrokeInstance
            
            weightCenterMarkerSpinnerUnselectedFillInstance = weightCenterMarkerSpinnerUnselectedPreciseFillInstance
            weightCenterMarkerSpinnerUnselectedStrokeInstance = weightCenterMarkerSpinnerUnselectedPreciseStrokeInstance
            weightCenterMarkerSpinnerSelectedFillInstance = weightCenterMarkerSpinnerSelectedPreciseFillInstance
            weightCenterMarkerSpinnerSelectedStrokeInstance = weightCenterMarkerSpinnerSelectedPreciseStrokeInstance
            
            jigglePointTanHandleLineUnmodifiedFillBuffer = jigglePointTanHandleLineUnmodifiedPreciseFillBuffer
            jigglePointTanHandleLineUnmodifiedStrokeBuffer = jigglePointTanHandleLineUnmodifiedPreciseStrokeBuffer
            jigglePointTanHandleLineModifiedFillBuffer = jigglePointTanHandleLineModifiedPreciseFillBuffer
            jigglePointTanHandleLineModifiedStrokeBuffer = jigglePointTanHandleLineModifiedPreciseStrokeBuffer
            jigglePointTanHandleLineActiveFillBuffer = jigglePointTanHandleLineActivePreciseFillBuffer
            jigglePointTanHandleLineActiveStrokeBuffer = jigglePointTanHandleLineActivePreciseStrokeBuffer
            
            jigglePointTanHandlePointUnselectedStrokeBuffer = jigglePointTanHandlePointUnselectedStrokeBufferPrecise
            jigglePointTanHandlePointUnselectedFillBuffer = jigglePointTanHandlePointUnselectedFillBufferPrecise
            jigglePointTanHandlePointSelectedStrokeBuffer = jigglePointTanHandlePointSelectedStrokeBufferPrecise
            jigglePointTanHandlePointSelectedFillBuffer = jigglePointTanHandlePointSelectedFillBufferPrecise
            
            guidePointTanHandleLineUnmodifiedFillBuffer = guidePointTanHandleLineUnmodifiedPreciseFillBuffer
            guidePointTanHandleLineUnmodifiedStrokeBuffer = guidePointTanHandleLineUnmodifiedPreciseStrokeBuffer
            guidePointTanHandleLineModifiedFillBuffer = guidePointTanHandleLineModifiedPreciseFillBuffer
            guidePointTanHandleLineModifiedStrokeBuffer = guidePointTanHandleLineModifiedPreciseStrokeBuffer
            guidePointTanHandleLineActiveFillBuffer = guidePointTanHandleLineActivePreciseFillBuffer
            guidePointTanHandleLineActiveStrokeBuffer = guidePointTanHandleLineActivePreciseStrokeBuffer
            
            guidePointTanHandlePointUnselectedStrokeBuffer = guidePointTanHandlePointUnselectedStrokeBufferPrecise
            guidePointTanHandlePointUnselectedFillBuffer = guidePointTanHandlePointUnselectedFillBufferPrecise
            guidePointTanHandlePointSelectedStrokeBuffer = guidePointTanHandlePointSelectedStrokeBufferPrecise
            guidePointTanHandlePointSelectedFillBuffer = guidePointTanHandlePointSelectedFillBufferPrecise
        } else {
            jigglePointUnselectedStrokeBuffer = jigglePointUnselectedStrokeBufferStandard
            jigglePointUnselectedFillBuffer = jigglePointUnselectedFillBufferStandard
            jigglePointSelectedStrokeBuffer = jigglePointSelectedStrokeBufferStandard
            jigglePointSelectedFillBuffer = jigglePointSelectedFillBufferStandard
            
            guidePointUnselectedStrokeBuffer = guidePointUnselectedStrokeBufferStandard
            guidePointUnselectedFillBuffer = guidePointUnselectedFillBufferStandard
            guidePointSelectedStrokeBuffer = guidePointSelectedStrokeBufferStandard
            guidePointSelectedFillBuffer = guidePointSelectedFillBufferStandard
            
            jiggleCenterMarkerUnselectedFillInstance = jiggleCenterMarkerUnselectedRegularFillInstance
            jiggleCenterMarkerUnselectedStrokeInstance = jiggleCenterMarkerUnselectedRegularStrokeInstance
            jiggleCenterMarkerSelectedFillInstance = jiggleCenterMarkerSelectedRegularFillInstance
            jiggleCenterMarkerSelectedStrokeInstance = jiggleCenterMarkerSelectedRegularStrokeInstance
            
            weightCenterMarkerDotUnselectedFillInstance = weightCenterMarkerDotUnselectedRegularFillInstance
            weightCenterMarkerDotUnselectedStrokeInstance = weightCenterMarkerDotUnselectedRegularStrokeInstance
            weightCenterMarkerDotSelectedFillInstance = weightCenterMarkerDotSelectedRegularFillInstance
            weightCenterMarkerDotSelectedStrokeInstance = weightCenterMarkerDotSelectedRegularStrokeInstance
            
            weightCenterMarkerSpinnerUnselectedFillInstance = weightCenterMarkerSpinnerUnselectedRegularFillInstance
            weightCenterMarkerSpinnerUnselectedStrokeInstance = weightCenterMarkerSpinnerUnselectedRegularStrokeInstance
            weightCenterMarkerSpinnerSelectedFillInstance = weightCenterMarkerSpinnerSelectedRegularFillInstance
            weightCenterMarkerSpinnerSelectedStrokeInstance = weightCenterMarkerSpinnerSelectedRegularStrokeInstance
            
            jigglePointTanHandleLineUnmodifiedFillBuffer = jigglePointTanHandleLineUnmodifiedRegularFillBuffer
            jigglePointTanHandleLineUnmodifiedStrokeBuffer = jigglePointTanHandleLineUnmodifiedRegularStrokeBuffer
            jigglePointTanHandleLineModifiedFillBuffer = jigglePointTanHandleLineModifiedRegularFillBuffer
            jigglePointTanHandleLineModifiedStrokeBuffer = jigglePointTanHandleLineModifiedRegularStrokeBuffer
            jigglePointTanHandleLineActiveFillBuffer = jigglePointTanHandleLineActiveRegularFillBuffer
            jigglePointTanHandleLineActiveStrokeBuffer = jigglePointTanHandleLineActiveRegularStrokeBuffer
            
            jigglePointTanHandlePointUnselectedStrokeBuffer = jigglePointTanHandlePointUnselectedStrokeBufferStandard
            jigglePointTanHandlePointUnselectedFillBuffer = jigglePointTanHandlePointUnselectedFillBufferStandard
            jigglePointTanHandlePointSelectedStrokeBuffer = jigglePointTanHandlePointSelectedStrokeBufferStandard
            jigglePointTanHandlePointSelectedFillBuffer = jigglePointTanHandlePointSelectedFillBufferStandard
            
            guidePointTanHandleLineUnmodifiedFillBuffer = guidePointTanHandleLineUnmodifiedRegularFillBuffer
            guidePointTanHandleLineUnmodifiedStrokeBuffer = guidePointTanHandleLineUnmodifiedRegularStrokeBuffer
            guidePointTanHandleLineModifiedFillBuffer = guidePointTanHandleLineModifiedRegularFillBuffer
            guidePointTanHandleLineModifiedStrokeBuffer = guidePointTanHandleLineModifiedRegularStrokeBuffer
            guidePointTanHandleLineActiveFillBuffer = guidePointTanHandleLineActiveRegularFillBuffer
            guidePointTanHandleLineActiveStrokeBuffer = guidePointTanHandleLineActiveRegularStrokeBuffer
            
            guidePointTanHandlePointUnselectedStrokeBuffer = guidePointTanHandlePointUnselectedStrokeBufferStandard
            guidePointTanHandlePointUnselectedFillBuffer = guidePointTanHandlePointUnselectedFillBufferStandard
            guidePointTanHandlePointSelectedStrokeBuffer = guidePointTanHandlePointSelectedStrokeBufferStandard
            guidePointTanHandlePointSelectedFillBuffer = guidePointTanHandlePointSelectedFillBufferStandard
        }
        
        let worldScaleStandard = jiggleScene.getWorldScaleStandard()
        let worldScalePrecise = jiggleScene.getWorldScalePrecise()
        
        let pointScale: Float
        if isPrecisePass {
            pointScale = worldScalePrecise * JiggleViewModel.pointScalePrecise
        } else {
            pointScale = worldScaleStandard * JiggleViewModel.pointScaleStandard
        }
        
        let baseAdjustRotation: Float
        if isPrecisePass {
            baseAdjustRotation = (-jiggleScene.preciseZoomRotation)
        } else {
            baseAdjustRotation = (-jiggleScene.sceneRotation)
        }
        
        let isBloomEnabled = ApplicationController.isGlowingSelectionEnabled
        
        var transformedModelView = matrix_identity_float4x4
        transformedModelView.translation(x: jiggle.center.x,
                                         y: jiggle.center.y,
                                         z: 0.0)
        transformedModelView.scale(jiggle.scale)
        transformedModelView.rotateZ(radians: jiggle.rotation)
        
        let jiggleColorPack = getJiggleColorPack(jiggle: jiggle,
                                                 isJiggleSelected: isSelected,
                                                 isDarkModeEnabled: isDarkModeEnabled,
                                                 isCreatorModeJiggleCenters: isCreatorModeJiggleCenters,
                                                 isCreatorModeAddJigglePoints: isCreatorModeAddJigglePoints,
                                                 isCreatorModeGuideCenters: isCreatorModeGuideCenters,
                                                 isCreatorModeAddGuidePoints: isCreatorModeAddGuidePoints,
                                                 isCreatorModeDeleteGuidePoints: isCreatorModeDeleteGuidePoints,
                                                 jigglePointSelectionModality: jigglePointSelectionModality)
        
        if jiggle.isShowingJiggleControlPointTanHandles {
            prepareJigglePointTanPoints(jiggle: jiggle,
                                        projectionMatrix: projectionMatrixBase,
                                        modelViewMatrix: modelViewMatrixBase,
                                        pointScale: pointScale,
                                        isPrecisePass: isPrecisePass,
                                        isBloomEnabled: isBloomEnabled,
                                        jiggleColorPack: jiggleColorPack,
                                        selectedJigglePointTanType: selectedJigglePointTanType,
                                        jigglePointTanHandlePointUnselectedStrokeBuffer: jigglePointTanHandlePointUnselectedStrokeBuffer,
                                        jigglePointTanHandlePointUnselectedFillBuffer: jigglePointTanHandlePointUnselectedFillBuffer,
                                        jigglePointTanHandlePointSelectedStrokeBuffer: jigglePointTanHandlePointSelectedStrokeBuffer,
                                        jigglePointTanHandlePointSelectedFillBuffer: jigglePointTanHandlePointSelectedFillBuffer)
        }
        
        
        if jiggle.isShowingJiggleControlPointTanHandles {
            prepareJigglePointTanLines(jiggle: jiggle,
                                       projectionMatrix: projectionMatrixBase,
                                       modelViewMatrix: modelViewMatrixBase,
                                       worldScaleStandard: worldScaleStandard,
                                       worldScalePrecise: worldScalePrecise,
                                       isPrecisePass: isPrecisePass,
                                       isBloomEnabled: isBloomEnabled,
                                       jiggleColorPack: jiggleColorPack,
                                       jigglePointTanHandleLineUnmodifiedFillBuffer: jigglePointTanHandleLineUnmodifiedFillBuffer,
                                       jigglePointTanHandleLineUnmodifiedStrokeBuffer: jigglePointTanHandleLineUnmodifiedStrokeBuffer,
                                       jigglePointTanHandleLineModifiedFillBuffer: jigglePointTanHandleLineModifiedFillBuffer,
                                       jigglePointTanHandleLineModifiedStrokeBuffer: jigglePointTanHandleLineModifiedStrokeBuffer,
                                       jigglePointTanHandleLineActiveFillBuffer: jigglePointTanHandleLineActiveFillBuffer,
                                       jigglePointTanHandleLineActiveStrokeBuffer: jigglePointTanHandleLineActiveStrokeBuffer)
        }
        
        if jiggle.isShowingGuideControlPointTanHandles {
            prepareGuidePointTanLines(jiggle: jiggle,
                                      projectionMatrix: projectionMatrixBase,
                                      modelViewMatrix: modelViewMatrixBase,
                                      worldScaleStandard: worldScaleStandard,
                                      worldScalePrecise: worldScalePrecise,
                                      isPrecisePass: isPrecisePass,
                                      isBloomEnabled: isBloomEnabled,
                                      isCreatorModeGuideCenters: isCreatorModeGuideCenters,
                                      isCreatorModeAddGuidePoints: isCreatorModeAddGuidePoints,
                                      isCreatorModeDeleteGuidePoints: isCreatorModeDeleteGuidePoints,
                                      guidePointSelectionModality: guidePointSelectionModality,
                                      jiggleColorPack: jiggleColorPack,
                                      guidePointTanHandleLineUnmodifiedFillBuffer: guidePointTanHandleLineUnmodifiedFillBuffer,
                                      guidePointTanHandleLineUnmodifiedStrokeBuffer: guidePointTanHandleLineUnmodifiedStrokeBuffer,
                                      guidePointTanHandleLineModifiedFillBuffer: guidePointTanHandleLineModifiedFillBuffer,
                                      guidePointTanHandleLineModifiedStrokeBuffer: guidePointTanHandleLineModifiedStrokeBuffer,
                                      guidePointTanHandleLineActiveFillBuffer: guidePointTanHandleLineActiveFillBuffer,
                                      guidePointTanHandleLineActiveStrokeBuffer: guidePointTanHandleLineActiveStrokeBuffer)
        }
        
        if jiggle.isShowingGuideControlPointTanHandles {
            
            guidePointTanHandlePointUnselectedStrokeBuffer.projectionMatrix = projectionMatrixBase
            guidePointTanHandlePointUnselectedStrokeBuffer.modelViewMatrix = modelViewMatrixBase
            guidePointTanHandlePointUnselectedStrokeBuffer.red = jiggleColorPack.strokeRed
            guidePointTanHandlePointUnselectedStrokeBuffer.green = jiggleColorPack.strokeGreen
            guidePointTanHandlePointUnselectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
            
            guidePointTanHandlePointUnselectedFillBuffer.projectionMatrix = projectionMatrixBase
            guidePointTanHandlePointUnselectedFillBuffer.modelViewMatrix = modelViewMatrixBase
            
            guidePointTanHandlePointSelectedStrokeBuffer.projectionMatrix = projectionMatrixBase
            guidePointTanHandlePointSelectedStrokeBuffer.modelViewMatrix = modelViewMatrixBase
            guidePointTanHandlePointSelectedStrokeBuffer.red = jiggleColorPack.strokeRed
            guidePointTanHandlePointSelectedStrokeBuffer.green = jiggleColorPack.strokeGreen
            guidePointTanHandlePointSelectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
            
            guidePointTanHandlePointSelectedFillBuffer.projectionMatrix = projectionMatrixBase
            guidePointTanHandlePointSelectedFillBuffer.modelViewMatrix = modelViewMatrixBase
            
            if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                guidePointTanHandlePointUnselectedStrokeBufferBloom.projectionMatrix = projectionMatrixBase
                guidePointTanHandlePointUnselectedStrokeBufferBloom.modelViewMatrix = modelViewMatrixBase
                guidePointTanHandlePointUnselectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
                guidePointTanHandlePointUnselectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
                guidePointTanHandlePointUnselectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
                
                guidePointTanHandlePointSelectedStrokeBufferBloom.projectionMatrix = projectionMatrixBase
                guidePointTanHandlePointSelectedStrokeBufferBloom.modelViewMatrix = modelViewMatrixBase
                guidePointTanHandlePointSelectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
                guidePointTanHandlePointSelectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
                guidePointTanHandlePointSelectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
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
                    let renderCenterPointIn = Math.Point(x: guideControlPoint.renderTanInX,
                                                         y: guideControlPoint.renderTanInY)
                    let renderCenterPointOut = Math.Point(x: guideControlPoint.renderTanOutX,
                                                          y: guideControlPoint.renderTanOutY)
                    
                    if (guideControlPoint.renderSelected == true) && (selectedGuidePointTanType == .in) {
                        
                        guidePointTanHandlePointSelectedStrokeBuffer.add(translation: renderCenterPointIn,
                                                                         scale: pointScale,
                                                                         rotation: 0.0)
                        guidePointTanHandlePointSelectedFillBuffer.add(translation: renderCenterPointIn,
                                                                       scale: pointScale,
                                                                       rotation: 0.0,
                                                                       red: guideColorPack.tanPointFillActiveRed,
                                                                       green: guideColorPack.tanPointFillActiveGreen,
                                                                       blue: guideColorPack.tanPointFillActiveBlue,
                                                                       alpha: 1.0)
                        
                        if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                            guidePointTanHandlePointSelectedStrokeBufferBloom.add(translation: renderCenterPointIn,
                                                                                  scale: pointScale,
                                                                                  rotation: 0.0)
                        }
                        
                    } else {
                        
                        guidePointTanHandlePointUnselectedStrokeBuffer.add(translation: renderCenterPointIn,
                                                                           scale: pointScale,
                                                                           rotation: 0.0)
                        if (guideControlPoint.isManualTanHandleEnabled == true) || (guideControlPoint.renderSelected == true) {
                            guidePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointIn,
                                                                             scale: pointScale,
                                                                             rotation: 0.0,
                                                                             red: guideColorPack.tanPointFillModifiedRed,
                                                                             green: guideColorPack.tanPointFillModifiedGreen,
                                                                             blue: guideColorPack.tanPointFillModifiedBlue,
                                                                             alpha: 1.0)
                        } else {
                            guidePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointIn,
                                                                             scale: pointScale,
                                                                             rotation: 0.0,
                                                                             red: guideColorPack.tanPointFillUnmodifiedRed,
                                                                             green: guideColorPack.tanPointFillUnmodifiedGreen,
                                                                             blue: guideColorPack.tanPointFillUnmodifiedBlue,
                                                                             alpha: 1.0)
                        }
                        
                        if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                            guidePointTanHandlePointUnselectedStrokeBufferBloom.add(translation: renderCenterPointIn,
                                                                                    scale: pointScale,
                                                                                    rotation: 0.0)
                        }
                    }
                    
                    if (guideControlPoint.renderSelected == true) && (selectedGuidePointTanType == .out) {
                        
                        guidePointTanHandlePointSelectedStrokeBuffer.add(translation: renderCenterPointOut,
                                                                         scale: pointScale,
                                                                         rotation: 0.0)
                        guidePointTanHandlePointSelectedFillBuffer.add(translation: renderCenterPointOut,
                                                                       scale: pointScale,
                                                                       rotation: 0.0,
                                                                       red: guideColorPack.tanPointFillActiveRed,
                                                                       green: guideColorPack.tanPointFillActiveGreen,
                                                                       blue: guideColorPack.tanPointFillActiveBlue,
                                                                       alpha: 1.0)
                        
                        if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                            guidePointTanHandlePointSelectedStrokeBufferBloom.add(translation: renderCenterPointOut,
                                                                                  scale: pointScale,
                                                                                  rotation: 0.0)
                        }
                        
                    } else {
                        
                        guidePointTanHandlePointUnselectedStrokeBuffer.add(translation: renderCenterPointOut,
                                                                           scale: pointScale,
                                                                           rotation: 0.0)
                        
                        if (guideControlPoint.isManualTanHandleEnabled == true) || (guideControlPoint.renderSelected == true) {
                            guidePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointOut,
                                                                             scale: pointScale,
                                                                             rotation: 0.0,
                                                                             red: guideColorPack.tanPointFillModifiedRed,
                                                                             green: guideColorPack.tanPointFillModifiedGreen,
                                                                             blue: guideColorPack.tanPointFillModifiedBlue,
                                                                             alpha: 1.0)
                        } else {
                            guidePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointOut,
                                                                             scale: pointScale,
                                                                             rotation: 0.0,
                                                                             red: guideColorPack.tanPointFillUnmodifiedRed,
                                                                             green: guideColorPack.tanPointFillUnmodifiedGreen,
                                                                             blue: guideColorPack.tanPointFillUnmodifiedBlue,
                                                                             alpha: 1.0)
                        }
                        
                        if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                            guidePointTanHandlePointUnselectedStrokeBufferBloom.add(translation: renderCenterPointOut,
                                                                                    scale: pointScale,
                                                                                    rotation: 0.0)
                        }
                    }
                }
            }
        }
        
        if jiggle.isShowingCenterMarker {
            prepareJiggleCenter(jiggle: jiggle,
                               worldScalePrecise: worldScalePrecise,
                               worldScaleStandard: worldScaleStandard,
                               projectionMatrix: projectionMatrixBase,
                               modelViewMatrix: modelViewMatrixBase,
                               baseAdjustRotation: baseAdjustRotation,
                               isPrecisePass: isPrecisePass,
                               isBloomEnabled: isBloomEnabled,
                               jiggleColorPack: jiggleColorPack,
                               jiggleCenterMarkerUnselectedFillInstance: jiggleCenterMarkerUnselectedFillInstance,
                               jiggleCenterMarkerUnselectedStrokeInstance: jiggleCenterMarkerUnselectedStrokeInstance,
                               jiggleCenterMarkerSelectedFillInstance: jiggleCenterMarkerSelectedFillInstance,
                               jiggleCenterMarkerSelectedStrokeInstance: jiggleCenterMarkerSelectedStrokeInstance)
        }
        
        if jiggle.isShowingWeightCenterMarker {
            prepareWeightCenter(jiggle: jiggle,
                               worldScalePrecise: worldScalePrecise,
                               worldScaleStandard: worldScaleStandard,
                               projectionMatrix: projectionMatrixBase,
                               modelViewMatrix: modelViewMatrixBase,
                               baseAdjustRotation: baseAdjustRotation,
                               isPrecisePass: isPrecisePass,
                               isBloomEnabled: isBloomEnabled,
                               jiggleColorPack: jiggleColorPack,
                               weightCenterMarkerDotUnselectedFillInstance: weightCenterMarkerDotUnselectedFillInstance,
                               weightCenterMarkerDotUnselectedStrokeInstance: weightCenterMarkerDotUnselectedStrokeInstance,
                               weightCenterMarkerDotSelectedFillInstance: weightCenterMarkerDotSelectedFillInstance,
                               weightCenterMarkerDotSelectedStrokeInstance: weightCenterMarkerDotSelectedStrokeInstance,
                               weightCenterMarkerSpinnerUnselectedFillInstance: weightCenterMarkerSpinnerUnselectedFillInstance,
                               weightCenterMarkerSpinnerUnselectedStrokeInstance: weightCenterMarkerSpinnerUnselectedStrokeInstance,
                               weightCenterMarkerSpinnerSelectedFillInstance: weightCenterMarkerSpinnerSelectedFillInstance,
                               weightCenterMarkerSpinnerSelectedStrokeInstance: weightCenterMarkerSpinnerSelectedStrokeInstance)
        }
        
        if isPrecisePass {
            jiggle.jiggleMesh.editBufferStandard_Precise.projectionMatrix = projectionMatrixBase
            jiggle.jiggleMesh.editBufferStandard_Precise.modelViewMatrix = modelViewMatrixBase
            jiggle.jiggleMesh.editBufferWeights_Precise.projectionMatrix = projectionMatrixBase
            jiggle.jiggleMesh.editBufferWeights_Precise.modelViewMatrix = modelViewMatrixBase
        } else {
            jiggle.jiggleMesh.editBufferStandard.projectionMatrix = projectionMatrixBase
            jiggle.jiggleMesh.editBufferStandard.modelViewMatrix = modelViewMatrixBase
            jiggle.jiggleMesh.editBufferWeights.projectionMatrix = projectionMatrixBase
            jiggle.jiggleMesh.editBufferWeights.modelViewMatrix = modelViewMatrixBase
            jiggle.jiggleMesh.viewBuffer.projectionMatrix = projectionMatrixBase
            jiggle.jiggleMesh.viewBuffer.modelViewMatrix = modelViewMatrixBase
            jiggle.jiggleMesh.viewBufferStereoscopic.projectionMatrix = projectionMatrixBase
            jiggle.jiggleMesh.viewBufferStereoscopic.modelViewMatrix = modelViewMatrixBase
        }
        
        if jiggle.isShowingJiggleBorderRings {
            if isPrecisePass {
                jiggle.solidLineBufferStroke_Precise.shapeBuffer.projectionMatrix = projectionMatrixBase
                jiggle.solidLineBufferStroke_Precise.shapeBuffer.modelViewMatrix = modelViewMatrixBase
                jiggle.solidLineBuffer_Precise.shapeBuffer.projectionMatrix = projectionMatrixBase
                jiggle.solidLineBuffer_Precise.shapeBuffer.modelViewMatrix = modelViewMatrixBase
            } else {
                jiggle.solidLineBufferStroke.shapeBuffer.projectionMatrix = projectionMatrixBase
                jiggle.solidLineBufferStroke.shapeBuffer.modelViewMatrix = modelViewMatrixBase
                jiggle.solidLineBuffer.shapeBuffer.projectionMatrix = projectionMatrixBase
                jiggle.solidLineBuffer.shapeBuffer.modelViewMatrix = modelViewMatrixBase
                
                if isBloomEnabled {
                    if jiggle.isShowingJiggleBorderRingsBloom {
                        jiggle.solidLineBloomBuffer.shapeBuffer.projectionMatrix = projectionMatrixBase
                        jiggle.solidLineBloomBuffer.shapeBuffer.modelViewMatrix = modelViewMatrixBase
                    }
                }
            }
        }
        
        if jiggle.isShowingGuideBorderRings {
            if isPrecisePass {
                for guideIndex in 0..<jiggle.guideCount {
                    let guide = jiggle.guides[guideIndex]
                    guide.solidLineBufferStroke_Precise.shapeBuffer.projectionMatrix = projectionMatrixBase
                    guide.solidLineBufferStroke_Precise.shapeBuffer.modelViewMatrix = modelViewMatrixBase
                    guide.solidLineBuffer_Precise.shapeBuffer.projectionMatrix = projectionMatrixBase
                    guide.solidLineBuffer_Precise.shapeBuffer.modelViewMatrix = modelViewMatrixBase
                }
            } else {
                for guideIndex in 0..<jiggle.guideCount {
                    let guide = jiggle.guides[guideIndex]
                    guide.solidLineBufferStroke.shapeBuffer.projectionMatrix = projectionMatrixBase
                    guide.solidLineBufferStroke.shapeBuffer.modelViewMatrix = modelViewMatrixBase
                    guide.solidLineBuffer.shapeBuffer.projectionMatrix = projectionMatrixBase
                    guide.solidLineBuffer.shapeBuffer.modelViewMatrix = modelViewMatrixBase
                }
                
                if isBloomEnabled && jiggle.isShowingGuideBorderRingBloom {
                    for guideIndex in 0..<jiggle.guideCount {
                        let guide = jiggle.guides[guideIndex]
                        guide.solidLineBloomBuffer.shapeBuffer.projectionMatrix = projectionMatrixBase
                        guide.solidLineBloomBuffer.shapeBuffer.modelViewMatrix = modelViewMatrixBase
                    }
                }
            }
        }
        
        if jiggle.isShowingJigglePoints {
            prepareJigglePoints(jiggle: jiggle,
                                pointScale: pointScale,
                                projectionMatrix: projectionMatrixBase,
                                modelViewMatrix: modelViewMatrixBase,
                                baseAdjustRotation: baseAdjustRotation,
                                isPrecisePass: isPrecisePass,
                                isBloomEnabled: isBloomEnabled,
                                jiggleColorPack: jiggleColorPack,
                                jigglePointUnselectedStrokeBuffer: jigglePointUnselectedStrokeBuffer,
                                jigglePointUnselectedFillBuffer: jigglePointUnselectedFillBuffer,
                                jigglePointSelectedStrokeBuffer: jigglePointSelectedStrokeBuffer,
                                jigglePointSelectedFillBuffer: jigglePointSelectedFillBuffer)
        }
        
        if jiggle.isShowingGuidePoints {
            prepareGuidePoints(jiggle: jiggle,
                               pointScale: pointScale,
                               projectionMatrix: projectionMatrixBase,
                               modelViewMatrix: modelViewMatrixBase,
                               baseAdjustRotation: baseAdjustRotation,
                               isPrecisePass: isPrecisePass,
                               isBloomEnabled: isBloomEnabled,
                               isCreatorModeGuideCenters: isCreatorModeGuideCenters,
                               isCreatorModeAddGuidePoints: isCreatorModeAddGuidePoints,
                               isCreatorModeDeleteGuidePoints: isCreatorModeDeleteGuidePoints,
                               guidePointSelectionModality: guidePointSelectionModality,
                               jiggleColorPack: jiggleColorPack,
                               guidePointUnselectedStrokeBuffer: guidePointUnselectedStrokeBuffer,
                               guidePointUnselectedFillBuffer: guidePointUnselectedFillBuffer,
                               guidePointSelectedStrokeBuffer: guidePointSelectedStrokeBuffer,
                               guidePointSelectedFillBuffer: guidePointSelectedFillBuffer)

        }
    }
    
    func renderMesh2D(jiggle: Jiggle,
                      renderEncoder: MTLRenderCommandEncoder,
                      isPrecisePass: Bool) {
        if jiggle.isShowingMeshEditStandard {
            
            //TODO: THis is for test...
            //if jiggle.currentHashMeshStandard.polyHash.triangulationType == .fast {
            //    jiggle.jiggleMesh.editBufferStandard.red = 0.9
            //    jiggle.jiggleMesh.editBufferStandard.green = 0.9
            //    jiggle.jiggleMesh.editBufferStandard.blue = 0.9
            //} else {
            //    jiggle.jiggleMesh.editBufferStandard.red = 1.0
            //    jiggle.jiggleMesh.editBufferStandard.green = 1.0
            //    jiggle.jiggleMesh.editBufferStandard.blue = 1.0
            //}
            
            if isPrecisePass {
                jiggle.jiggleMesh.editBufferStandard_Precise.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
                
            } else {
                jiggle.jiggleMesh.editBufferStandard.render(renderEncoder: renderEncoder,
                                                            pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
            }
        } else if jiggle.isShowingMeshEditWeights {
            
            //TODO: THis is for test...
            /*
             if jiggle.currentHashMeshWeights.polyHash.triangulationType == .fast {
             jiggle.jiggleMesh.editBufferWeights.red = 0.9
             jiggle.jiggleMesh.editBufferWeights.green = 0.9
             jiggle.jiggleMesh.editBufferWeights.blue = 0.9
             } else {
             jiggle.jiggleMesh.editBufferWeights.red = 1.0
             jiggle.jiggleMesh.editBufferWeights.green = 1.0
             jiggle.jiggleMesh.editBufferWeights.blue = 1.0
             }
             */
            if isPrecisePass {
                jiggle.jiggleMesh.editBufferWeights_Precise.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
            } else {
                jiggle.jiggleMesh.editBufferWeights.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeColoredIndexed2DAlphaBlending)
            }
        }
    }
    
    func renderMesh3D(jiggle: Jiggle, renderEncoder: MTLRenderCommandEncoder) {
        if jiggle.isShowingMeshViewStandard {
            
            /*
             //TODO: THis is for test...
             if jiggle.currentHashTrianglesViewStandard.polyHash.triangulationType == .fast {
             jiggle.jiggleMesh.viewBuffer.red = 1.0
             jiggle.jiggleMesh.viewBuffer.green = 0.5
             jiggle.jiggleMesh.viewBuffer.blue = 0.5
             } else {
             jiggle.jiggleMesh.viewBuffer.red = 1.0
             jiggle.jiggleMesh.viewBuffer.green = 1.0
             jiggle.jiggleMesh.viewBuffer.blue = 1.0
             }
             */
            
            jiggle.jiggleMesh.viewBuffer.render(renderEncoder: renderEncoder, pipelineState: .spriteNodeIndexed3DNoBlending)
        }
    }
    
    func renderMesh3DStereoscopicBlue(jiggle: Jiggle, renderEncoder: MTLRenderCommandEncoder) {
        if jiggle.isShowingMeshViewStereoscopic {
            jiggle.jiggleMesh.viewBufferStereoscopic.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeStereoscopicBlueIndexed3DNoBlending)
        }
    }
    func renderMesh3DStereoscopicRed(jiggle: Jiggle, renderEncoder: MTLRenderCommandEncoder) {
        if jiggle.isShowingMeshViewStereoscopic {
            jiggle.jiggleMesh.viewBufferStereoscopic.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeStereoscopicRedIndexed3DNoBlending)
        }
    }
    
    func getAdjustScale() -> Float {
        var result = Float(1.0)
        if let jiggleEngine = jiggleEngine {
            if let jiggleScene = jiggleEngine.jiggleScene {
                if fabsf(jiggleScene.sceneScale) > Math.epsilon {
                    result = (1.0 / jiggleScene.sceneScale)
                }
            }
        }
        return result
    }

    
    
}
