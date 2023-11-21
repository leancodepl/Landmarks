import SwiftUI

struct LandmarkList: View {
  @EnvironmentObject var modelData: ModelData
  @State private var showFavoritesOnly = false

  var filteredLandmarks: [Landmark] {
    modelData.landmarks.filter { landmark in
      if showFavoritesOnly {
        return landmark.isFavorite
      }

      return true
    }
  }

  func makeLabel(_ landmark: Landmark) -> String {
    var label = landmark.name
    if landmark.isFavorite {
      label = label + ", favorited"
    }

    return label
  }

  var body: some View {
    NavigationView {
      List {
        Toggle(isOn: $showFavoritesOnly) {
          Text("Favorites only")
        }
        ForEach(filteredLandmarks) { landmark in
          NavigationLink {
            LandmarkDetail(landmark: landmark)
          } label: {
            LandmarkRow(landmark: landmark)
              .accessibilityLabel(makeLabel(landmark))
          }
          .navigationTitle("Landmarks")
        }
      }
    }
  }
}

struct LandmarkList_Previews: PreviewProvider {
  static var previews: some View {
    LandmarkList().environmentObject(ModelData())
  }
}
