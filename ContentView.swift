import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    
    @AppStorage("firstLaunch") var firstLaunch = true
    @State var onboardingPresented = false
    @State var courseProgress = CourseProgress()
    @State var columnVisibility: NavigationSplitViewVisibility = .all
    
    @State private var detailPresented: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > 600 {
                DefaultView
            } else {
                ContentUnavailableView(
                    "Unsupported window size",
                    systemImage: "rectangle.split.2x1.slash",
                    description: Text(
                        "Unfortunately, Wayfinder does not support Slide Over and narrow Split View sizes."
                    )
                )
            }
        }
    }
    
    var DefaultView: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List {
                SidebarTitle
                
                
                VStack(alignment: .leading, spacing: 20) {
                    CourseTabView(selectedTab: $courseProgress.currentItem)
                        .environment(courseProgress)
                        .padding(.top, 15)
                    
                    Divider()
                    
                    HiddenPrize
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.none)
            .scrollContentBackground(.hidden)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu("More", systemImage: "ellipsis.circle") {
                        Button("Reset Progress", systemImage: "arrow.clockwise") {
                            courseProgress.resetProgress()
                            firstLaunch = true
                            onboardingPresented = true
                        }
                    }
                }
            }
            
        } detail: {
            
            switch courseProgress.currentSection {
            case .lesson:
                ContentBuilder(lesson: Course[courseProgress.currentItem])
                    .environment(courseProgress)
            case .map:
                SubwayMap()
                    .transition(.opacity)
                    .navigationTitle("System Map")
                    .navigationBarTitleDisplayMode(.inline)
            case .finalQuiz:
                QuizView(quiz: finalQuiz)
                    .environment(courseProgress)
            }
            
        }
        .task {
            if firstLaunch {
                onboardingPresented = true
            }
        }
        .sheet(isPresented: $onboardingPresented, onDismiss: {
            firstLaunch = false
        }) {
            Onboarding()
        }
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
    
    var SidebarTitle: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text("Wayfinder")
                Image(systemName: "train.side.front.car")
                    .foregroundStyle(Color.accentColor)
            }
            Text("Wayfinder")
        }
        .font(.largeTitle)
        .fontWeight(.bold)
    }
    
    var HiddenPrize: some View {
        Group {
            if courseProgress.finalQuiz {
                Button {
                    withAnimation(.smooth) {
                        courseProgress.currentSection = .map
                    }
                } label: {
                    Label("System Map", systemImage: "map.fill")
                        .frame(maxWidth: .infinity)
                }
                .tint(.accentColor)
                .buttonStyle(.bordered)
                .controlSize(.large)
            } else {
                Button {
                } label: {
                    Label("Complete Final Quiz", systemImage: "lock.fill")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                }
                .tint(.secondary)
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
    }
}
