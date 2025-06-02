import SwiftUI

struct SearchCarouselView: View {
    @State private var offset = 18.5
    @State private var index = 0
    @State private var id: Bool = false
    
    private let timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
    var hints: [String] = ["farms", "fields", "crops"]
    
    var body: some View {
        
        HStack (spacing: 0) {
            Text("Search ")
                .foregroundStyle(Color(UIColor.secondaryLabel))
            Text(hints[index]).transition(textTransition)
                .foregroundStyle(Color(UIColor.secondaryLabel))
                .id(id)
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.bouncy) {
                if index < 2 {
                    index += 1
                } else {
                    index = 0
                }
                id.toggle()
            }
        })
        .opacity(0.6)
    }
}

#Preview {
    SearchCarouselView()
}

private var textTransition: AnyTransition {
    .asymmetric(
        insertion: .move(edge: .bottom).combined(with: .opacity),
        removal: .move(edge: .top).combined(with: .opacity)
    )
}
