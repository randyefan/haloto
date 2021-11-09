import UIKit
import AsyncDisplayKit


class ExampleViewController: ASDKViewController<ASDisplayNode> {

    // MARK: - Initializer (Required)


    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        let profile = Profile(profilePicture: "profile-image-placeholder",
            profileName: "Bowo Santoso",
            profileEmail: "bowo@santosocompany.com",
            profilePhone: "087774584922",
            authorizationToken: ""
        )

        let button = SmallButtonNode(title: "Trigger Bottom Sheet", buttonState: .Yellow) { [weak self] in
            let vc = EditProfileContoller(profile: Profile(profilePicture: "profile-image-placeholder",
                profileName: "Bowo Santoso",
                profileEmail: "bowo@santosocompany.com",
                profilePhone: "087774584922",
                authorizationToken: ""))

            let bottomSheetVC = BottomSheetViewController(wrapping: vc)
            self?.navigationController?.present(bottomSheetVC, animated: true, completion: nil)
        }
        node.layoutSpecBlock = { _, _ in
            return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: .infinity, left: 103, bottom: .infinity, right: 103),
                child: button
            )
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .blueApp
    }
}

let sampleUpcomingMaintenance: UpcomingMaintenance =
    UpcomingMaintenance(components: [Component(name: "Accu",
    lastReplacementOdometer: 20000,
    lastReplacementDate: "1 Jan 2020",
    lifetimeOdometer: 0,
    lifetimeDate: "1 Jan 2019")],
    nextServiceOdometer: 40000,
    nextServiceDate: "1 Jan 2021")

