//
//  PizzaChart.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 18.07.2022.
//

import SwiftUI

/// Item for chart
struct ChartItem: Hashable {
    let name: String
    let value: Double
    let color: Color
}

/// Pie slide shape
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

/// Legend view for chart
struct ChartLegend: View {
    let items: [ChartItem]
    
    var body: some View {
        VStack {
            ForEach(0...items.count-1, id: \.self) { index in
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(items[index].color)
                        .frame(width: 18, height: 18)
                        .shadow(color: items[index].color, radius: 2)
                    Text(items[index].name)
                        .opacity(0.6)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

/// Pizza chart view
struct PizzaChart: View {
    let radius: Double
    let items: [ChartItem]
    var angles: [Double] = []
    
    init(radius: Double, items: [ChartItem]) {
        self.radius = radius
        self.items = items
        
        // calculating sum
        var sum = 0.0
        items.forEach { item in
            sum += item.value
        }
        
        // calculating angles
        let per = 360 / sum
        var last = 0.0
        items.forEach { item in
            let value = last + (per * item.value)
            angles.append(value)
            
            last = value
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                ForEach(0...items.count-1, id: \.self) { index in
                    PieSlice(radius: radius, startAngle: (index == 0) ? 0.0 : angles[index - 1], endAngle: angles[index])
                        .foregroundColor(items[index].color)
                        .shadow(color: items[index].color, radius: 2)
                }
            }
            ChartLegend(items: items)
        }
    }
}

struct PizzaChartPreview: PreviewProvider {
    static var previews: some View {
        PizzaChart(radius: 60, items: [
            ChartItem(name: "first", value: 1, color: .red),
            ChartItem(name: "second", value: 3, color: .blue)
        ])
    }
}
