import SwiftUI

struct PackItemCell: View {
    let item: PackItem
    @ScaledMetric var width = 20.0
    
    var body: some View {
        Label(
            title: {
                Text(item.name)
            },
            icon: {
                item.icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: width)
            }
        )
        .labelStyle(.icon)
    }
}

