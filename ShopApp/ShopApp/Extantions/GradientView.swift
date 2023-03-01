//
//  GradientView.swift
//  ShopApp
//
//  Created by Abduraxmon on 01/03/23.
//

import UIKit

final class GradiantView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        
        let traits = UITraitCollection.current
        let color: CGFloat = traits.userInterfaceStyle == .light ? 0.314 : 1
        
        let components : [CGFloat] = [
            color,color,color,0.2,
            color,color,color,0.4,
            color,color,color,0.6,
            color,color,color,1,
        ]
        
        let location: [CGFloat] = [0, 0.5, 0.75 , 1]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: location, count: 4)
        
        let x = bounds.midX
        let y = bounds.midY
        
        let centrPoint = CGPoint(x: x, y: y)
        let radius = max(x, y)
        
        let context = UIGraphicsGetCurrentContext()
        context?.drawRadialGradient(gradient!, startCenter: centrPoint, startRadius: 0, endCenter: centrPoint, endRadius: radius, options: .drawsAfterEndLocation)
        
    }
    
}
