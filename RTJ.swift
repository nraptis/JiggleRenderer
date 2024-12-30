//
//  RT.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation

struct RTJ {
    
    static let D = RenderThemeJiggleDark()
    static let L = RenderThemeJiggleLight()
    
    // Bloom
    static func bloom(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.bloom : L.bloom
    }
    
    // Center Marker
    static func centerMarkerUnselectedActive(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.centerMarkerUnselectedActive : L.centerMarkerUnselectedActive
    }
    
    // Stroke Colors
    static func strokeRegSel(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeRegSel : L.strokeRegSel
    }
    
    static func strokeRegUns(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeRegUns : L.strokeRegUns
    }
    
    static func strokeAltSel(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeAltSel : L.strokeAltSel
    }
    
    static func strokeAltUns(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeAltUns : L.strokeAltUns
    }
    
    static func strokeDis(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeDis : L.strokeDis
    }
    
    // Fill Colors
    static func fillRegSelUnm(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegSelUnm : L.fillRegSelUnm
    }
    
    static func fillRegSelMod(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegSelMod : L.fillRegSelMod
    }
    
    static func fillRegUnsUnm(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegUnsUnm : L.fillRegUnsUnm
    }
    
    static func fillRegUnsMod(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegUnsMod : L.fillRegUnsMod
    }
    
    static func fillAltSelUnm(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillAltSelUnm : L.fillAltSelUnm
    }
    
    static func fillAltSelMod(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillAltSelMod : L.fillAltSelMod
    }
    
    static func fillAltUnsUnm(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillAltUnsUnm : L.fillAltUnsUnm
    }
    
    static func fillAltUnsMod(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillAltUnsMod : L.fillAltUnsMod
    }
    
    static func fillDis(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillDis : L.fillDis
    }
    
    static func fillGrb(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillGrb : L.fillGrb
    }
    
    // Tan Point Colors
    static func tanPointFillSel(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.tanPointFillSel : L.tanPointFillSel
    }
    
    static func tanPointFillUns(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.tanPointFillUns : L.tanPointFillUns
    }
    
}
