//
//  BarChartDataSet.swift
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


open class BarChartDataSet: BarLineScatterCandleBubbleChartDataSet, BarChartDataSetProtocol
{
    private func initialize()
    {
        self.highlightColor = NSUIColor.black
        
        self.calcStackSize(entries: entries as! [BarChartDataEntry])
        self.calcEntryCountIncludingStacks(entries: entries as! [BarChartDataEntry])
    }
    
    public required init()
    {
        super.init()
        initialize()
    }
    
    public override init(entries: [ChartDataEntry], label: String)
    {
        super.init(entries: entries, label: label)
        initialize()
    }

    // MARK: - Data functions and accessors
    
    /// the maximum number of bars that are stacked upon each other, this value
    /// is calculated from the Entries that are added to the DataSet
    private var _stackSize = 1
    
    /// the overall entry count, including counting each stack-value individually
    private var _entryCountStacks = 0
    
    /// Calculates the total number of entries this DataSet represents, including
    /// stacks. All values belonging to a stack are calculated separately.
    private func calcEntryCountIncludingStacks(entries: [BarChartDataEntry])
    {
        _entryCountStacks = 0
        
        entries.forEach { _entryCountStacks += $0.yValues?.count ?? 1 }
    }
    
    /// calculates the maximum stacksize that occurs in the Entries array of this DataSet
    private func calcStackSize(entries: [BarChartDataEntry])
    {
        for e in entries where (e.yValues?.count ?? 0) > _stackSize
        {
            _stackSize = e.yValues!.count
        }
    }
    
    open override func calcMinMax(entry e: ChartDataEntry)
    {
        guard let e = e as? BarChartDataEntry,
            !e.y.isNaN
            else { return }
        
        if e.yValues == nil
        {
            _yMin = Swift.min(e.y, _yMin)
            _yMax = Swift.max(e.y, _yMax)
        }
        else
        {
            _yMin = Swift.min(-e.negativeSum, _yMin)
            _yMax = Swift.max(e.positiveSum, _yMax)
        }

        calcMinMaxX(entry: e)
    }
    
    /// The maximum number of bars that can be stacked upon another in this DataSet.
    open var stackSize: Int
    {
        return _stackSize
    }
    
    /// `true` if this DataSet is stacked (stacksize > 1) or not.
    open var isStacked: Bool
    {
        return _stackSize > 1
    }
    
    /// The overall entry count, including counting each stack-value individually
    @objc open var entryCountStacks: Int
    {
        return _entryCountStacks
    }
    
    /// array of labels used to describe the different values of the stacked bars
    open var stackLabels: [String] = []
    
    // MARK: - Styling functions and accessors
    
    /// the color used for drawing the bar-shadows. The bar shadows is a surface behind the bar that indicates the maximum value
    open var barShadowColor = NSUIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1.0)

    /// the width used for drawing borders around the bars. If borderWidth == 0, no border will be drawn.
    open var barBorderWidth : CGFloat = 0.0

    /// the color drawing borders around the bars.
    open var barBorderColor = NSUIColor.black

    /// the alpha value (transparency) that is used for drawing the highlight indicator bar. min = 0.0 (fully transparent), max = 1.0 (fully opaque)
    open var highlightAlpha = CGFloat(120.0 / 255.0)
	
	/// - returns: 'true' if the bars have rounded corners
	open var hasRoundedCorners : Bool = false
	
	/// - returns: 'true' if the bars of the stacked chart have rounded corners
	open var isStackedWithRoundedCorners : Bool = false
	
	/// - returns: The corner radius is used for drawing the bars with rounded corners (only used if 'hasRoundedCorners' is true)
	open var barCornerRadius : CGFloat = 20.0

    
	// MARK: - Gradient
	
	/// - returns: 'true' if the chart is gradient filled
	open var isGradientFill: Bool = false
	
	/// - returns: The start point for the gradient fill
	open var gradientStartPoint : CGFloat = 0.25
	
	/// - returns: The end point for the gradient fill
	open var gradientEndPoint : CGFloat = 1.0
	
	/// array of colors used for gradient filling
	open var gradientColors = [NSUIColor]()
	
	public /// - returns: The gradient color at the given index of the DataSet's gradientColors array
	func gradientColor(atIndex index: Int) -> NSUIColor {
		var index = index
		if index < 0
		{
			index = 0
		}
		return gradientColors[index % colors.count]
	}

	
    // MARK: - NSCopying
    
    open override func copy(with zone: NSZone? = nil) -> Any
    {
        let copy = super.copy(with: zone) as! BarChartDataSet
        copy._stackSize = _stackSize
        copy._entryCountStacks = _entryCountStacks
        copy.stackLabels = stackLabels

        copy.barShadowColor = barShadowColor
        copy.barBorderWidth = barBorderWidth
        copy.barBorderColor = barBorderColor
        copy.highlightAlpha = highlightAlpha
        return copy
    }
}
