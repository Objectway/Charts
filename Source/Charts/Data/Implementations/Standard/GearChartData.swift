//
//  GearChartData
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation

open class GearChartData: ChartData
{
    public override init()
    {
        super.init()
    }
    
    public override init(dataSets: [IChartDataSet]?)
    {
        super.init(dataSets: dataSets)
    }

    var dataSet: IGearChartDataSet?
    {
        get
        {
            return dataSets.count > 0 ? dataSets[0] as? IGearChartDataSet : nil
        }
        set
        {
            if newValue != nil
            {
                dataSets = [newValue!]
            }
            else
            {
                dataSets = []
            }
        }
    }
    
    open override func getDataSetByIndex(_ index: Int) -> IChartDataSet?
    {
        if index != 0
        {
            return nil
        }
        return super.getDataSetByIndex(index)
    }
    
    open override func getDataSetByLabel(_ label: String, ignorecase: Bool) -> IChartDataSet?
    {
        if dataSets.count == 0 || dataSets[0].label == nil
        {
            return nil
        }
        
        if ignorecase
        {
            if (label.caseInsensitiveCompare(dataSets[0].label!) == ComparisonResult.orderedSame)
            {
                return dataSets[0]
            }
        }
        else
        {
            if label == dataSets[0].label
            {
                return dataSets[0]
            }
        }
        return nil
    }
    
    open override func entryForHighlight(_ highlight: Highlight) -> ChartDataEntry?
    {
        return dataSet?.entryForIndex(Int(highlight.x))
    }
    
    open override func addDataSet(_ d: IChartDataSet!)
    {   
        super.addDataSet(d)
    }
    
    /// Removes the DataSet at the given index in the DataSet array from the data object.
    /// Also recalculates all minimum and maximum values.
    ///
    /// - returns: `true` if a DataSet was removed, `false` ifno DataSet could be removed.
    open override func removeDataSetByIndex(_ index: Int) -> Bool
    {
        if index >= _dataSets.count || index < 0
        {
            return false
        }
        
        return false
    }
    
    /// - returns: The total y-value sum across all DataSet objects the this object represents.
    open var yValueSum: Double
    {
        guard let dataSet = dataSet else { return 0.0 }
        
        var yValueSum: Double = 0.0
        
        for i in 0..<dataSet.entryCount
        {
            yValueSum += dataSet.entryForIndex(i)?.y ?? 0.0
        }
        
        return yValueSum
    }
}
