//
//  RTG.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation

struct RTG {
    
    static let D = RenderThemeGuideDark()
    static let L = RenderThemeGuideLight()
    
    static func fillRegSelUnm(index: Int, isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegSelUnm(index: index) : L.fillRegSelUnm(index: index)
    }

    static func fillRegUnsUnm(index: Int, isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegUnsUnm(index: index) : L.fillRegUnsUnm(index: index)
    }
    
    static func fillRegSelMod(index: Int, isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegSelMod(index: index) : L.fillRegSelMod(index: index)
    }

    static func fillRegUnsMod(index: Int, isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegUnsMod(index: index) : L.fillRegUnsMod(index: index)
    }
    
    static func tanPointFillSel(index: Int, isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.tanPointFillSel(index: index) : L.tanPointFillSel(index: index)
    }

    static func tanPointFillUns(index: Int, isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.tanPointFillUns(index: index) : L.tanPointFillUns(index: index)
    }
    
}
