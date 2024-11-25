//
//  JiggleRenderer+Colors.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 11/21/24.
//

import Foundation

extension JiggleRenderer {
    
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
}
