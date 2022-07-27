//
//  PizzaChart.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

struct ChartItem: Hashable {
    let name: String
    let value: Double
    let color: Color
}

struct PieSlice: Shape {
    let radius: Double
    let startAngle: Double
    let endAngle: Double
    
    func path(in rect: CGRect) -> Path {
        var arc = Path()
        arc.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: .degrees(startAngle), endAngle: .degrees(endAngle), clockwise: false)
        arc.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        arc.closeSubpath()
        return arc
    }
}

struct ChartLegend: View {
    let items: [ChartItem]
    
    var body: some View {
        VStack {
            ForEach(items, id: \.self) { item in
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(item.color)
                        .frame(width: 18, height: 18)
                    /*@START_MENU_TOKEN@*/Text(item.name)/*@END_MENU_TOKEN@*/
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct PizzaChart: View {
    let radius: Double
    let items: [ChartItem]
    var angles: [Double] = []
    
    init(radius: Double, items: [ChartItem]) {
        self.radius = radius
        self.items = items
        
        var sum = 0.0
        items.forEach { item in
            sum += item.value
        }
        
        let per = 360 / sum
        var last = 0.0
        items.forEach { item in
            let a = last + (per * item.value)
            angles.append(a)
            
            last = a
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                ForEach(0...items.count-1, id: \.self) { index in
                    PieSlice(radius: radius, startAngle: (index == 0) ? 0.0 : angles[index - 1], endAngle: angles[index])
                        .foregroundColor(items[index].color)
                }
            }
            ChartLegend(items: items)
        }
    }
}
