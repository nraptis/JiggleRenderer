//
//  RenderThemeGuideLight.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation

struct RenderThemeGuideLight: RenderThemeGuideImplementing {
    
    let g1_fillRegSelUnm: RGBA
    let g2_fillRegSelUnm: RGBA
    let g3_fillRegSelUnm: RGBA
    let g4_fillRegSelUnm: RGBA
    let g5_fillRegSelUnm: RGBA
    
    let g1_fillRegUnsUnm: RGBA
    let g2_fillRegUnsUnm: RGBA
    let g3_fillRegUnsUnm: RGBA
    let g4_fillRegUnsUnm: RGBA
    let g5_fillRegUnsUnm: RGBA
    
    let g1_fillRegSelMod: RGBA
    let g2_fillRegSelMod: RGBA
    let g3_fillRegSelMod: RGBA
    let g4_fillRegSelMod: RGBA
    let g5_fillRegSelMod: RGBA
    
    let g1_fillRegUnsMod: RGBA
    let g2_fillRegUnsMod: RGBA
    let g3_fillRegUnsMod: RGBA
    let g4_fillRegUnsMod: RGBA
    let g5_fillRegUnsMod: RGBA
    
    let g1_tanPointFillSel: RGBA
    let g2_tanPointFillSel: RGBA
    let g3_tanPointFillSel: RGBA
    let g4_tanPointFillSel: RGBA
    let g5_tanPointFillSel: RGBA

    let g1_tanPointFillUns: RGBA
    let g2_tanPointFillUns: RGBA
    let g3_tanPointFillUns: RGBA
    let g4_tanPointFillUns: RGBA
    let g5_tanPointFillUns: RGBA
    
    init() {
        let colors = RenderThemeGuideColorPack(colorNamePostfix: "_lgt")
        
        
        self.g1_fillRegSelUnm = colors.g1_fillRegSelUnm
        self.g2_fillRegSelUnm = colors.g2_fillRegSelUnm
        self.g3_fillRegSelUnm = colors.g3_fillRegSelUnm
        self.g4_fillRegSelUnm = colors.g4_fillRegSelUnm
        self.g5_fillRegSelUnm = colors.g5_fillRegSelUnm
        
        self.g1_fillRegUnsUnm = colors.g1_fillRegUnsUnm
        self.g2_fillRegUnsUnm = colors.g2_fillRegUnsUnm
        self.g3_fillRegUnsUnm = colors.g3_fillRegUnsUnm
        self.g4_fillRegUnsUnm = colors.g4_fillRegUnsUnm
        self.g5_fillRegUnsUnm = colors.g5_fillRegUnsUnm
        
        self.g1_fillRegSelMod = colors.g1_fillRegSelMod
        self.g2_fillRegSelMod = colors.g2_fillRegSelMod
        self.g3_fillRegSelMod = colors.g3_fillRegSelMod
        self.g4_fillRegSelMod = colors.g4_fillRegSelMod
        self.g5_fillRegSelMod = colors.g5_fillRegSelMod
        
        self.g1_fillRegUnsMod = colors.g1_fillRegUnsMod
        self.g2_fillRegUnsMod = colors.g2_fillRegUnsMod
        self.g3_fillRegUnsMod = colors.g3_fillRegUnsMod
        self.g4_fillRegUnsMod = colors.g4_fillRegUnsMod
        self.g5_fillRegUnsMod = colors.g5_fillRegUnsMod
        
        self.g1_tanPointFillSel = colors.g1_tanPointFillSel
        self.g2_tanPointFillSel = colors.g2_tanPointFillSel
        self.g3_tanPointFillSel = colors.g3_tanPointFillSel
        self.g4_tanPointFillSel = colors.g4_tanPointFillSel
        self.g5_tanPointFillSel = colors.g5_tanPointFillSel

        self.g1_tanPointFillUns = colors.g1_tanPointFillUns
        self.g2_tanPointFillUns = colors.g2_tanPointFillUns
        self.g3_tanPointFillUns = colors.g3_tanPointFillUns
        self.g4_tanPointFillUns = colors.g4_tanPointFillUns
        self.g5_tanPointFillUns = colors.g5_tanPointFillUns
    }
}
