import SwiftUI

struct OptionalItemWrapper<T>: Identifiable {
    let id = UUID()
    let item: T?

    init(item: T?) {
        self.item = item
    }
}

struct FakeListView<T, Content: View, D: View>: View {
    let items: [T]
    let content: (T) -> Content
    let divider: D
    
    init(
        items: [T],
        @ViewBuilder content: @escaping (T) -> Content,
        @ViewBuilder divider: @escaping () -> D = { Divider() }
    ) {
        self.items = items
        self.content = content
        self.divider = divider()
    }
    
    var body: some View {
        makeItemContent()
    }
    
    @ViewBuilder
    func makeItemContent() -> some View {
        let itemsOrDivider = makeItemsOrDivider()
        
        VStack(alignment: .leading) {
            ForEach(itemsOrDivider, id: \.id) { itemOrDivider in
                if let item = itemOrDivider.item {
                    content(item)
                } else {
                    divider
                }
            }
        }
    }
    
    func makeItemsOrDivider() -> [OptionalItemWrapper<T>] {
        let existingItems = items.map(OptionalItemWrapper.init(item:))
        let dividerCount = max(0, existingItems.count - 1)
        
        let dividers = Array(0 ..< dividerCount).map { _ in OptionalItemWrapper<T>(item: nil) }
        
        var itemsOrDivider: [OptionalItemWrapper<T>] = zip(existingItems, dividers).flatMap { [$0, $1] }

        if let last = existingItems.last {
            itemsOrDivider.append(last)
        }
        return itemsOrDivider
    }
}
