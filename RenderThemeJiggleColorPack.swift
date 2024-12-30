//
//  RenderThemeJiggleColorPack.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation

// Color pack structure
struct RenderThemeJiggleColorPack {
    
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

    init(colorNamePostfix: String) {
        
        bloom = AnyRenderTheme.loadRGBA(colorName: "bloom", colorNamePostfix: colorNamePostfix)
        
        centerMarkerUnselectedActive = AnyRenderTheme.loadRGBA(colorName: "ctr_mrk_uns_act", colorNamePostfix: colorNamePostfix)
        
        strokeRegSel = AnyRenderTheme.loadRGBA(colorName: "stroke_reg_sel", colorNamePostfix: colorNamePostfix)
        strokeRegUns = AnyRenderTheme.loadRGBA(colorName: "stroke_reg_uns", colorNamePostfix: colorNamePostfix)
        strokeAltSel = AnyRenderTheme.loadRGBA(colorName: "stroke_alt_sel", colorNamePostfix: colorNamePostfix)
        strokeAltUns = AnyRenderTheme.loadRGBA(colorName: "stroke_alt_uns", colorNamePostfix: colorNamePostfix)
        strokeDis = AnyRenderTheme.loadRGBA(colorName: "stroke_dis", colorNamePostfix: colorNamePostfix)

        fillRegSelUnm = AnyRenderTheme.loadRGBA(colorName: "fill_reg_sel_unm", colorNamePostfix: colorNamePostfix)
        fillRegSelMod = AnyRenderTheme.loadRGBA(colorName: "fill_reg_sel_mod", colorNamePostfix: colorNamePostfix)
        fillRegUnsUnm = AnyRenderTheme.loadRGBA(colorName: "fill_reg_uns_unm", colorNamePostfix: colorNamePostfix)
        fillRegUnsMod = AnyRenderTheme.loadRGBA(colorName: "fill_reg_uns_mod", colorNamePostfix: colorNamePostfix)
        fillAltSelUnm = AnyRenderTheme.loadRGBA(colorName: "fill_alt_sel_unm", colorNamePostfix: colorNamePostfix)
        fillAltSelMod = AnyRenderTheme.loadRGBA(colorName: "fill_alt_sel_mod", colorNamePostfix: colorNamePostfix)
        fillAltUnsUnm = AnyRenderTheme.loadRGBA(colorName: "fill_alt_uns_unm", colorNamePostfix: colorNamePostfix)
        fillAltUnsMod = AnyRenderTheme.loadRGBA(colorName: "fill_alt_uns_mod", colorNamePostfix: colorNamePostfix)
        fillDis = AnyRenderTheme.loadRGBA(colorName: "fill_dis", colorNamePostfix: colorNamePostfix)
        fillGrb = AnyRenderTheme.loadRGBA(colorName: "fill_grb", colorNamePostfix: colorNamePostfix)

        //tanBarFillSel = AnyRenderTheme.loadRGBA(colorName: "tan_bar_fill_sel", colorNamePostfix: colorNamePostfix)
        //tanBarFillUns = AnyRenderTheme.loadRGBA(colorName: "tan_bar_fill_uns", colorNamePostfix: colorNamePostfix)

        tanPointFillSel = AnyRenderTheme.loadRGBA(colorName: "tan_point_fill_sel", colorNamePostfix: colorNamePostfix)
        tanPointFillUns = AnyRenderTheme.loadRGBA(colorName: "tan_point_fill_uns", colorNamePostfix: colorNamePostfix)
    }
}
