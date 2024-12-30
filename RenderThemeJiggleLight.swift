//
//  RenderThemeLight.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation

// Light theme implementation
struct RenderThemeJiggleLight: RenderThemeJiggleImplementing {
    
    let bloom: RGBA
    
    let centerMarkerUnselectedActive: RGBA
    
    let strokeRegSel: RGBA
    let strokeRegUns: RGBA
    let strokeAltSel: RGBA
    let strokeAltUns: RGBA
    let strokeDis: RGBA
    
    let fillRegSelUnm: RGBA
    let fillRegSelMod: RGBA
    let fillRegUnsUnm: RGBA
    let fillRegUnsMod: RGBA
    let fillAltSelUnm: RGBA
    let fillAltSelMod: RGBA
    let fillAltUnsUnm: RGBA
    let fillAltUnsMod: RGBA
    let fillDis: RGBA
    let fillGrb: RGBA
    
    //let tanBarFillSel: RGBA
    //let tanBarFillUns: RGBA
    
    let tanPointFillSel: RGBA
    let tanPointFillUns: RGBA

    init() {
        let colors = RenderThemeJiggleColorPack(colorNamePostfix: "_lgt")
        
        self.bloom = colors.bloom
        
        self.centerMarkerUnselectedActive = colors.centerMarkerUnselectedActive
        
        self.strokeRegSel = colors.strokeRegSel
        self.strokeRegUns = colors.strokeRegUns
        self.strokeAltSel = colors.strokeAltSel
        self.strokeAltUns = colors.strokeAltUns
        self.strokeDis = colors.strokeDis
        
        self.fillRegSelUnm = colors.fillRegSelUnm
        self.fillRegSelMod = colors.fillRegSelMod
        self.fillRegUnsUnm = colors.fillRegUnsUnm
        self.fillRegUnsMod = colors.fillRegUnsMod
        self.fillAltSelUnm = colors.fillAltSelUnm
        self.fillAltSelMod = colors.fillAltSelMod
        self.fillAltUnsUnm = colors.fillAltUnsUnm
        self.fillAltUnsMod = colors.fillAltUnsMod
        self.fillDis = colors.fillDis
        self.fillGrb = colors.fillGrb
        
        //self.tanBarFillSel = colors.tanBarFillSel
        //self.tanBarFillUns = colors.tanBarFillUns
        
        self.tanPointFillSel = colors.tanPointFillSel
        self.tanPointFillUns = colors.tanPointFillUns
    }
}
