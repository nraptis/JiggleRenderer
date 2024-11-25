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

    @MainActor func getMarkerColorPack(isDarkModeEnabled: Bool) -> MarkerRenderColorPack {
        
        let lineFillPrimaryUnspecifiedRed: Float
        let lineFillPrimaryUnspecifiedGreen: Float
        let lineFillPrimaryUnspecifiedBlue: Float
        if isDarkModeEnabled {
            lineFillPrimaryUnspecifiedRed = JiggleTheme.guideMarkerLineDark.red
            lineFillPrimaryUnspecifiedGreen = JiggleTheme.guideMarkerLineDark.green
            lineFillPrimaryUnspecifiedBlue = JiggleTheme.guideMarkerLineDark.blue
        } else {
            lineFillPrimaryUnspecifiedRed = JiggleTheme.guideMarkerLineLight.red
            lineFillPrimaryUnspecifiedGreen = JiggleTheme.guideMarkerLineLight.green
            lineFillPrimaryUnspecifiedBlue = JiggleTheme.guideMarkerLineLight.blue
        }
        
        let lineFillPrimarySpecifiedRed: Float
        let lineFillPrimarySpecifiedGreen: Float
        let lineFillPrimarySpecifiedBlue: Float
        if isDarkModeEnabled {
            lineFillPrimarySpecifiedRed = JiggleTheme.guideMarkerLineSpecifiedDark.red
            lineFillPrimarySpecifiedGreen = JiggleTheme.guideMarkerLineSpecifiedDark.green
            lineFillPrimarySpecifiedBlue = JiggleTheme.guideMarkerLineSpecifiedDark.blue
        } else {
            lineFillPrimarySpecifiedRed = JiggleTheme.guideMarkerLineSpecifiedLight.red
            lineFillPrimarySpecifiedGreen = JiggleTheme.guideMarkerLineSpecifiedLight.green
            lineFillPrimarySpecifiedBlue = JiggleTheme.guideMarkerLineSpecifiedLight.blue
        }
        
        let lineFillSecondaryRed: Float
        let lineFillSecondaryGreen: Float
        let lineFillSecondaryBlue: Float
        if isDarkModeEnabled {
            lineFillSecondaryRed = JiggleTheme.guideMarkerLineMinorDark.red
            lineFillSecondaryGreen = JiggleTheme.guideMarkerLineMinorDark.green
            lineFillSecondaryBlue = JiggleTheme.guideMarkerLineMinorDark.blue
        } else {
            lineFillSecondaryRed = JiggleTheme.guideMarkerLineMinorLight.red
            lineFillSecondaryGreen = JiggleTheme.guideMarkerLineMinorLight.green
            lineFillSecondaryBlue = JiggleTheme.guideMarkerLineMinorLight.blue
        }
        
        let dotFillPrimaryUnspecifiedEvenRed: Float
        let dotFillPrimaryUnspecifiedEvenGreen: Float
        let dotFillPrimaryUnspecifiedEvenBlue: Float
        if isDarkModeEnabled {
            dotFillPrimaryUnspecifiedEvenRed = JiggleTheme.guideMarkerPointEvenDark.red
            dotFillPrimaryUnspecifiedEvenGreen = JiggleTheme.guideMarkerPointEvenDark.green
            dotFillPrimaryUnspecifiedEvenBlue = JiggleTheme.guideMarkerPointEvenDark.blue
        } else {
            dotFillPrimaryUnspecifiedEvenRed = JiggleTheme.guideMarkerPointEvenLight.red
            dotFillPrimaryUnspecifiedEvenGreen = JiggleTheme.guideMarkerPointEvenLight.green
            dotFillPrimaryUnspecifiedEvenBlue = JiggleTheme.guideMarkerPointEvenLight.blue
        }
        
        let dotFillPrimaryUnspecifiedOddRed: Float
        let dotFillPrimaryUnspecifiedOddGreen: Float
        let dotFillPrimaryUnspecifiedOddBlue: Float
        if isDarkModeEnabled {
            dotFillPrimaryUnspecifiedOddRed = JiggleTheme.guideMarkerPointOddDark.red
            dotFillPrimaryUnspecifiedOddGreen = JiggleTheme.guideMarkerPointOddDark.green
            dotFillPrimaryUnspecifiedOddBlue = JiggleTheme.guideMarkerPointOddDark.blue
        } else {
            dotFillPrimaryUnspecifiedOddRed = JiggleTheme.guideMarkerPointOddLight.red
            dotFillPrimaryUnspecifiedOddGreen = JiggleTheme.guideMarkerPointOddLight.green
            dotFillPrimaryUnspecifiedOddBlue = JiggleTheme.guideMarkerPointOddLight.blue
        }
        
        let dotFillPrimarySpecifiedEvenRed: Float
        let dotFillPrimarySpecifiedEvenGreen: Float
        let dotFillPrimarySpecifiedEvenBlue: Float
        if isDarkModeEnabled {
            dotFillPrimarySpecifiedEvenRed = JiggleTheme.guideMarkerPointSpecifiedEvenDark.red
            dotFillPrimarySpecifiedEvenGreen = JiggleTheme.guideMarkerPointSpecifiedEvenDark.green
            dotFillPrimarySpecifiedEvenBlue = JiggleTheme.guideMarkerPointSpecifiedEvenDark.blue
        } else {
            dotFillPrimarySpecifiedEvenRed = JiggleTheme.guideMarkerPointSpecifiedEvenLight.red
            dotFillPrimarySpecifiedEvenGreen = JiggleTheme.guideMarkerPointSpecifiedEvenLight.green
            dotFillPrimarySpecifiedEvenBlue = JiggleTheme.guideMarkerPointSpecifiedEvenLight.blue
        }
        
        let dotFillPrimarySpecifiedOddRed: Float
        let dotFillPrimarySpecifiedOddGreen: Float
        let dotFillPrimarySpecifiedOddBlue: Float
        if isDarkModeEnabled {
            dotFillPrimarySpecifiedOddRed = JiggleTheme.guideMarkerPointSpecifiedOddDark.red
            dotFillPrimarySpecifiedOddGreen = JiggleTheme.guideMarkerPointSpecifiedOddDark.green
            dotFillPrimarySpecifiedOddBlue = JiggleTheme.guideMarkerPointSpecifiedOddDark.blue
        } else {
            dotFillPrimarySpecifiedOddRed = JiggleTheme.guideMarkerPointSpecifiedOddLight.red
            dotFillPrimarySpecifiedOddGreen = JiggleTheme.guideMarkerPointSpecifiedOddLight.green
            dotFillPrimarySpecifiedOddBlue = JiggleTheme.guideMarkerPointSpecifiedOddLight.blue
        }
        
        let dotFillSecondaryEvenRed: Float
        let dotFillSecondaryEvenGreen: Float
        let dotFillSecondaryEvenBlue: Float
        if isDarkModeEnabled {
            dotFillSecondaryEvenRed = JiggleTheme.guideMarkerPointMinorEvenDark.red
            dotFillSecondaryEvenGreen = JiggleTheme.guideMarkerPointMinorEvenDark.green
            dotFillSecondaryEvenBlue = JiggleTheme.guideMarkerPointMinorEvenDark.blue
        } else {
            dotFillSecondaryEvenRed = JiggleTheme.guideMarkerPointMinorEvenLight.red
            dotFillSecondaryEvenGreen = JiggleTheme.guideMarkerPointMinorEvenLight.green
            dotFillSecondaryEvenBlue = JiggleTheme.guideMarkerPointMinorEvenLight.blue
        }
        
        let dotFillSecondaryOddRed: Float
        let dotFillSecondaryOddGreen: Float
        let dotFillSecondaryOddBlue: Float
        if isDarkModeEnabled {
            dotFillSecondaryOddRed = JiggleTheme.guideMarkerPointMinorOddDark.red
            dotFillSecondaryOddGreen = JiggleTheme.guideMarkerPointMinorOddDark.green
            dotFillSecondaryOddBlue = JiggleTheme.guideMarkerPointMinorOddDark.blue
        } else {
            dotFillSecondaryOddRed = JiggleTheme.guideMarkerPointMinorOddLight.red
            dotFillSecondaryOddGreen = JiggleTheme.guideMarkerPointMinorOddLight.green
            dotFillSecondaryOddBlue = JiggleTheme.guideMarkerPointMinorOddLight.blue
        }
        
        return MarkerRenderColorPack(lineFillPrimaryUnspecifiedRed: lineFillPrimaryUnspecifiedRed,
                                     lineFillPrimaryUnspecifiedGreen: lineFillPrimaryUnspecifiedGreen,
                                     lineFillPrimaryUnspecifiedBlue: lineFillPrimaryUnspecifiedBlue,
                                     lineFillPrimarySpecifiedRed: lineFillPrimarySpecifiedRed,
                                     lineFillPrimarySpecifiedGreen: lineFillPrimarySpecifiedGreen,
                                     lineFillPrimarySpecifiedBlue: lineFillPrimarySpecifiedBlue,
                                     lineFillSecondaryRed: lineFillSecondaryRed,
                                     lineFillSecondaryGreen: lineFillSecondaryGreen,
                                     lineFillSecondaryBlue: lineFillSecondaryBlue,
                                     dotFillPrimaryUnspecifiedOddRed: dotFillPrimaryUnspecifiedOddRed,
                                     dotFillPrimaryUnspecifiedOddGreen: dotFillPrimaryUnspecifiedOddGreen,
                                     dotFillPrimaryUnspecifiedOddBlue: dotFillPrimaryUnspecifiedOddBlue,
                                     
                                     dotFillPrimaryUnspecifiedEvenRed: dotFillPrimaryUnspecifiedEvenRed,
                                     dotFillPrimaryUnspecifiedEvenGreen: dotFillPrimaryUnspecifiedEvenGreen,
                                     dotFillPrimaryUnspecifiedEvenBlue: dotFillPrimaryUnspecifiedEvenBlue,
                                     
                                     
                                     dotFillPrimarySpecifiedOddRed: dotFillPrimarySpecifiedOddRed,
                                     dotFillPrimarySpecifiedOddGreen: dotFillPrimarySpecifiedOddGreen,
                                     dotFillPrimarySpecifiedOddBlue: dotFillPrimarySpecifiedOddBlue,
                                     
                                     dotFillPrimarySpecifiedEvenRed: dotFillPrimarySpecifiedEvenRed,
                                     dotFillPrimarySpecifiedEvenGreen: dotFillPrimarySpecifiedEvenGreen,
                                     dotFillPrimarySpecifiedEvenBlue: dotFillPrimarySpecifiedEvenBlue,
                                     
                                     dotFillSecondaryOddRed: dotFillSecondaryOddRed,
                                     dotFillSecondaryOddGreen: dotFillSecondaryOddGreen,
                                     dotFillSecondaryOddBlue: dotFillSecondaryOddBlue,
                                     dotFillSecondaryEvenRed: dotFillSecondaryEvenRed,
                                     dotFillSecondaryEvenGreen: dotFillSecondaryEvenGreen,
                                     dotFillSecondaryEvenBlue: dotFillSecondaryEvenBlue)
    }
    
    @MainActor func getJiggleColorPack(jiggle: Jiggle,
                                       isJiggleSelected: Bool,
                                       isDarkModeEnabled: Bool,
                                       isCreatorModeJiggleCenters: Bool,
                                       isCreatorModeAddJigglePoints: Bool,
                                       isCreatorModeGuideCenters: Bool,
                                       isCreatorModeAddGuidePoints: Bool,
                                       isCreatorModeDeleteGuidePoints: Bool,
                                       jigglePointSelectionModality: PointSelectionModality) -> JiggleRenderColorPack {
        
        var isDisplayingAsFrozen = false
        var isDisplayingAsSelected = false
        
        if jiggle.isFrozen {
            isDisplayingAsFrozen = true
        } else {
            if isJiggleSelected {
                if isCreatorModeJiggleCenters {
                    isDisplayingAsFrozen = true
                } else {
                    isDisplayingAsSelected = true
                }
            } else {
                if isCreatorModeDeleteGuidePoints || isCreatorModeJiggleCenters || isCreatorModeAddJigglePoints || isCreatorModeGuideCenters {
                    isDisplayingAsFrozen = true
                }
            }
        }
        
        // Just the regular stroke...
        let regularStrokeRed: Float
        let regularStrokeGreen: Float
        let regularStrokeBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                regularStrokeRed = JiggleTheme.outlineFrozenStrokeDark.red
                regularStrokeGreen = JiggleTheme.outlineFrozenStrokeDark.green
                regularStrokeBlue = JiggleTheme.outlineFrozenStrokeDark.blue
            } else {
                regularStrokeRed = JiggleTheme.outlineFrozenStrokeLight.red
                regularStrokeGreen = JiggleTheme.outlineFrozenStrokeLight.green
                regularStrokeBlue = JiggleTheme.outlineFrozenStrokeLight.blue
            }
        } else if isDisplayingAsSelected {
            if isDarkModeEnabled {
                regularStrokeRed = JiggleTheme.outlineSelectedStrokeDark.red
                regularStrokeGreen = JiggleTheme.outlineSelectedStrokeDark.green
                regularStrokeBlue = JiggleTheme.outlineSelectedStrokeDark.blue
            } else {
                regularStrokeRed = JiggleTheme.outlineSelectedStrokeLight.red
                regularStrokeGreen = JiggleTheme.outlineSelectedStrokeLight.green
                regularStrokeBlue = JiggleTheme.outlineSelectedStrokeLight.blue
            }
        } else {
            if isDarkModeEnabled {
                regularStrokeRed = JiggleTheme.outlineUnselectedStrokeDark.red
                regularStrokeGreen = JiggleTheme.outlineUnselectedStrokeDark.green
                regularStrokeBlue = JiggleTheme.outlineUnselectedStrokeDark.blue
            } else {
                regularStrokeRed = JiggleTheme.outlineUnselectedStrokeLight.red
                regularStrokeGreen = JiggleTheme.outlineUnselectedStrokeLight.green
                regularStrokeBlue = JiggleTheme.outlineUnselectedStrokeLight.blue
            }
        }
        
        // Just the regular fill...
        let regularFillRed: Float
        let regularFillGreen: Float
        let regularFillBlue: Float
        if isDisplayingAsFrozen || (jigglePointSelectionModality == .tans) {
            if isDarkModeEnabled {
                regularFillRed = JiggleTheme.outlineFrozenFillDark.red
                regularFillGreen = JiggleTheme.outlineFrozenFillDark.green
                regularFillBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                regularFillRed = JiggleTheme.outlineFrozenFillLight.red
                regularFillGreen = JiggleTheme.outlineFrozenFillLight.green
                regularFillBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else if isDisplayingAsSelected {
            if isDarkModeEnabled {
                regularFillRed = JiggleTheme.outlineSelectedFillDark.red
                regularFillGreen = JiggleTheme.outlineSelectedFillDark.green
                regularFillBlue = JiggleTheme.outlineSelectedFillDark.blue
            } else {
                regularFillRed = JiggleTheme.outlineSelectedFillLight.red
                regularFillGreen = JiggleTheme.outlineSelectedFillLight.green
                regularFillBlue = JiggleTheme.outlineSelectedFillLight.blue
            }
        } else {
            if isDarkModeEnabled {
                regularFillRed = JiggleTheme.outlineUnselectedFillDark.red
                regularFillGreen = JiggleTheme.outlineUnselectedFillDark.green
                regularFillBlue = JiggleTheme.outlineUnselectedFillDark.blue
            } else {
                regularFillRed = JiggleTheme.outlineUnselectedFillLight.red
                regularFillGreen = JiggleTheme.outlineUnselectedFillLight.green
                regularFillBlue = JiggleTheme.outlineUnselectedFillLight.blue
            }
        }
        
        // Just the selected fill...
        let selectedFillRed: Float
        let selectedFillGreen: Float
        let selectedFillBlue: Float
        if isDisplayingAsFrozen || (jigglePointSelectionModality == .tans) {
            if isDarkModeEnabled {
                selectedFillRed = JiggleTheme.outlineFrozenFillDark.red
                selectedFillGreen = JiggleTheme.outlineFrozenFillDark.green
                selectedFillBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                selectedFillRed = JiggleTheme.outlineFrozenFillLight.red
                selectedFillGreen = JiggleTheme.outlineFrozenFillLight.green
                selectedFillBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDarkModeEnabled {
                selectedFillRed = JiggleTheme.pointSelectedOutlineDark.red
                selectedFillGreen = JiggleTheme.pointSelectedOutlineDark.green
                selectedFillBlue = JiggleTheme.pointSelectedOutlineDark.blue
            } else {
                selectedFillRed = JiggleTheme.pointSelectedOutlineLight.red
                selectedFillGreen = JiggleTheme.pointSelectedOutlineLight.green
                selectedFillBlue = JiggleTheme.pointSelectedOutlineLight.blue
            }
        }
        
        
        // Just the modified fill...
        let fillModifiedRed: Float
        let fillModifiedGreen: Float
        let fillModifiedBlue: Float
        if isDisplayingAsFrozen || (jigglePointSelectionModality == .tans) {
            if isDarkModeEnabled {
                fillModifiedRed = JiggleTheme.outlineFrozenFillDark.red
                fillModifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                fillModifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                fillModifiedRed = JiggleTheme.outlineFrozenFillLight.red
                fillModifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                fillModifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    fillModifiedRed = JiggleTheme.outlineSelectedModifiedFillDark.red
                    fillModifiedGreen = JiggleTheme.outlineSelectedModifiedFillDark.green
                    fillModifiedBlue = JiggleTheme.outlineSelectedModifiedFillDark.blue
                } else {
                    fillModifiedRed = JiggleTheme.outlineSelectedModifiedFillLight.red
                    fillModifiedGreen = JiggleTheme.outlineSelectedModifiedFillLight.green
                    fillModifiedBlue = JiggleTheme.outlineSelectedModifiedFillLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    fillModifiedRed = JiggleTheme.outlineUnselectedModifiedFillDark.red
                    fillModifiedGreen = JiggleTheme.outlineUnselectedModifiedFillDark.green
                    fillModifiedBlue = JiggleTheme.outlineUnselectedModifiedFillDark.blue
                } else {
                    fillModifiedRed = JiggleTheme.outlineUnselectedModifiedFillLight.red
                    fillModifiedGreen = JiggleTheme.outlineUnselectedModifiedFillLight.green
                    fillModifiedBlue = JiggleTheme.outlineUnselectedModifiedFillLight.blue
                }
            }
            
        }
        
        
        // Just the bloom...
        let bloomRed: Float
        let bloomGreen: Float
        let bloomBlue: Float
        if isDarkModeEnabled {
            bloomRed = JiggleTheme.bloomGlowDark.red
            bloomGreen = JiggleTheme.bloomGlowDark.green
            bloomBlue = JiggleTheme.bloomGlowDark.blue
        } else {
            bloomRed = JiggleTheme.bloomGlowLight.red
            bloomGreen = JiggleTheme.bloomGlowLight.green
            bloomBlue = JiggleTheme.bloomGlowLight.blue
        }
        
        
        let fillWeightCenterRed: Float
        let fillWeightCenterGreen: Float
        let fillWeightCenterBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                fillWeightCenterRed = JiggleTheme.outlineFrozenFillDark.red
                fillWeightCenterGreen = JiggleTheme.outlineFrozenFillDark.green
                fillWeightCenterBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                fillWeightCenterRed = JiggleTheme.outlineFrozenFillLight.red
                fillWeightCenterGreen = JiggleTheme.outlineFrozenFillLight.green
                fillWeightCenterBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else if isDisplayingAsSelected {
            if isDarkModeEnabled {
                fillWeightCenterRed = JiggleTheme.guideSelectedCenterMarkerDark.red
                fillWeightCenterGreen = JiggleTheme.guideSelectedCenterMarkerDark.green
                fillWeightCenterBlue = JiggleTheme.guideSelectedCenterMarkerDark.blue
            } else {
                fillWeightCenterRed = JiggleTheme.guideSelectedCenterMarkerLight.red
                fillWeightCenterGreen = JiggleTheme.guideSelectedCenterMarkerLight.green
                fillWeightCenterBlue = JiggleTheme.guideSelectedCenterMarkerLight.blue
            }
        } else {
            if isDarkModeEnabled {
                fillWeightCenterRed = JiggleTheme.guideUnselectedCenterMarkerDark.red
                fillWeightCenterGreen = JiggleTheme.guideUnselectedCenterMarkerDark.green
                fillWeightCenterBlue = JiggleTheme.guideUnselectedCenterMarkerDark.blue
            } else {
                fillWeightCenterRed = JiggleTheme.guideUnselectedCenterMarkerLight.red
                fillWeightCenterGreen = JiggleTheme.guideUnselectedCenterMarkerLight.green
                fillWeightCenterBlue = JiggleTheme.guideUnselectedCenterMarkerLight.blue
            }
        }
        
        
        
        let tanLineFillUnmodifiedRed: Float
        let tanLineFillUnmodifiedGreen: Float
        let tanLineFillUnmodifiedBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanLineFillUnmodifiedRed = JiggleTheme.outlineFrozenFillDark.red
                tanLineFillUnmodifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                tanLineFillUnmodifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanLineFillUnmodifiedRed = JiggleTheme.outlineFrozenFillLight.red
                tanLineFillUnmodifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                tanLineFillUnmodifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    tanLineFillUnmodifiedRed = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedDark.red
                    tanLineFillUnmodifiedGreen = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedDark.green
                    tanLineFillUnmodifiedBlue = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedDark.blue
                } else {
                    tanLineFillUnmodifiedRed = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedLight.red
                    tanLineFillUnmodifiedGreen = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedLight.green
                    tanLineFillUnmodifiedBlue = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    tanLineFillUnmodifiedRed = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedDark.red
                    tanLineFillUnmodifiedGreen = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedDark.green
                    tanLineFillUnmodifiedBlue = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedDark.blue
                } else {
                    tanLineFillUnmodifiedRed = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedLight.red
                    tanLineFillUnmodifiedGreen = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedLight.green
                    tanLineFillUnmodifiedBlue = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedLight.blue
                }
            }
        }
        
        let tanLineFillModifiedRed: Float
        let tanLineFillModifiedGreen: Float
        let tanLineFillModifiedBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanLineFillModifiedRed = JiggleTheme.outlineFrozenFillDark.red
                tanLineFillModifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                tanLineFillModifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanLineFillModifiedRed = JiggleTheme.outlineFrozenFillLight.red
                tanLineFillModifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                tanLineFillModifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    tanLineFillModifiedRed = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedDark.red
                    tanLineFillModifiedGreen = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedDark.green
                    tanLineFillModifiedBlue = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedDark.blue
                } else {
                    tanLineFillModifiedRed = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedLight.red
                    tanLineFillModifiedGreen = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedLight.green
                    tanLineFillModifiedBlue = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    tanLineFillModifiedRed = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedDark.red
                    tanLineFillModifiedGreen = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedDark.green
                    tanLineFillModifiedBlue = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedDark.blue
                } else {
                    tanLineFillModifiedRed = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedLight.red
                    tanLineFillModifiedGreen = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedLight.green
                    tanLineFillModifiedBlue = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedLight.blue
                }
            }
        }
        
        let tanLineFillActiveRed: Float
        let tanLineFillActiveGreen: Float
        let tanLineFillActiveBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanLineFillActiveRed = JiggleTheme.outlineFrozenFillDark.red
                tanLineFillActiveGreen = JiggleTheme.outlineFrozenFillDark.green
                tanLineFillActiveBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanLineFillActiveRed = JiggleTheme.outlineFrozenFillLight.red
                tanLineFillActiveGreen = JiggleTheme.outlineFrozenFillLight.green
                tanLineFillActiveBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDarkModeEnabled {
                tanLineFillActiveRed = JiggleTheme.jiggleTanHandleLineFillSelectedActiveDark.red
                tanLineFillActiveGreen = JiggleTheme.jiggleTanHandleLineFillSelectedActiveDark.green
                tanLineFillActiveBlue = JiggleTheme.jiggleTanHandleLineFillSelectedActiveDark.blue
            } else {
                tanLineFillActiveRed = JiggleTheme.jiggleTanHandleLineFillSelectedActiveLight.red
                tanLineFillActiveGreen = JiggleTheme.jiggleTanHandleLineFillSelectedActiveLight.green
                tanLineFillActiveBlue = JiggleTheme.jiggleTanHandleLineFillSelectedActiveLight.blue
            }
        }
        
        let tanPointFillUnmodifiedRed: Float
        let tanPointFillUnmodifiedGreen: Float
        let tanPointFillUnmodifiedBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanPointFillUnmodifiedRed = JiggleTheme.outlineFrozenFillDark.red
                tanPointFillUnmodifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                tanPointFillUnmodifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanPointFillUnmodifiedRed = JiggleTheme.outlineFrozenFillLight.red
                tanPointFillUnmodifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                tanPointFillUnmodifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    tanPointFillUnmodifiedRed = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedDark.red
                    tanPointFillUnmodifiedGreen = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedDark.green
                    tanPointFillUnmodifiedBlue = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedDark.blue
                } else {
                    tanPointFillUnmodifiedRed = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedLight.red
                    tanPointFillUnmodifiedGreen = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedLight.green
                    tanPointFillUnmodifiedBlue = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    tanPointFillUnmodifiedRed = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedDark.red
                    tanPointFillUnmodifiedGreen = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedDark.green
                    tanPointFillUnmodifiedBlue = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedDark.blue
                } else {
                    tanPointFillUnmodifiedRed = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedLight.red
                    tanPointFillUnmodifiedGreen = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedLight.green
                    tanPointFillUnmodifiedBlue = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedLight.blue
                }
            }
        }
        
        let tanPointFillModifiedRed: Float
        let tanPointFillModifiedGreen: Float
        let tanPointFillModifiedBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanPointFillModifiedRed = JiggleTheme.outlineFrozenFillDark.red
                tanPointFillModifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                tanPointFillModifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanPointFillModifiedRed = JiggleTheme.outlineFrozenFillLight.red
                tanPointFillModifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                tanPointFillModifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    tanPointFillModifiedRed = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedDark.red
                    tanPointFillModifiedGreen = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedDark.green
                    tanPointFillModifiedBlue = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedDark.blue
                } else {
                    tanPointFillModifiedRed = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedLight.red
                    tanPointFillModifiedGreen = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedLight.green
                    tanPointFillModifiedBlue = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    tanPointFillModifiedRed = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedDark.red
                    tanPointFillModifiedGreen = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedDark.green
                    tanPointFillModifiedBlue = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedDark.blue
                } else {
                    tanPointFillModifiedRed = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedLight.red
                    tanPointFillModifiedGreen = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedLight.green
                    tanPointFillModifiedBlue = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedLight.blue
                }
            }
        }
        
        let tanPointFillActiveRed: Float
        let tanPointFillActiveGreen: Float
        let tanPointFillActiveBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanPointFillActiveRed = JiggleTheme.outlineFrozenFillDark.red
                tanPointFillActiveGreen = JiggleTheme.outlineFrozenFillDark.green
                tanPointFillActiveBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanPointFillActiveRed = JiggleTheme.outlineFrozenFillLight.red
                tanPointFillActiveGreen = JiggleTheme.outlineFrozenFillLight.green
                tanPointFillActiveBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDarkModeEnabled {
                tanPointFillActiveRed = JiggleTheme.jiggleTanHandlePointFillSelectedActiveDark.red
                tanPointFillActiveGreen = JiggleTheme.jiggleTanHandlePointFillSelectedActiveDark.green
                tanPointFillActiveBlue = JiggleTheme.jiggleTanHandlePointFillSelectedActiveDark.blue
            } else {
                tanPointFillActiveRed = JiggleTheme.jiggleTanHandlePointFillSelectedActiveLight.red
                tanPointFillActiveGreen = JiggleTheme.jiggleTanHandlePointFillSelectedActiveLight.green
                tanPointFillActiveBlue = JiggleTheme.jiggleTanHandlePointFillSelectedActiveLight.blue
            }
        }
        
        
        return JiggleRenderColorPack(strokeRed: regularStrokeRed,
                                     strokeGreen: regularStrokeGreen,
                                     strokeBlue: regularStrokeBlue,
                                     
                                     fillUnselectedRed: regularFillRed,
                                     fillUnselectedGreen: regularFillGreen,
                                     fillUnselectedBlue: regularFillBlue,
                                     
                                     fillSelectedRed: selectedFillRed,
                                     fillSelectedGreen: selectedFillGreen,
                                     fillSelectedBlue: selectedFillBlue,
                                     
                                     fillModifiedRed: fillModifiedRed,
                                     fillModifiedGreen: fillModifiedGreen,
                                     fillModifiedBlue: fillModifiedBlue,
                                     
                                     fillWeightCenterRed: fillWeightCenterRed,
                                     fillWeightCenterGreen: fillWeightCenterGreen,
                                     fillWeightCenterBlue: fillWeightCenterBlue,
                                     
                                     tanLineFillUnmodifiedRed: tanLineFillUnmodifiedRed,
                                     tanLineFillUnmodifiedGreen: tanLineFillUnmodifiedGreen,
                                     tanLineFillUnmodifiedBlue: tanLineFillUnmodifiedBlue,
                                     
                                     tanLineFillModifiedRed: tanLineFillModifiedRed,
                                     tanLineFillModifiedGreen: tanLineFillModifiedGreen,
                                     tanLineFillModifiedBlue: tanLineFillModifiedBlue,
                                     
                                     tanLineFillActiveRed: tanLineFillActiveRed,
                                     tanLineFillActiveGreen: tanLineFillActiveGreen,
                                     tanLineFillActiveBlue: tanLineFillActiveBlue,
                                     
                                     tanPointFillUnmodifiedRed: tanPointFillUnmodifiedRed,
                                     tanPointFillUnmodifiedGreen: tanPointFillUnmodifiedGreen,
                                     tanPointFillUnmodifiedBlue: tanPointFillUnmodifiedBlue,
                                     
                                     tanPointFillModifiedRed: tanPointFillModifiedRed,
                                     tanPointFillModifiedGreen: tanPointFillModifiedGreen,
                                     tanPointFillModifiedBlue: tanPointFillModifiedBlue,
                                     
                                     tanPointFillActiveRed: tanPointFillActiveRed,
                                     tanPointFillActiveGreen: tanPointFillActiveGreen,
                                     tanPointFillActiveBlue: tanPointFillActiveBlue,
                                     
                                     bloomRed: bloomRed,
                                     bloomGreen: bloomGreen,
                                     bloomBlue: bloomBlue)
    }
    
    @MainActor func getGuideColorPack(jiggle: Jiggle,
                                      isJiggleSelected: Bool,
                                      isDarkModeEnabled: Bool,
                                      guide: Guide,
                                      guideIndex: Int,
                                      isCreatorModeGuideCenters: Bool,
                                      isCreatorModeAddGuidePoints: Bool,
                                      isCreatorModeDeleteGuidePoints: Bool,
                                      guidePointSelectionModality: PointSelectionModality) -> GuideRenderColorPack {
        
        let weightDepthIndex = jiggle.getWeightDepthIndex(guide: guide)
        
        var isGuideSelected = false
        if isJiggleSelected {
            if jiggle.selectedWeightCurveControlIndex == (guideIndex + 1) {
                isGuideSelected = true
            }
        }
        
        
        let regularFillRed: Float
        let regularFillGreen: Float
        let regularFillBlue: Float
        let regularStrokeRed: Float
        let regularStrokeGreen: Float
        let regularStrokeBlue: Float
        let selectedFillRed: Float
        let selectedFillGreen: Float
        let selectedFillBlue: Float
        
        var isDisplayingAsFrozen = false
        var isDisplayingAsSelected = false
        
        if (jiggle.isFrozen == true) ||
            (guide.isFrozen == true) ||
            (isCreatorModeGuideCenters == true) ||
            ((isCreatorModeAddGuidePoints == true) && (isGuideSelected == false)) {
            
            isDisplayingAsFrozen = true
        } else {
            if isGuideSelected {
                isDisplayingAsSelected = true
            }
        }
        
        if isDisplayingAsFrozen {
            
            // The frozen case...
            
            if isDarkModeEnabled {
                regularStrokeRed = JiggleTheme.outlineFrozenStrokeDark.red
                regularStrokeGreen = JiggleTheme.outlineFrozenStrokeDark.green
                regularStrokeBlue = JiggleTheme.outlineFrozenStrokeDark.blue
                regularFillRed = JiggleTheme.outlineFrozenFillDark.red
                regularFillGreen = JiggleTheme.outlineFrozenFillDark.green
                regularFillBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                regularStrokeRed = JiggleTheme.outlineFrozenStrokeLight.red
                regularStrokeGreen = JiggleTheme.outlineFrozenStrokeLight.green
                regularStrokeBlue = JiggleTheme.outlineFrozenStrokeLight.blue
                regularFillRed = JiggleTheme.outlineFrozenFillLight.red
                regularFillGreen = JiggleTheme.outlineFrozenFillLight.green
                regularFillBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
            
            
        } else {
            
            // The not frozen case...
            
            if isDarkModeEnabled {
                regularStrokeRed = JiggleTheme.outlineUnselectedStrokeDark.red
                regularStrokeGreen = JiggleTheme.outlineUnselectedStrokeDark.green
                regularStrokeBlue = JiggleTheme.outlineUnselectedStrokeDark.blue
            } else {
                regularStrokeRed = JiggleTheme.outlineUnselectedStrokeLight.red
                regularStrokeGreen = JiggleTheme.outlineUnselectedStrokeLight.green
                regularStrokeBlue = JiggleTheme.outlineUnselectedStrokeLight.blue
            }
            
            if guidePointSelectionModality == .tans {
                if isDarkModeEnabled {
                    regularFillRed = JiggleTheme.outlineFrozenFillDark.red
                    regularFillGreen = JiggleTheme.outlineFrozenFillDark.green
                    regularFillBlue = JiggleTheme.outlineFrozenFillDark.blue
                } else {
                    regularFillRed = JiggleTheme.outlineFrozenFillLight.red
                    regularFillGreen = JiggleTheme.outlineFrozenFillLight.green
                    regularFillBlue = JiggleTheme.outlineFrozenFillLight.blue
                }
            } else {
                
                
                if isDisplayingAsSelected {
                    if jiggle.guideCount == 5 {
                        if weightDepthIndex == 4 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected5Dark5.red
                                regularFillGreen = JiggleTheme.guideSelected5Dark5.green
                                regularFillBlue = JiggleTheme.guideSelected5Dark5.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected5Light5.red
                                regularFillGreen = JiggleTheme.guideSelected5Light5.green
                                regularFillBlue = JiggleTheme.guideSelected5Light5.blue
                            }
                        } else if weightDepthIndex == 3 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected5Dark4.red
                                regularFillGreen = JiggleTheme.guideSelected5Dark4.green
                                regularFillBlue = JiggleTheme.guideSelected5Dark4.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected5Light4.red
                                regularFillGreen = JiggleTheme.guideSelected5Light4.green
                                regularFillBlue = JiggleTheme.guideSelected5Light4.blue
                            }
                        } else if weightDepthIndex == 2 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected5Dark3.red
                                regularFillGreen = JiggleTheme.guideSelected5Dark3.green
                                regularFillBlue = JiggleTheme.guideSelected5Dark3.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected5Light3.red
                                regularFillGreen = JiggleTheme.guideSelected5Light3.green
                                regularFillBlue = JiggleTheme.guideSelected5Light3.blue
                            }
                        } else if weightDepthIndex == 1 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected5Dark2.red
                                regularFillGreen = JiggleTheme.guideSelected5Dark2.green
                                regularFillBlue = JiggleTheme.guideSelected5Dark2.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected5Light2.red
                                regularFillGreen = JiggleTheme.guideSelected5Light2.green
                                regularFillBlue = JiggleTheme.guideSelected5Light2.blue
                            }
                        } else {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected5Dark1.red
                                regularFillGreen = JiggleTheme.guideSelected5Dark1.green
                                regularFillBlue = JiggleTheme.guideSelected5Dark1.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected5Light1.red
                                regularFillGreen = JiggleTheme.guideSelected5Light1.green
                                regularFillBlue = JiggleTheme.guideSelected5Light1.blue
                            }
                        }
                    } else if jiggle.guideCount == 4 {
                        if weightDepthIndex == 3 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected4Dark4.red
                                regularFillGreen = JiggleTheme.guideSelected4Dark4.green
                                regularFillBlue = JiggleTheme.guideSelected4Dark4.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected4Light4.red
                                regularFillGreen = JiggleTheme.guideSelected4Light4.green
                                regularFillBlue = JiggleTheme.guideSelected4Light4.blue
                            }
                        } else if weightDepthIndex == 2 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected4Dark3.red
                                regularFillGreen = JiggleTheme.guideSelected4Dark3.green
                                regularFillBlue = JiggleTheme.guideSelected4Dark3.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected4Light3.red
                                regularFillGreen = JiggleTheme.guideSelected4Light3.green
                                regularFillBlue = JiggleTheme.guideSelected4Light3.blue
                            }
                        } else if weightDepthIndex == 1 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected4Dark2.red
                                regularFillGreen = JiggleTheme.guideSelected4Dark2.green
                                regularFillBlue = JiggleTheme.guideSelected4Dark2.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected4Light2.red
                                regularFillGreen = JiggleTheme.guideSelected4Light2.green
                                regularFillBlue = JiggleTheme.guideSelected4Light2.blue
                            }
                        } else {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected4Dark1.red
                                regularFillGreen = JiggleTheme.guideSelected4Dark1.green
                                regularFillBlue = JiggleTheme.guideSelected4Dark1.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected4Light1.red
                                regularFillGreen = JiggleTheme.guideSelected4Light1.green
                                regularFillBlue = JiggleTheme.guideSelected4Light1.blue
                            }
                        }
                    } else if jiggle.guideCount == 3 {
                        if weightDepthIndex == 2 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected3Dark3.red
                                regularFillGreen = JiggleTheme.guideSelected3Dark3.green
                                regularFillBlue = JiggleTheme.guideSelected3Dark3.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected3Light3.red
                                regularFillGreen = JiggleTheme.guideSelected3Light3.green
                                regularFillBlue = JiggleTheme.guideSelected3Light3.blue
                            }
                        } else if weightDepthIndex == 1 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected3Dark2.red
                                regularFillGreen = JiggleTheme.guideSelected3Dark2.green
                                regularFillBlue = JiggleTheme.guideSelected3Dark2.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected3Light2.red
                                regularFillGreen = JiggleTheme.guideSelected3Light2.green
                                regularFillBlue = JiggleTheme.guideSelected3Light2.blue
                            }
                        } else {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected3Dark1.red
                                regularFillGreen = JiggleTheme.guideSelected3Dark1.green
                                regularFillBlue = JiggleTheme.guideSelected3Dark1.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected3Light1.red
                                regularFillGreen = JiggleTheme.guideSelected3Light1.green
                                regularFillBlue = JiggleTheme.guideSelected3Light1.blue
                            }
                        }
                    } else if jiggle.guideCount == 2 {
                        if weightDepthIndex == 1 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected2Dark2.red
                                regularFillGreen = JiggleTheme.guideSelected2Dark2.green
                                regularFillBlue = JiggleTheme.guideSelected2Dark2.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected2Light2.red
                                regularFillGreen = JiggleTheme.guideSelected2Light2.green
                                regularFillBlue = JiggleTheme.guideSelected2Light2.blue
                            }
                        } else {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideSelected2Dark1.red
                                regularFillGreen = JiggleTheme.guideSelected2Dark1.green
                                regularFillBlue = JiggleTheme.guideSelected2Dark1.blue
                            } else {
                                regularFillRed = JiggleTheme.guideSelected2Light1.red
                                regularFillGreen = JiggleTheme.guideSelected2Light1.green
                                regularFillBlue = JiggleTheme.guideSelected2Light1.blue
                            }
                        }
                    } else {
                        if isDarkModeEnabled {
                            regularFillRed = JiggleTheme.guideSelected1Dark1.red
                            regularFillGreen = JiggleTheme.guideSelected1Dark1.green
                            regularFillBlue = JiggleTheme.guideSelected1Dark1.blue
                        } else {
                            regularFillRed = JiggleTheme.guideSelected1Light1.red
                            regularFillGreen = JiggleTheme.guideSelected1Light1.green
                            regularFillBlue = JiggleTheme.guideSelected1Light1.blue
                        }
                    }
                } else {
                    if jiggle.guideCount == 5 {
                        if weightDepthIndex == 4 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected5Dark5.red
                                regularFillGreen = JiggleTheme.guideUnselected5Dark5.green
                                regularFillBlue = JiggleTheme.guideUnselected5Dark5.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected5Light5.red
                                regularFillGreen = JiggleTheme.guideUnselected5Light5.green
                                regularFillBlue = JiggleTheme.guideUnselected5Light5.blue
                            }
                        } else if weightDepthIndex == 3 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected5Dark4.red
                                regularFillGreen = JiggleTheme.guideUnselected5Dark4.green
                                regularFillBlue = JiggleTheme.guideUnselected5Dark4.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected5Light4.red
                                regularFillGreen = JiggleTheme.guideUnselected5Light4.green
                                regularFillBlue = JiggleTheme.guideUnselected5Light4.blue
                            }
                        } else if weightDepthIndex == 2 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected5Dark3.red
                                regularFillGreen = JiggleTheme.guideUnselected5Dark3.green
                                regularFillBlue = JiggleTheme.guideUnselected5Dark3.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected5Light3.red
                                regularFillGreen = JiggleTheme.guideUnselected5Light3.green
                                regularFillBlue = JiggleTheme.guideUnselected5Light3.blue
                            }
                        } else if weightDepthIndex == 1 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected5Dark2.red
                                regularFillGreen = JiggleTheme.guideUnselected5Dark2.green
                                regularFillBlue = JiggleTheme.guideUnselected5Dark2.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected5Light2.red
                                regularFillGreen = JiggleTheme.guideUnselected5Light2.green
                                regularFillBlue = JiggleTheme.guideUnselected5Light2.blue
                            }
                        } else {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected5Dark1.red
                                regularFillGreen = JiggleTheme.guideUnselected5Dark1.green
                                regularFillBlue = JiggleTheme.guideUnselected5Dark1.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected5Light1.red
                                regularFillGreen = JiggleTheme.guideUnselected5Light1.green
                                regularFillBlue = JiggleTheme.guideUnselected5Light1.blue
                            }
                        }
                    } else if jiggle.guideCount == 4 {
                        if weightDepthIndex == 3 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected4Dark4.red
                                regularFillGreen = JiggleTheme.guideUnselected4Dark4.green
                                regularFillBlue = JiggleTheme.guideUnselected4Dark4.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected4Light4.red
                                regularFillGreen = JiggleTheme.guideUnselected4Light4.green
                                regularFillBlue = JiggleTheme.guideUnselected4Light4.blue
                            }
                        } else if weightDepthIndex == 2 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected4Dark3.red
                                regularFillGreen = JiggleTheme.guideUnselected4Dark3.green
                                regularFillBlue = JiggleTheme.guideUnselected4Dark3.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected4Light3.red
                                regularFillGreen = JiggleTheme.guideUnselected4Light3.green
                                regularFillBlue = JiggleTheme.guideUnselected4Light3.blue
                            }
                        } else if weightDepthIndex == 1 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected4Dark2.red
                                regularFillGreen = JiggleTheme.guideUnselected4Dark2.green
                                regularFillBlue = JiggleTheme.guideUnselected4Dark2.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected4Light2.red
                                regularFillGreen = JiggleTheme.guideUnselected4Light2.green
                                regularFillBlue = JiggleTheme.guideUnselected4Light2.blue
                            }
                        } else {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected4Dark1.red
                                regularFillGreen = JiggleTheme.guideUnselected4Dark1.green
                                regularFillBlue = JiggleTheme.guideUnselected4Dark1.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected4Light1.red
                                regularFillGreen = JiggleTheme.guideUnselected4Light1.green
                                regularFillBlue = JiggleTheme.guideUnselected4Light1.blue
                            }
                        }
                    } else if jiggle.guideCount == 3 {
                        if weightDepthIndex == 2 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected3Dark3.red
                                regularFillGreen = JiggleTheme.guideUnselected3Dark3.green
                                regularFillBlue = JiggleTheme.guideUnselected3Dark3.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected3Light3.red
                                regularFillGreen = JiggleTheme.guideUnselected3Light3.green
                                regularFillBlue = JiggleTheme.guideUnselected3Light3.blue
                            }
                        } else if weightDepthIndex == 1 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected3Dark2.red
                                regularFillGreen = JiggleTheme.guideUnselected3Dark2.green
                                regularFillBlue = JiggleTheme.guideUnselected3Dark2.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected3Light2.red
                                regularFillGreen = JiggleTheme.guideUnselected3Light2.green
                                regularFillBlue = JiggleTheme.guideUnselected3Light2.blue
                            }
                        } else {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected3Dark1.red
                                regularFillGreen = JiggleTheme.guideUnselected3Dark1.green
                                regularFillBlue = JiggleTheme.guideUnselected3Dark1.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected3Light1.red
                                regularFillGreen = JiggleTheme.guideUnselected3Light1.green
                                regularFillBlue = JiggleTheme.guideUnselected3Light1.blue
                            }
                        }
                    } else if jiggle.guideCount == 2 {
                        if weightDepthIndex == 1 {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected2Dark2.red
                                regularFillGreen = JiggleTheme.guideUnselected2Dark2.green
                                regularFillBlue = JiggleTheme.guideUnselected2Dark2.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected2Light2.red
                                regularFillGreen = JiggleTheme.guideUnselected2Light2.green
                                regularFillBlue = JiggleTheme.guideUnselected2Light2.blue
                            }
                        } else {
                            if isDarkModeEnabled {
                                regularFillRed = JiggleTheme.guideUnselected2Dark1.red
                                regularFillGreen = JiggleTheme.guideUnselected2Dark1.green
                                regularFillBlue = JiggleTheme.guideUnselected2Dark1.blue
                            } else {
                                regularFillRed = JiggleTheme.guideUnselected2Light1.red
                                regularFillGreen = JiggleTheme.guideUnselected2Light1.green
                                regularFillBlue = JiggleTheme.guideUnselected2Light1.blue
                            }
                        }
                    } else {
                        if isDarkModeEnabled {
                            regularFillRed = JiggleTheme.guideUnselected1Dark1.red
                            regularFillGreen = JiggleTheme.guideUnselected1Dark1.green
                            regularFillBlue = JiggleTheme.guideUnselected1Dark1.blue
                        } else {
                            regularFillRed = JiggleTheme.guideUnselected1Light1.red
                            regularFillGreen = JiggleTheme.guideUnselected1Light1.green
                            regularFillBlue = JiggleTheme.guideUnselected1Light1.blue
                        }
                    }
                }
            }
        }
        
        if guidePointSelectionModality == .tans {
            if isDarkModeEnabled {
                selectedFillRed = JiggleTheme.outlineFrozenFillDark.red
                selectedFillGreen = JiggleTheme.outlineFrozenFillDark.green
                selectedFillBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                selectedFillRed = JiggleTheme.outlineFrozenFillLight.red
                selectedFillGreen = JiggleTheme.outlineFrozenFillLight.green
                selectedFillBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDarkModeEnabled {
                selectedFillRed = JiggleTheme.pointWeightSelectedDark.red
                selectedFillGreen = JiggleTheme.pointWeightSelectedDark.green
                selectedFillBlue = JiggleTheme.pointWeightSelectedDark.blue
            } else {
                selectedFillRed = JiggleTheme.pointWeightSelectedLight.red
                selectedFillGreen = JiggleTheme.pointWeightSelectedLight.green
                selectedFillBlue = JiggleTheme.pointWeightSelectedLight.blue
            }
        }
        
        // Just the modified fill...
        let fillModifiedRed: Float
        let fillModifiedGreen: Float
        let fillModifiedBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                fillModifiedRed = JiggleTheme.outlineFrozenFillDark.red
                fillModifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                fillModifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                fillModifiedRed = JiggleTheme.outlineFrozenFillLight.red
                fillModifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                fillModifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    fillModifiedRed = JiggleTheme.outlineSelectedModifiedFillDark.red
                    fillModifiedGreen = JiggleTheme.outlineSelectedModifiedFillDark.green
                    fillModifiedBlue = JiggleTheme.outlineSelectedModifiedFillDark.blue
                } else {
                    fillModifiedRed = JiggleTheme.outlineSelectedModifiedFillLight.red
                    fillModifiedGreen = JiggleTheme.outlineSelectedModifiedFillLight.green
                    fillModifiedBlue = JiggleTheme.outlineSelectedModifiedFillLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    fillModifiedRed = JiggleTheme.outlineUnselectedModifiedFillDark.red
                    fillModifiedGreen = JiggleTheme.outlineUnselectedModifiedFillDark.green
                    fillModifiedBlue = JiggleTheme.outlineUnselectedModifiedFillDark.blue
                } else {
                    fillModifiedRed = JiggleTheme.outlineUnselectedModifiedFillLight.red
                    fillModifiedGreen = JiggleTheme.outlineUnselectedModifiedFillLight.green
                    fillModifiedBlue = JiggleTheme.outlineUnselectedModifiedFillLight.blue
                }
            }
        }
        
        let tanLineFillUnmodifiedRed: Float
        let tanLineFillUnmodifiedGreen: Float
        let tanLineFillUnmodifiedBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanLineFillUnmodifiedRed = JiggleTheme.outlineFrozenFillDark.red
                tanLineFillUnmodifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                tanLineFillUnmodifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanLineFillUnmodifiedRed = JiggleTheme.outlineFrozenFillLight.red
                tanLineFillUnmodifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                tanLineFillUnmodifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    tanLineFillUnmodifiedRed = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedDark.red
                    tanLineFillUnmodifiedGreen = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedDark.green
                    tanLineFillUnmodifiedBlue = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedDark.blue
                } else {
                    tanLineFillUnmodifiedRed = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedLight.red
                    tanLineFillUnmodifiedGreen = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedLight.green
                    tanLineFillUnmodifiedBlue = JiggleTheme.jiggleTanHandleLineFillSelectedUnmodifiedLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    tanLineFillUnmodifiedRed = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedDark.red
                    tanLineFillUnmodifiedGreen = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedDark.green
                    tanLineFillUnmodifiedBlue = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedDark.blue
                } else {
                    tanLineFillUnmodifiedRed = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedLight.red
                    tanLineFillUnmodifiedGreen = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedLight.green
                    tanLineFillUnmodifiedBlue = JiggleTheme.jiggleTanHandleLineFillUnselectedUnmodifiedLight.blue
                }
            }
        }
        
        let tanLineFillModifiedRed: Float
        let tanLineFillModifiedGreen: Float
        let tanLineFillModifiedBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanLineFillModifiedRed = JiggleTheme.outlineFrozenFillDark.red
                tanLineFillModifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                tanLineFillModifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanLineFillModifiedRed = JiggleTheme.outlineFrozenFillLight.red
                tanLineFillModifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                tanLineFillModifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    tanLineFillModifiedRed = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedDark.red
                    tanLineFillModifiedGreen = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedDark.green
                    tanLineFillModifiedBlue = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedDark.blue
                } else {
                    tanLineFillModifiedRed = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedLight.red
                    tanLineFillModifiedGreen = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedLight.green
                    tanLineFillModifiedBlue = JiggleTheme.jiggleTanHandleLineFillSelectedModifiedLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    tanLineFillModifiedRed = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedDark.red
                    tanLineFillModifiedGreen = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedDark.green
                    tanLineFillModifiedBlue = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedDark.blue
                } else {
                    tanLineFillModifiedRed = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedLight.red
                    tanLineFillModifiedGreen = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedLight.green
                    tanLineFillModifiedBlue = JiggleTheme.jiggleTanHandleLineFillUnselectedModifiedLight.blue
                }
            }
        }
        
        let tanLineFillActiveRed: Float
        let tanLineFillActiveGreen: Float
        let tanLineFillActiveBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanLineFillActiveRed = JiggleTheme.outlineFrozenFillDark.red
                tanLineFillActiveGreen = JiggleTheme.outlineFrozenFillDark.green
                tanLineFillActiveBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanLineFillActiveRed = JiggleTheme.outlineFrozenFillLight.red
                tanLineFillActiveGreen = JiggleTheme.outlineFrozenFillLight.green
                tanLineFillActiveBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDarkModeEnabled {
                tanLineFillActiveRed = JiggleTheme.jiggleTanHandleLineFillSelectedActiveDark.red
                tanLineFillActiveGreen = JiggleTheme.jiggleTanHandleLineFillSelectedActiveDark.green
                tanLineFillActiveBlue = JiggleTheme.jiggleTanHandleLineFillSelectedActiveDark.blue
            } else {
                tanLineFillActiveRed = JiggleTheme.jiggleTanHandleLineFillSelectedActiveLight.red
                tanLineFillActiveGreen = JiggleTheme.jiggleTanHandleLineFillSelectedActiveLight.green
                tanLineFillActiveBlue = JiggleTheme.jiggleTanHandleLineFillSelectedActiveLight.blue
            }
        }
        
        let tanPointFillUnmodifiedRed: Float
        let tanPointFillUnmodifiedGreen: Float
        let tanPointFillUnmodifiedBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanPointFillUnmodifiedRed = JiggleTheme.outlineFrozenFillDark.red
                tanPointFillUnmodifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                tanPointFillUnmodifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanPointFillUnmodifiedRed = JiggleTheme.outlineFrozenFillLight.red
                tanPointFillUnmodifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                tanPointFillUnmodifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    tanPointFillUnmodifiedRed = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedDark.red
                    tanPointFillUnmodifiedGreen = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedDark.green
                    tanPointFillUnmodifiedBlue = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedDark.blue
                } else {
                    tanPointFillUnmodifiedRed = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedLight.red
                    tanPointFillUnmodifiedGreen = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedLight.green
                    tanPointFillUnmodifiedBlue = JiggleTheme.jiggleTanHandlePointFillSelectedUnmodifiedLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    tanPointFillUnmodifiedRed = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedDark.red
                    tanPointFillUnmodifiedGreen = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedDark.green
                    tanPointFillUnmodifiedBlue = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedDark.blue
                } else {
                    tanPointFillUnmodifiedRed = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedLight.red
                    tanPointFillUnmodifiedGreen = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedLight.green
                    tanPointFillUnmodifiedBlue = JiggleTheme.jiggleTanHandlePointFillUnselectedUnmodifiedLight.blue
                }
            }
        }
        
        let tanPointFillModifiedRed: Float
        let tanPointFillModifiedGreen: Float
        let tanPointFillModifiedBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanPointFillModifiedRed = JiggleTheme.outlineFrozenFillDark.red
                tanPointFillModifiedGreen = JiggleTheme.outlineFrozenFillDark.green
                tanPointFillModifiedBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanPointFillModifiedRed = JiggleTheme.outlineFrozenFillLight.red
                tanPointFillModifiedGreen = JiggleTheme.outlineFrozenFillLight.green
                tanPointFillModifiedBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDisplayingAsSelected {
                if isDarkModeEnabled {
                    tanPointFillModifiedRed = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedDark.red
                    tanPointFillModifiedGreen = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedDark.green
                    tanPointFillModifiedBlue = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedDark.blue
                } else {
                    tanPointFillModifiedRed = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedLight.red
                    tanPointFillModifiedGreen = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedLight.green
                    tanPointFillModifiedBlue = JiggleTheme.jiggleTanHandlePointFillSelectedModifiedLight.blue
                }
            } else {
                if isDarkModeEnabled {
                    tanPointFillModifiedRed = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedDark.red
                    tanPointFillModifiedGreen = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedDark.green
                    tanPointFillModifiedBlue = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedDark.blue
                } else {
                    tanPointFillModifiedRed = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedLight.red
                    tanPointFillModifiedGreen = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedLight.green
                    tanPointFillModifiedBlue = JiggleTheme.jiggleTanHandlePointFillUnselectedModifiedLight.blue
                }
            }
        }
        
        let tanPointFillActiveRed: Float
        let tanPointFillActiveGreen: Float
        let tanPointFillActiveBlue: Float
        if isDisplayingAsFrozen {
            if isDarkModeEnabled {
                tanPointFillActiveRed = JiggleTheme.outlineFrozenFillDark.red
                tanPointFillActiveGreen = JiggleTheme.outlineFrozenFillDark.green
                tanPointFillActiveBlue = JiggleTheme.outlineFrozenFillDark.blue
            } else {
                tanPointFillActiveRed = JiggleTheme.outlineFrozenFillLight.red
                tanPointFillActiveGreen = JiggleTheme.outlineFrozenFillLight.green
                tanPointFillActiveBlue = JiggleTheme.outlineFrozenFillLight.blue
            }
        } else {
            if isDarkModeEnabled {
                tanPointFillActiveRed = JiggleTheme.jiggleTanHandlePointFillSelectedActiveDark.red
                tanPointFillActiveGreen = JiggleTheme.jiggleTanHandlePointFillSelectedActiveDark.green
                tanPointFillActiveBlue = JiggleTheme.jiggleTanHandlePointFillSelectedActiveDark.blue
            } else {
                tanPointFillActiveRed = JiggleTheme.jiggleTanHandlePointFillSelectedActiveLight.red
                tanPointFillActiveGreen = JiggleTheme.jiggleTanHandlePointFillSelectedActiveLight.green
                tanPointFillActiveBlue = JiggleTheme.jiggleTanHandlePointFillSelectedActiveLight.blue
            }
        }
        
        
        // Just the bloom...
        let bloomRed: Float
        let bloomGreen: Float
        let bloomBlue: Float
        if isDarkModeEnabled {
            bloomRed = JiggleTheme.bloomGlowDark.red
            bloomGreen = JiggleTheme.bloomGlowDark.green
            bloomBlue = JiggleTheme.bloomGlowDark.blue
        } else {
            bloomRed = JiggleTheme.bloomGlowLight.red
            bloomGreen = JiggleTheme.bloomGlowLight.green
            bloomBlue = JiggleTheme.bloomGlowLight.blue
        }
        
        return GuideRenderColorPack(strokeRed: regularStrokeRed,
                                    strokeGreen: regularStrokeGreen,
                                    strokeBlue: regularStrokeBlue,
                                    
                                    fillUnselectedRed: regularFillRed,
                                    fillUnselectedGreen: regularFillGreen,
                                    fillUnselectedBlue: regularFillBlue,
                                    
                                    fillSelectedRed: selectedFillRed,
                                    fillSelectedGreen: selectedFillGreen,
                                    fillSelectedBlue: selectedFillBlue,
                                    
                                    fillModifiedRed: fillModifiedRed,
                                    fillModifiedGreen: fillModifiedGreen,
                                    fillModifiedBlue: fillModifiedBlue,
                                
                                    tanLineFillUnmodifiedRed: tanLineFillUnmodifiedRed,
                                    tanLineFillUnmodifiedGreen: tanLineFillUnmodifiedGreen,
                                    tanLineFillUnmodifiedBlue: tanLineFillUnmodifiedBlue,
                                    
                                    tanLineFillModifiedRed: tanLineFillModifiedRed,
                                    tanLineFillModifiedGreen: tanLineFillModifiedGreen,
                                    tanLineFillModifiedBlue: tanLineFillModifiedBlue,
                                    
                                    tanLineFillActiveRed: tanLineFillActiveRed,
                                    tanLineFillActiveGreen: tanLineFillActiveGreen,
                                    tanLineFillActiveBlue: tanLineFillActiveBlue,
                                    
                                    tanPointFillUnmodifiedRed: tanPointFillUnmodifiedRed,
                                    tanPointFillUnmodifiedGreen: tanPointFillUnmodifiedGreen,
                                    tanPointFillUnmodifiedBlue: tanPointFillUnmodifiedBlue,
                                    
                                    tanPointFillModifiedRed: tanPointFillModifiedRed,
                                    tanPointFillModifiedGreen: tanPointFillModifiedGreen,
                                    tanPointFillModifiedBlue: tanPointFillModifiedBlue,
                                    
                                    tanPointFillActiveRed: tanPointFillActiveRed,
                                    tanPointFillActiveGreen: tanPointFillActiveGreen,
                                    tanPointFillActiveBlue: tanPointFillActiveBlue,
                                    
                                    bloomRed: bloomRed,
                                    bloomGreen: bloomGreen,
                                    bloomBlue: bloomBlue)
    }
    
    func renderGuideBorderRingsBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuideBorderRingBloom {
                    if !jiggle.isFrozen {
                        if let selectedGuide = jiggle.getSelectedGuide() {
                            if selectedGuide.isFrozen == false {
                                let scale = getAdjustScale()
                                selectedGuide.solidLineBloomBuffer.render(renderEncoder: renderEncoder,
                                                                          pipelineState: .shapeNodeIndexed3DNoBlending,
                                                                          scale: scale)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func renderGuideBorderRingsStroke(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideBorderRings {
                let scale = getAdjustScale()
                if isPrecisePass {
                    for guideIndex in 0..<jiggle.guideCount {
                        let guide = jiggle.guides[guideIndex]
                        guide.solidLineBufferStroke_Precise.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .shapeNodeIndexed2DNoBlending,
                                                                   scale: scale)
                    }
                } else {
                    for guideIndex in 0..<jiggle.guideCount {
                        let guide = jiggle.guides[guideIndex]
                        guide.solidLineBufferStroke.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeIndexed2DNoBlending,
                                                           scale: scale)
                    }
                }
                
            }
        }
    }
    
    func renderGuideBorderRingFill(renderEncoder: MTLRenderCommandEncoder,
                                   isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideBorderRings {
                let scale = getAdjustScale()
                if isPrecisePass {
                    for guideIndex in 0..<jiggle.guideCount {
                        let guide = jiggle.guides[guideIndex]
                        guide.solidLineBuffer_Precise.render(renderEncoder: renderEncoder,
                                                             pipelineState: .shapeNodeIndexed2DNoBlending,
                                                             scale: scale)
                    }
                } else {
                    for guideIndex in 0..<jiggle.guideCount {
                        let guide = jiggle.guides[guideIndex]
                        guide.solidLineBuffer.render(renderEncoder: renderEncoder,
                                                     pipelineState: .shapeNodeIndexed2DNoBlending,
                                                     scale: scale)
                    }
                }
            }
        }
    }
    
    
    @MainActor
    @inline(__always)
    func prepareGuidePoints(jiggle: Jiggle,
                            pointScale: Float,
                            projectionMatrix: matrix_float4x4,
                            modelViewMatrix: matrix_float4x4,
                            baseAdjustRotation: Float,
                            isPrecisePass: Bool,
                            isBloomEnabled: Bool,
                            isCreatorModeGuideCenters: Bool,
                            isCreatorModeAddGuidePoints: Bool,
                            isCreatorModeDeleteGuidePoints: Bool,
                            guidePointSelectionModality: PointSelectionModality,
                            jiggleColorPack: JiggleRenderColorPack,
                            guidePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                            guidePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored,
                            guidePointSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                            guidePointSelectedFillBuffer: IndexedSpriteBuffer2DColored) {
        
        guidePointUnselectedStrokeBuffer.projectionMatrix = projectionMatrix
        guidePointUnselectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        guidePointUnselectedStrokeBuffer.red = jiggleColorPack.strokeRed
        guidePointUnselectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        guidePointUnselectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        guidePointUnselectedFillBuffer.projectionMatrix = projectionMatrix
        guidePointUnselectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        guidePointSelectedStrokeBuffer.projectionMatrix = projectionMatrix
        guidePointSelectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        guidePointSelectedStrokeBuffer.red = jiggleColorPack.strokeRed
        guidePointSelectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        guidePointSelectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        guidePointSelectedFillBuffer.projectionMatrix = projectionMatrix
        guidePointSelectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        if isBloomEnabled && jiggle.isShowingGuidePointsBloom && !isPrecisePass {
            
            guidePointUnselectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            guidePointUnselectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            guidePointUnselectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            guidePointUnselectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            guidePointUnselectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
            
            guidePointSelectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            guidePointSelectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            guidePointSelectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            guidePointSelectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            guidePointSelectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
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
                
                let renderCenterPoint = Math.Point(x: guideControlPoint.renderX,
                                                   y: guideControlPoint.renderY)
                
                // If frozen, no bloom, no selection.
                if guide.renderFrozen {
                    guidePointUnselectedStrokeBuffer.add(translation: renderCenterPoint,
                                                         scale: pointScale,
                                                         rotation: 0.0)
                    guidePointUnselectedFillBuffer.add(translation: renderCenterPoint,
                                                       scale: pointScale,
                                                       rotation: 0.0,
                                                       red: guideColorPack.fillUnselectedRed,
                                                       green: guideColorPack.fillUnselectedGreen,
                                                       blue: guideColorPack.fillUnselectedBlue,
                                                       alpha: 1.0)
                } else if guide.renderSelected && guideControlPoint.renderSelected && isSelected {
                    guidePointSelectedStrokeBuffer.add(translation: renderCenterPoint,
                                                       scale: pointScale,
                                                       rotation: 0.0)
                    guidePointSelectedFillBuffer.add(translation: renderCenterPoint,
                                                     scale: pointScale,
                                                     rotation: baseAdjustRotation,
                                                     red: guideColorPack.fillSelectedRed,
                                                     green: guideColorPack.fillSelectedGreen,
                                                     blue: guideColorPack.fillSelectedBlue,
                                                     alpha: 1.0)
                    if isBloomEnabled && jiggle.isShowingGuidePointsBloom && !isPrecisePass {
                        guidePointSelectedStrokeBufferBloom.add(translation: renderCenterPoint,
                                                                scale: pointScale,
                                                                rotation: 0.0)
                    }
                } else {
                    guidePointUnselectedStrokeBuffer.add(translation: renderCenterPoint,
                                                         scale: pointScale,
                                                         rotation: 0.0)
                    guidePointUnselectedFillBuffer.add(translation: renderCenterPoint,
                                                       scale: pointScale,
                                                       rotation: 0.0,
                                                       red: guideColorPack.fillUnselectedRed,
                                                       green: guideColorPack.fillUnselectedGreen,
                                                       blue: guideColorPack.fillUnselectedBlue,
                                                       alpha: 1.0)
                    
                    if guide.renderSelected && isSelected && isBloomEnabled && !isPrecisePass {
                        if jiggle.isShowingGuidePointsBloom {
                            guidePointUnselectedStrokeBufferBloom.add(translation: renderCenterPoint,
                                                                      scale: pointScale,
                                                                      rotation: 0.0)
                        }
                    }
                }
            } // End of guide points loop A
        }
    }
    
    func renderGuidePointUnselectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                          isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                if isPrecisePass {
                    guidePointUnselectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointUnselectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointUnselectedFill(renderEncoder: MTLRenderCommandEncoder,
                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                if isPrecisePass {
                    guidePointUnselectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointUnselectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointSelectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                if isPrecisePass {
                    guidePointSelectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointSelectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointSelectedFill(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuidePoints {
                if isPrecisePass {
                    guidePointSelectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointSelectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointUnselectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuidePointsBloom {
                    guidePointUnselectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderGuidePointSelectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuidePointsBloom {
                    if !jiggle.isFrozen {
                        guidePointSelectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
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
    
    @MainActor
    @inline(__always)
    func prepareGuidePointTanPoints(jiggle: Jiggle,
                                     projectionMatrix: matrix_float4x4,
                                     modelViewMatrix: matrix_float4x4,
                                     pointScale: Float,
                                     isPrecisePass: Bool,
                                     isBloomEnabled: Bool,
                                     jiggleColorPack: JiggleRenderColorPack,
                                     selectedGuidePointTanType: TanType,
                                     guidePointTanHandlePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                                     guidePointTanHandlePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored,
                                     guidePointTanHandlePointSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                                    guidePointTanHandlePointSelectedFillBuffer: IndexedSpriteBuffer2DColored) {
        
        
        
    }
    
    
    func renderGuidePointTanHandlePointUnselectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandlePointUnselectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointTanHandlePointUnselectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointUnselectedFill(renderEncoder: MTLRenderCommandEncoder,
                                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandlePointUnselectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointTanHandlePointUnselectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointSelectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandlePointSelectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointTanHandlePointSelectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointSelectedFill(renderEncoder: MTLRenderCommandEncoder,
                                                    isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingGuideControlPointTanHandles {
                if isPrecisePass {
                    guidePointTanHandlePointSelectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    guidePointTanHandlePointSelectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointUnselectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuideControlPointTanHandlesBloom {
                    guidePointTanHandlePointUnselectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderGuidePointTanHandlePointSelectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingGuideControlPointTanHandlesBloom {
                    if !jiggle.isFrozen {
                        guidePointTanHandlePointSelectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    func renderJiggleBorderRingBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleBorderRingsBloom {
                    if !jiggle.isFrozen {
                        let scale = getAdjustScale()
                        jiggle.solidLineBloomBuffer.render(renderEncoder: renderEncoder,
                                                           pipelineState: .shapeNodeIndexed3DNoBlending,
                                                           scale: scale)
                    }
                }
            }
        }
    }
    
    func renderJiggleBorderRingStroke(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleBorderRings {
                let scale = getAdjustScale()
                if isPrecisePass {
                    jiggle.solidLineBufferStroke_Precise.render(renderEncoder: renderEncoder,
                                                                pipelineState: .shapeNodeIndexed2DNoBlending,
                                                                scale: scale)
                } else {
                    jiggle.solidLineBufferStroke.render(renderEncoder: renderEncoder,
                                                        pipelineState: .shapeNodeIndexed2DNoBlending,
                                                        scale: scale)
                }
            }
        }
    }
    
    func renderJiggleBorderRingFill(renderEncoder: MTLRenderCommandEncoder,
                                isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleBorderRings {
                let scale = getAdjustScale()
                if isPrecisePass {
                    jiggle.solidLineBuffer_Precise.render(renderEncoder: renderEncoder,
                                                          pipelineState: .shapeNodeIndexed2DNoBlending,
                                                          scale: scale)
                } else {
                    jiggle.solidLineBuffer.render(renderEncoder: renderEncoder,
                                                  pipelineState: .shapeNodeIndexed2DNoBlending,
                                                  scale: scale)
                }
            }
        }
    }
    
    @MainActor
    @inline(__always)
    func prepareJiggleCenter(jiggle: Jiggle,
                            worldScalePrecise: Float,
                            worldScaleStandard: Float,
                            projectionMatrix: matrix_float4x4,
                            modelViewMatrix: matrix_float4x4,
                            baseAdjustRotation: Float,
                            isPrecisePass: Bool,
                            isBloomEnabled: Bool,
                            jiggleColorPack: JiggleRenderColorPack,
                            jiggleCenterMarkerUnselectedFillInstance: IndexedSpriteInstance2D,
                            jiggleCenterMarkerUnselectedStrokeInstance: IndexedSpriteInstance2D,
                            jiggleCenterMarkerSelectedFillInstance: IndexedSpriteInstance2D,
                            jiggleCenterMarkerSelectedStrokeInstance: IndexedSpriteInstance2D) {
        let jiggleCenterScale: Float
        if isPrecisePass {
            jiggleCenterScale = worldScalePrecise * JiggleViewModel.jiggleCenterScalePrecise
        } else {
            jiggleCenterScale = worldScaleStandard * JiggleViewModel.jiggleCenterScaleStandard
        }
        var offsetCenter = jiggle.offsetCenter
        offsetCenter = jiggle.transformPoint(point: offsetCenter)
        var centerModelView = modelViewMatrix
        centerModelView.translation(x: offsetCenter.x,
                                    y: offsetCenter.y,
                                    z: 0.0)
        centerModelView.scale(jiggleCenterScale)
        centerModelView.rotateZ(radians: baseAdjustRotation)
        if isSelected {
            jiggleCenterMarkerSelectedFillInstance.projectionMatrix = projectionMatrix
            jiggleCenterMarkerSelectedFillInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerSelectedFillInstance.red = jiggleColorPack.fillUnselectedRed
            jiggleCenterMarkerSelectedFillInstance.green = jiggleColorPack.fillUnselectedBlue
            jiggleCenterMarkerSelectedFillInstance.blue = jiggleColorPack.fillUnselectedBlue
            jiggleCenterMarkerSelectedStrokeInstance.projectionMatrix = projectionMatrix
            jiggleCenterMarkerSelectedStrokeInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerSelectedStrokeInstance.red = jiggleColorPack.strokeRed
            jiggleCenterMarkerSelectedStrokeInstance.green = jiggleColorPack.strokeGreen
            jiggleCenterMarkerSelectedStrokeInstance.blue = jiggleColorPack.strokeBlue
            if jiggle.isShowingCenterMarkerBloom && isBloomEnabled && !isPrecisePass {
                jiggleCenterMarkerSelectedRegularBloomInstance.projectionMatrix = projectionMatrix
                jiggleCenterMarkerSelectedRegularBloomInstance.modelViewMatrix = centerModelView
                jiggleCenterMarkerSelectedRegularBloomInstance.red = jiggleColorPack.bloomRed
                jiggleCenterMarkerSelectedRegularBloomInstance.green = jiggleColorPack.bloomGreen
                jiggleCenterMarkerSelectedRegularBloomInstance.blue = jiggleColorPack.bloomBlue
            }
        } else {
            jiggleCenterMarkerUnselectedFillInstance.projectionMatrix = projectionMatrix
            jiggleCenterMarkerUnselectedFillInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerUnselectedFillInstance.red = jiggleColorPack.fillUnselectedRed
            jiggleCenterMarkerUnselectedFillInstance.green = jiggleColorPack.fillUnselectedBlue
            jiggleCenterMarkerUnselectedFillInstance.blue = jiggleColorPack.fillUnselectedBlue
            jiggleCenterMarkerUnselectedStrokeInstance.projectionMatrix = projectionMatrix
            jiggleCenterMarkerUnselectedStrokeInstance.modelViewMatrix = centerModelView
            jiggleCenterMarkerUnselectedStrokeInstance.red = jiggleColorPack.strokeRed
            jiggleCenterMarkerUnselectedStrokeInstance.green = jiggleColorPack.strokeGreen
            jiggleCenterMarkerUnselectedStrokeInstance.blue = jiggleColorPack.strokeBlue
        }
    }
    
    func renderJiggleCenterMarkerStroke(renderEncoder: MTLRenderCommandEncoder,
                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingCenterMarker {
                if isSelected {
                    if isPrecisePass {
                        jiggleCenterMarkerSelectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        jiggleCenterMarkerSelectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                } else {
                    if isPrecisePass {
                        jiggleCenterMarkerUnselectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        jiggleCenterMarkerUnselectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                }
            }
        }
    }
    
    func renderJiggleCenterMarkerFill(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingCenterMarker {
                if isSelected {
                    if isPrecisePass {
                        jiggleCenterMarkerSelectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        jiggleCenterMarkerSelectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                } else {
                    if isPrecisePass {
                        jiggleCenterMarkerUnselectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        jiggleCenterMarkerUnselectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                }
            }
        }
    }
    
    func renderJiggleCenterMarkerStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if isSelected {
                    if jiggle.isShowingCenterMarkerBloom {
                        jiggleCenterMarkerSelectedRegularBloomInstance.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    @MainActor
    @inline(__always)
    func prepareJigglePoints(jiggle: Jiggle,
                             pointScale: Float,
                             projectionMatrix: matrix_float4x4,
                             modelViewMatrix: matrix_float4x4,
                             baseAdjustRotation: Float,
                             isPrecisePass: Bool,
                             isBloomEnabled: Bool,
                             jiggleColorPack: JiggleRenderColorPack,
                             jigglePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                             jigglePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored,
                             jigglePointSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                             jigglePointSelectedFillBuffer: IndexedSpriteBuffer2DColored) {
        
        jigglePointUnselectedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointUnselectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointUnselectedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointUnselectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointUnselectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointUnselectedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointUnselectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        jigglePointSelectedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointSelectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointSelectedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointSelectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointSelectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointSelectedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointSelectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        if isBloomEnabled && jiggle.isShowingJigglePointsBloom && !isPrecisePass {
            
            jigglePointUnselectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            jigglePointUnselectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            jigglePointUnselectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            jigglePointUnselectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            jigglePointUnselectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
            
            jigglePointSelectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            jigglePointSelectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            jigglePointSelectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            jigglePointSelectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            jigglePointSelectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
            jigglePointSelectedStrokeBufferBloom.alpha = 1.0
        }
        
        for jiggleControlPointIndex in 0..<jiggle.jiggleControlPointCount {
            let jiggleControlPoint = jiggle.jiggleControlPoints[jiggleControlPointIndex]
            
            let renderCenterPoint = Math.Point(x: jiggleControlPoint.renderX,
                                               y: jiggleControlPoint.renderY)
            
            if jiggleControlPoint.renderSelected {
                jigglePointSelectedStrokeBuffer.add(translation: renderCenterPoint,
                                                    scale: pointScale,
                                                    rotation: baseAdjustRotation)
                jigglePointSelectedFillBuffer.add(translation: renderCenterPoint,
                                                  scale: pointScale,
                                                  rotation: baseAdjustRotation,
                                                  red: jiggleColorPack.fillSelectedRed,
                                                  green: jiggleColorPack.fillSelectedGreen,
                                                  blue: jiggleColorPack.fillSelectedBlue,
                                                  alpha: 1.0)
                
                if isBloomEnabled && jiggle.isShowingJigglePointsBloom && !isPrecisePass {
                    jigglePointSelectedStrokeBufferBloom.add(translation: renderCenterPoint,
                                                             scale: pointScale,
                                                             rotation: 0.0)
                }
            } else {
                
                jigglePointUnselectedStrokeBuffer.add(translation: renderCenterPoint,
                                                      scale: pointScale,
                                                      rotation: 0.0)
                
                if jiggleControlPoint.isManualTanHandleEnabled {
                    jigglePointUnselectedFillBuffer.add(translation: renderCenterPoint,
                                                        scale: pointScale,
                                                        rotation: 0.0,
                                                        red: jiggleColorPack.fillModifiedRed,
                                                        green: jiggleColorPack.fillModifiedGreen,
                                                        blue: jiggleColorPack.fillModifiedBlue,
                                                        alpha: 1.0)
                } else {
                    jigglePointUnselectedFillBuffer.add(translation: renderCenterPoint,
                                                        scale: pointScale,
                                                        rotation: 0.0,
                                                        red: jiggleColorPack.fillUnselectedRed,
                                                        green: jiggleColorPack.fillUnselectedGreen,
                                                        blue: jiggleColorPack.fillUnselectedBlue,
                                                        alpha: 1.0)
                }
                
                if isBloomEnabled && jiggle.isShowingJigglePointsBloom && !isPrecisePass {
                    jigglePointUnselectedStrokeBufferBloom.add(translation: renderCenterPoint,
                                                               scale: pointScale,
                                                               rotation: 0.0)
                }
            }
        }
    }
    
    func renderJigglePointUnselectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                           isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                if isPrecisePass {
                    jigglePointUnselectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointUnselectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                     pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJigglePointUnselectedFill(renderEncoder: MTLRenderCommandEncoder,
                                         isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                if isPrecisePass {
                    jigglePointUnselectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointUnselectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJigglePointSelectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                         isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                if isPrecisePass {
                    jigglePointSelectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointSelectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJigglePointSelectedFill(renderEncoder: MTLRenderCommandEncoder,
                                       isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJigglePoints {
                if isPrecisePass {
                    jigglePointSelectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointSelectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }
    
    func renderJigglePointUnselectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJigglePointsBloom {
                    jigglePointUnselectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                  pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    func renderJigglePointSelectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJigglePointsBloom {
                    if !jiggle.isFrozen {
                        jigglePointSelectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                    pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
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
    
    @MainActor
    @inline(__always)
    func prepareJigglePointTanPoints(jiggle: Jiggle,
                                     projectionMatrix: matrix_float4x4,
                                     modelViewMatrix: matrix_float4x4,
                                     pointScale: Float,
                                     isPrecisePass: Bool,
                                     isBloomEnabled: Bool,
                                     jiggleColorPack: JiggleRenderColorPack,
                                     selectedJigglePointTanType: TanType,
                                     jigglePointTanHandlePointUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                                     jigglePointTanHandlePointUnselectedFillBuffer: IndexedSpriteBuffer2DColored,
                                     jigglePointTanHandlePointSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                                     jigglePointTanHandlePointSelectedFillBuffer: IndexedSpriteBuffer2DColored) {
        
        jigglePointTanHandlePointUnselectedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandlePointUnselectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandlePointUnselectedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointTanHandlePointUnselectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointTanHandlePointUnselectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointTanHandlePointUnselectedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandlePointUnselectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        jigglePointTanHandlePointSelectedStrokeBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandlePointSelectedStrokeBuffer.modelViewMatrix = modelViewMatrix
        jigglePointTanHandlePointSelectedStrokeBuffer.red = jiggleColorPack.strokeRed
        jigglePointTanHandlePointSelectedStrokeBuffer.green = jiggleColorPack.strokeGreen
        jigglePointTanHandlePointSelectedStrokeBuffer.blue = jiggleColorPack.strokeBlue
        
        jigglePointTanHandlePointSelectedFillBuffer.projectionMatrix = projectionMatrix
        jigglePointTanHandlePointSelectedFillBuffer.modelViewMatrix = modelViewMatrix
        
        if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
            
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            jigglePointTanHandlePointUnselectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
            
            jigglePointTanHandlePointSelectedStrokeBufferBloom.projectionMatrix = projectionMatrix
            jigglePointTanHandlePointSelectedStrokeBufferBloom.modelViewMatrix = modelViewMatrix
            jigglePointTanHandlePointSelectedStrokeBufferBloom.red = jiggleColorPack.bloomRed
            jigglePointTanHandlePointSelectedStrokeBufferBloom.green = jiggleColorPack.bloomGreen
            jigglePointTanHandlePointSelectedStrokeBufferBloom.blue = jiggleColorPack.bloomBlue
        }
        
        for jiggleControlPointIndex in 0..<jiggle.jiggleControlPointCount {
            
            let jiggleControlPoint = jiggle.jiggleControlPoints[jiggleControlPointIndex]
            
            
            let renderCenterPointIn = Math.Point(x: jiggleControlPoint.renderTanInX,
                                                 y: jiggleControlPoint.renderTanInY)
            let renderCenterPointOut = Math.Point(x: jiggleControlPoint.renderTanOutX,
                                                  y: jiggleControlPoint.renderTanOutY)
            
            if (jiggleControlPoint.renderSelected == true) && (selectedJigglePointTanType == .in) {
                
                jigglePointTanHandlePointSelectedStrokeBuffer.add(translation: renderCenterPointIn,
                                                                  scale: pointScale,
                                                                  rotation: 0.0)
                jigglePointTanHandlePointSelectedFillBuffer.add(translation: renderCenterPointIn,
                                                                scale: pointScale,
                                                                rotation: 0.0,
                                                                red: jiggleColorPack.tanPointFillActiveRed,
                                                                green: jiggleColorPack.tanPointFillActiveGreen,
                                                                blue: jiggleColorPack.tanPointFillActiveBlue,
                                                                alpha: 1.0)
                
                if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                    jigglePointTanHandlePointSelectedStrokeBufferBloom.add(translation: renderCenterPointIn,
                                                                           scale: pointScale,
                                                                           rotation: 0.0)
                }
                
            } else {
                
                jigglePointTanHandlePointUnselectedStrokeBuffer.add(translation: renderCenterPointIn,
                                                                    scale: pointScale,
                                                                    rotation: 0.0)
                if (jiggleControlPoint.isManualTanHandleEnabled == true) || (jiggleControlPoint.renderSelected == true) {
                    jigglePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointIn,
                                                                      scale: pointScale,
                                                                      rotation: 0.0,
                                                                      red: jiggleColorPack.tanPointFillModifiedRed,
                                                                      green: jiggleColorPack.tanPointFillModifiedGreen,
                                                                      blue: jiggleColorPack.tanPointFillModifiedBlue,
                                                                      alpha: 1.0)
                } else {
                    jigglePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointIn,
                                                                      scale: pointScale,
                                                                      rotation: 0.0,
                                                                      red: jiggleColorPack.tanPointFillUnmodifiedRed,
                                                                      green: jiggleColorPack.tanPointFillUnmodifiedGreen,
                                                                      blue: jiggleColorPack.tanPointFillUnmodifiedBlue,
                                                                      alpha: 1.0)
                }
                
                if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                    jigglePointTanHandlePointUnselectedStrokeBufferBloom.add(translation: renderCenterPointIn,
                                                                             scale: pointScale,
                                                                             rotation: 0.0)
                }
            }
            
            if (jiggleControlPoint.renderSelected == true) && (selectedJigglePointTanType == .out) {
                
                jigglePointTanHandlePointSelectedStrokeBuffer.add(translation: renderCenterPointOut,
                                                                  scale: pointScale,
                                                                  rotation: 0.0)
                jigglePointTanHandlePointSelectedFillBuffer.add(translation: renderCenterPointOut,
                                                                scale: pointScale,
                                                                rotation: 0.0,
                                                                red: jiggleColorPack.tanPointFillActiveRed,
                                                                green: jiggleColorPack.tanPointFillActiveGreen,
                                                                blue: jiggleColorPack.tanPointFillActiveBlue,
                                                                alpha: 1.0)
                
                if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                    jigglePointTanHandlePointSelectedStrokeBufferBloom.add(translation: renderCenterPointOut,
                                                                           scale: pointScale,
                                                                           rotation: 0.0)
                }
                
            } else {
                
                jigglePointTanHandlePointUnselectedStrokeBuffer.add(translation: renderCenterPointOut,
                                                                    scale: pointScale,
                                                                    rotation: 0.0)
                if (jiggleControlPoint.isManualTanHandleEnabled == true) || (jiggleControlPoint.renderSelected == true) {
                    jigglePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointOut,
                                                                      scale: pointScale,
                                                                      rotation: 0.0,
                                                                      red: jiggleColorPack.tanPointFillModifiedRed,
                                                                      green: jiggleColorPack.tanPointFillModifiedGreen,
                                                                      blue: jiggleColorPack.tanPointFillModifiedBlue,
                                                                      alpha: 1.0)
                } else {
                    jigglePointTanHandlePointUnselectedFillBuffer.add(translation: renderCenterPointOut,
                                                                      scale: pointScale,
                                                                      rotation: 0.0,
                                                                      red: jiggleColorPack.tanPointFillUnmodifiedRed,
                                                                      green: jiggleColorPack.tanPointFillUnmodifiedGreen,
                                                                      blue: jiggleColorPack.tanPointFillUnmodifiedBlue,
                                                                      alpha: 1.0)
                }
                
                if isBloomEnabled && jiggle.isShowingJiggleControlPointTanHandlesBloom && !isPrecisePass {
                    jigglePointTanHandlePointUnselectedStrokeBufferBloom.add(translation: renderCenterPointOut,
                                                                             scale: pointScale,
                                                                             rotation: 0.0)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointUnselectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                                         isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandlePointUnselectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointTanHandlePointUnselectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                                   pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointUnselectedFill(renderEncoder: MTLRenderCommandEncoder,
                                                       isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandlePointUnselectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointTanHandlePointUnselectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointSelectedStroke(renderEncoder: MTLRenderCommandEncoder,
                                                       isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandlePointSelectedStrokeBufferPrecise.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointTanHandlePointSelectedStrokeBufferStandard.render(renderEncoder: renderEncoder,
                                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointSelectedFill(renderEncoder: MTLRenderCommandEncoder,
                                                     isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingJiggleControlPointTanHandles {
                if isPrecisePass {
                    jigglePointTanHandlePointSelectedFillBufferPrecise.render(renderEncoder: renderEncoder,
                                                                              pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                } else {
                    jigglePointTanHandlePointSelectedFillBufferStandard.render(renderEncoder: renderEncoder,
                                                                               pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointUnselectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleControlPointTanHandlesBloom {
                    jigglePointTanHandlePointUnselectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }

    func renderJigglePointTanHandlePointSelectedStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if jiggle.isShowingJiggleControlPointTanHandlesBloom {
                    if !jiggle.isFrozen {
                        jigglePointTanHandlePointSelectedStrokeBufferBloom.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeIndexed3DAlphaBlending)
                    }
                }
            }
        }
    }
    
    @MainActor
    @inline(__always)
    func prepareWeightCenter(jiggle: Jiggle,
                            worldScalePrecise: Float,
                            worldScaleStandard: Float,
                            projectionMatrix: matrix_float4x4,
                            modelViewMatrix: matrix_float4x4,
                            baseAdjustRotation: Float,
                            isPrecisePass: Bool,
                            isBloomEnabled: Bool,
                            jiggleColorPack: JiggleRenderColorPack,
                            weightCenterMarkerDotUnselectedFillInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerDotUnselectedStrokeInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerDotSelectedFillInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerDotSelectedStrokeInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerSpinnerUnselectedFillInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerSpinnerUnselectedStrokeInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerSpinnerSelectedFillInstance: IndexedSpriteInstance2D,
                            weightCenterMarkerSpinnerSelectedStrokeInstance: IndexedSpriteInstance2D) {
        
        let weghtCenterScale: Float
        if isPrecisePass {
            weghtCenterScale = worldScalePrecise * JiggleViewModel.weightCenterScalePrecise
        } else {
            weghtCenterScale = worldScaleStandard * JiggleViewModel.weightCenterScaleStandard
        }
        
        var guideCenter = jiggle.guideCenter
        guideCenter = jiggle.transformPoint(point: guideCenter)
        var centerModelView = modelViewMatrix
        centerModelView.translation(x: guideCenter.x,
                                    y: guideCenter.y,
                                    z: 0.0)
        centerModelView.scale(weghtCenterScale)
        centerModelView.rotateZ(radians: baseAdjustRotation)
        
        var spinnerModelView = centerModelView
        spinnerModelView.rotateZ(radians: jiggle.guideCenterSpinnerRotation)
        
        if isSelected {
            
            weightCenterMarkerDotSelectedFillInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerDotSelectedFillInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotSelectedFillInstance.red = jiggleColorPack.fillWeightCenterRed
            weightCenterMarkerDotSelectedFillInstance.green = jiggleColorPack.fillWeightCenterGreen
            weightCenterMarkerDotSelectedFillInstance.blue = jiggleColorPack.fillWeightCenterBlue
            
            weightCenterMarkerDotSelectedStrokeInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerDotSelectedStrokeInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotSelectedStrokeInstance.red = jiggleColorPack.strokeRed
            weightCenterMarkerDotSelectedStrokeInstance.green = jiggleColorPack.strokeGreen
            weightCenterMarkerDotSelectedStrokeInstance.blue = jiggleColorPack.strokeBlue
            
            weightCenterMarkerSpinnerSelectedFillInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerSpinnerSelectedFillInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerSelectedFillInstance.red = jiggleColorPack.fillWeightCenterRed
            weightCenterMarkerSpinnerSelectedFillInstance.green = jiggleColorPack.fillWeightCenterGreen
            weightCenterMarkerSpinnerSelectedFillInstance.blue = jiggleColorPack.fillWeightCenterBlue
            
            weightCenterMarkerSpinnerSelectedStrokeInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerSpinnerSelectedStrokeInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerSelectedStrokeInstance.red = jiggleColorPack.strokeRed
            weightCenterMarkerSpinnerSelectedStrokeInstance.green = jiggleColorPack.strokeGreen
            weightCenterMarkerSpinnerSelectedStrokeInstance.blue = jiggleColorPack.strokeBlue
            
            if isBloomEnabled && jiggle.isShowingWeightCenterMarkerBloom && !isPrecisePass {
                
                weightCenterMarkerDotSelectedRegularBloomInstance.projectionMatrix = projectionMatrix
                weightCenterMarkerDotSelectedRegularBloomInstance.modelViewMatrix = centerModelView
                weightCenterMarkerDotSelectedRegularBloomInstance.red = jiggleColorPack.bloomRed
                weightCenterMarkerDotSelectedRegularBloomInstance.green = jiggleColorPack.bloomGreen
                weightCenterMarkerDotSelectedRegularBloomInstance.blue = jiggleColorPack.bloomBlue
                
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.projectionMatrix = projectionMatrix
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.modelViewMatrix = spinnerModelView
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.red = jiggleColorPack.bloomRed
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.green = jiggleColorPack.bloomGreen
                weightCenterMarkerSpinnerSelectedRegularBloomInstance.blue = jiggleColorPack.bloomBlue
            }
            
        } else {
            weightCenterMarkerDotUnselectedFillInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerDotUnselectedFillInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotUnselectedFillInstance.red = jiggleColorPack.fillWeightCenterRed
            weightCenterMarkerDotUnselectedFillInstance.green = jiggleColorPack.fillWeightCenterGreen
            weightCenterMarkerDotUnselectedFillInstance.blue = jiggleColorPack.fillWeightCenterBlue
            
            weightCenterMarkerDotUnselectedStrokeInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerDotUnselectedStrokeInstance.modelViewMatrix = centerModelView
            weightCenterMarkerDotUnselectedStrokeInstance.red = jiggleColorPack.strokeRed
            weightCenterMarkerDotUnselectedStrokeInstance.green = jiggleColorPack.strokeGreen
            weightCenterMarkerDotUnselectedStrokeInstance.blue = jiggleColorPack.strokeBlue
            
            weightCenterMarkerSpinnerUnselectedFillInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerSpinnerUnselectedFillInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerUnselectedFillInstance.red = jiggleColorPack.fillWeightCenterRed
            weightCenterMarkerSpinnerUnselectedFillInstance.green = jiggleColorPack.fillWeightCenterGreen
            weightCenterMarkerSpinnerUnselectedFillInstance.blue = jiggleColorPack.fillWeightCenterBlue
            
            weightCenterMarkerSpinnerUnselectedStrokeInstance.projectionMatrix = projectionMatrix
            weightCenterMarkerSpinnerUnselectedStrokeInstance.modelViewMatrix = spinnerModelView
            weightCenterMarkerSpinnerUnselectedStrokeInstance.red = jiggleColorPack.strokeRed
            weightCenterMarkerSpinnerUnselectedStrokeInstance.green = jiggleColorPack.strokeGreen
            weightCenterMarkerSpinnerUnselectedStrokeInstance.blue = jiggleColorPack.strokeBlue
        }
    }
    
    func renderWeightCenterMarkerStroke(renderEncoder: MTLRenderCommandEncoder,
                                        isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingWeightCenterMarker {
                if isSelected {
                    if isPrecisePass {
                        weightCenterMarkerDotSelectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerSelectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        weightCenterMarkerDotSelectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerSelectedRegularStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                      pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                } else {
                    if isPrecisePass {
                        weightCenterMarkerDotUnselectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
                                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerUnselectedPreciseStrokeInstance.render(renderEncoder: renderEncoder,
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
    }
    
    
    func renderWeightCenterMarkerFill(renderEncoder: MTLRenderCommandEncoder,
                                      isPrecisePass: Bool) {
        if let jiggle = jiggle {
            if jiggle.isShowingWeightCenterMarker {
                if isSelected {
                    if isPrecisePass {
                        weightCenterMarkerDotSelectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerSelectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    } else {
                        weightCenterMarkerDotSelectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerSelectedRegularFillInstance.render(renderEncoder: renderEncoder,
                                                                                    pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                    }
                } else {
                    if isPrecisePass {
                        weightCenterMarkerDotUnselectedPreciseFillInstance.render(renderEncoder: renderEncoder,
                                                                                  pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
                        weightCenterMarkerSpinnerUnselectedPreciseFillInstance.render(renderEncoder: renderEncoder,
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
    }
    
    func renderWeightCenterMarkerStrokeBloom(renderEncoder: MTLRenderCommandEncoder) {
        if ApplicationController.isGlowingSelectionEnabled {
            if let jiggle = jiggle {
                if isSelected {
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
    
}
