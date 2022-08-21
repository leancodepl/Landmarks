import SwiftUI

struct Badge: View {
  var badgeSymbols: some View {
    ForEach(0..<8) { index in
      RotatedBadgeSymbol(angle: Angle(degrees: 45 * Double(index)))
        .opacity(0.5)
    }
  }

  var body: some View {
    ZStack {
      BadgeBackground()

      GeometryReader { geometry in
        badgeSymbols
          .scaleEffect(1.0 / 4.0, anchor: .top)
          .position(
            x: geometry.size.width / 2.0,
            y: (3.0 / 4.0) * geometry.size.height
          )
      }
    }
    .scaledToFit()
  }
}

struct Badge_Previews: PreviewProvider {
  static var previews: some View {
    Badge()
  }
}
