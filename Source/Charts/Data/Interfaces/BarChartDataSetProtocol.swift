//
//  BarChartDataSetProtocol.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import CoreGraphics

@objc
public protocol BarChartDataSetProtocol: BarLineScatterCandleBubbleChartDataSetProtocol
{
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    /// `true` if this DataSet is stacked (stacksize > 1) or not.
    var isStacked: Bool { get }
    
    /// The maximum number of bars that can be stacked upon another in this DataSet.
    var stackSize: Int { get }
    
    /// the color used for drawing the bar-shadows. The bar shadows is a surface behind the bar that indicates the maximum value
    var barShadowColor: NSUIColor { get set }
    
    /// the width used for drawing borders around the bars. If borderWidth == 0, no border will be drawn.
    var barBorderWidth : CGFloat { get set }

    /// the color drawing borders around the bars.
    var barBorderColor: NSUIColor { get set }

    /// the alpha value (transparency) that is used for drawing the highlight indicator bar. min = 0.0 (fully transparent), max = 1.0 (fully opaque)
    var highlightAlpha: CGFloat { get set }
    
    /// array of labels used to describe the different values of the stacked bars
    var stackLabels: [String] { get set }
	
	/// - returns: 'true' if the bars have rounded corners
	var hasRoundedCorners : Bool { get set }
	
	/// - returns: 'true' if the bars have rounded corners and the chart is stacked
	var isStackedWithRoundedCorners : Bool { get set }
	
	/// - returns: The corner radius is used for drawing the bars with rounded corners (only used if 'hasRoundedCorners' is true)
	var barCornerRadius : CGFloat { get set }

	// MARK: - Gradient

	/// - returns: 'true' if the chart is gradient filled
	var isGradientFill: Bool { get }

	/// - returns: The start point for the gradient fill
	var gradientStartPoint : CGFloat { get set }
	
	/// - returns: The end point for the gradient fill
	var gradientEndPoint : CGFloat { get set }
	
	/// - returns: array of colors used for gradient filling
	var gradientColors: [NSUIColor] { get set }
	
	/// - returns: The gradient color at the given index of the DataSet's gradientColors array
	func gradientColor(atIndex: Int) -> NSUIColor

	
}
