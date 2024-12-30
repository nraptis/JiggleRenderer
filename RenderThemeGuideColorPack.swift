//
//  RenderThemeGuideColorPack.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation

struct RenderThemeGuideColorPack {
    
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
    
    init(colorNamePostfix: String) {
        
        g1_fillRegSelUnm = AnyRenderTheme.loadRGBA(colorName: "g1_fill_reg_sel_unm", colorNamePostfix: colorNamePostfix)
        g2_fillRegSelUnm = AnyRenderTheme.loadRGBA(colorName: "g2_fill_reg_sel_unm", colorNamePostfix: colorNamePostfix)
        g3_fillRegSelUnm = AnyRenderTheme.loadRGBA(colorName: "g3_fill_reg_sel_unm", colorNamePostfix: colorNamePostfix)
        g4_fillRegSelUnm = AnyRenderTheme.loadRGBA(colorName: "g4_fill_reg_sel_unm", colorNamePostfix: colorNamePostfix)
        g5_fillRegSelUnm = AnyRenderTheme.loadRGBA(colorName: "g5_fill_reg_sel_unm", colorNamePostfix: colorNamePostfix)

        g1_fillRegUnsUnm = AnyRenderTheme.loadRGBA(colorName: "g1_fill_reg_uns_unm", colorNamePostfix: colorNamePostfix)
        g2_fillRegUnsUnm = AnyRenderTheme.loadRGBA(colorName: "g2_fill_reg_uns_unm", colorNamePostfix: colorNamePostfix)
        g3_fillRegUnsUnm = AnyRenderTheme.loadRGBA(colorName: "g3_fill_reg_uns_unm", colorNamePostfix: colorNamePostfix)
        g4_fillRegUnsUnm = AnyRenderTheme.loadRGBA(colorName: "g4_fill_reg_uns_unm", colorNamePostfix: colorNamePostfix)
        g5_fillRegUnsUnm = AnyRenderTheme.loadRGBA(colorName: "g5_fill_reg_uns_unm", colorNamePostfix: colorNamePostfix)

        
        g1_fillRegSelMod = AnyRenderTheme.loadRGBA(colorName: "g1_fill_reg_sel_mod", colorNamePostfix: colorNamePostfix)
        g2_fillRegSelMod = AnyRenderTheme.loadRGBA(colorName: "g2_fill_reg_sel_mod", colorNamePostfix: colorNamePostfix)
        g3_fillRegSelMod = AnyRenderTheme.loadRGBA(colorName: "g3_fill_reg_sel_mod", colorNamePostfix: colorNamePostfix)
        g4_fillRegSelMod = AnyRenderTheme.loadRGBA(colorName: "g4_fill_reg_sel_mod", colorNamePostfix: colorNamePostfix)
        g5_fillRegSelMod = AnyRenderTheme.loadRGBA(colorName: "g5_fill_reg_sel_mod", colorNamePostfix: colorNamePostfix)

        g1_fillRegUnsMod = AnyRenderTheme.loadRGBA(colorName: "g1_fill_reg_uns_mod", colorNamePostfix: colorNamePostfix)
        g2_fillRegUnsMod = AnyRenderTheme.loadRGBA(colorName: "g2_fill_reg_uns_mod", colorNamePostfix: colorNamePostfix)
        g3_fillRegUnsMod = AnyRenderTheme.loadRGBA(colorName: "g3_fill_reg_uns_mod", colorNamePostfix: colorNamePostfix)
        g4_fillRegUnsMod = AnyRenderTheme.loadRGBA(colorName: "g4_fill_reg_uns_mod", colorNamePostfix: colorNamePostfix)
        g5_fillRegUnsMod = AnyRenderTheme.loadRGBA(colorName: "g5_fill_reg_uns_mod", colorNamePostfix: colorNamePostfix)
        
        
        g1_tanPointFillSel = AnyRenderTheme.loadRGBA(colorName: "g1_tan_point_fill_sel", colorNamePostfix: colorNamePostfix)
        g2_tanPointFillSel = AnyRenderTheme.loadRGBA(colorName: "g2_tan_point_fill_sel", colorNamePostfix: colorNamePostfix)
        g3_tanPointFillSel = AnyRenderTheme.loadRGBA(colorName: "g3_tan_point_fill_sel", colorNamePostfix: colorNamePostfix)
        g4_tanPointFillSel = AnyRenderTheme.loadRGBA(colorName: "g4_tan_point_fill_sel", colorNamePostfix: colorNamePostfix)
        g5_tanPointFillSel = AnyRenderTheme.loadRGBA(colorName: "g5_tan_point_fill_sel", colorNamePostfix: colorNamePostfix)

        g1_tanPointFillUns = AnyRenderTheme.loadRGBA(colorName: "g1_tan_point_fill_uns", colorNamePostfix: colorNamePostfix)
        g2_tanPointFillUns = AnyRenderTheme.loadRGBA(colorName: "g2_tan_point_fill_uns", colorNamePostfix: colorNamePostfix)
        g3_tanPointFillUns = AnyRenderTheme.loadRGBA(colorName: "g3_tan_point_fill_uns", colorNamePostfix: colorNamePostfix)
        g4_tanPointFillUns = AnyRenderTheme.loadRGBA(colorName: "g4_tan_point_fill_uns", colorNamePostfix: colorNamePostfix)
        g5_tanPointFillUns = AnyRenderTheme.loadRGBA(colorName: "g5_tan_point_fill_uns", colorNamePostfix: colorNamePostfix)
        
    }
}