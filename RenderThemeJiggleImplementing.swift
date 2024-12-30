//
//  RenderThemeImplementing.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import UIKit


// Jiggle Center Marker moves between 3 modes:
// 1.) "Selected" (could be the Jiggle is selected, or could be the marker is selected...)
// 2.) "Not-Selected, Inactive" We're *not* in center-marker mode, and not selected.
// 3.) "Not-Selected, Active" We're in center-marker mode, and not selected.



// 3-letter color codes

// (Prefix #1)
// reg (regular state, we just group them...)
// dis (ghost state, locked, disabled)
// alt (alternative state. for example, we're editing centers, the points are "alternative")

// (Postfix)
// lgt (light mode) - This will only exist because XC Swift combines all catalogs.
// drk (dark mode ) - This will only exist because XC Swift combines all catalogs.

// grb (grabbed    variant; this is like... grabbed)
// uns (unselected variant; if it includes selected and unselected)
// sel (unselected variant; if it includes selected and unselected)

// ina (inactive variant; If it includes active and inactive)
// act (active variant  ; If it includes active and inactive)

// str (stroke, as opposed to fill  )
// fil (fill,   as opposed to stroke)

// mod (modified   variant; if it includes modified and unmodified)
// unm (unmodified variant; if it includes modified and unmodified)


// Center marker... The exact 3...

// (X) ctr_mrk_sel (this will be the general "selected" color)
// ctr_mrk_uns_act
// ctr_mrk_uns_ina

// Strokes...
// stroke_reg_sel
// stroke_reg_uns
// stroke_alt_sel
// stroke_alt_uns
// stroke_dis

// Fills...
// fill_reg_sel_unm
// fill_reg_sel_mod
// fill_reg_uns_unm
// fill_reg_uns_mod
// fill_alt_sel_unm
// fill_alt_sel_mod
// fill_alt_uns_unm
// fill_alt_uns_mod
// fill_dis
// fill_grb

// Tan Bar
// tan_bar_fill_sel
// tan_bar_fill_uns

// Tan Point
// tan_point_fill_sel
// tan_point_fill_uns

protocol RenderThemeJiggleImplementing: RenderThemeImplementing {
    
    var centerMarkerUnselectedActive: RGBA { get }
    
    var strokeRegSel: RGBA { get }
    var strokeRegUns: RGBA { get }
    var strokeAltSel: RGBA { get }
    var strokeAltUns: RGBA { get }
    var strokeDis: RGBA { get }
    
    var fillRegSelUnm: RGBA { get }
    var fillRegSelMod: RGBA { get }
    var fillRegUnsUnm: RGBA { get }
    var fillRegUnsMod: RGBA { get }
    var fillAltSelUnm: RGBA { get }
    var fillAltSelMod: RGBA { get }
    var fillAltUnsUnm: RGBA { get }
    var fillAltUnsMod: RGBA { get }
    var fillDis: RGBA { get }
    var fillGrb: RGBA { get }
    
    var tanPointFillSel: RGBA { get }
    var tanPointFillUns: RGBA { get }
}

