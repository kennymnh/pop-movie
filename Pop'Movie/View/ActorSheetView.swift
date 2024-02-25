import SwiftUI

struct ActorSheetView: View {
    // MARK: PROPERTIES
    @State var actor: CastPerson
    
    
    // MARK: BODY
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("Acteur")
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(actor.name)
                    .font(.subheadline)
                    .foregroundStyle(.opacity(0.4))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                Text("Role")
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(actor.character ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.opacity(0.4))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(30)
    }
}

// MARK: PREVIEW
//#Preview {
//    ActorSheetView()
//}
