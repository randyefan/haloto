import UIKit
import AsyncDisplayKit

class dataDummy {
    var vehicle = Vehicle(
        name: "BRIO",
        fuelType: "Petrol",
        manufacture: "HONDA",
        manufacturedYear: "2015",
        capacity: 1100,
        transmissionType: "Automatic",
        licensePlate: "A 1232 RE",
        isDefault: true
    )

    var profile = Profile(profilePicture: nil,
                          profileName: "Bowo Santoso",
                          profileEmail: "bowo@santosocompany.com",
                          profilePhone: "087774584922",
                          authorizationToken: "")

    var upcomingMaintenance = UpcomingMaintenance(components: [
        Component(name: "AOSIOAISASOD",
                  componentImage: "",
                  lastReplacementOdometer: 123123,
                  lastReplacementDate: "12 Oktober 2021",
                  lifetimeOdometer: 123123,
                  lifetimeDate: "12 Oktober 2021"),
    ],
    nextServiceOdometer: 123123,
    nextServiceDate: "12 Oktober 2021"
    )
}

class ExampleViewController: ASDKViewController<ASDisplayNode> {

    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
//        node.layoutSpecBlock = { _, _ in
//            ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 16, bottom: .infinity, right: 16), child: card)
//
//        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

