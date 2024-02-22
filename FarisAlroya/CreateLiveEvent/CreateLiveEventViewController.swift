

//
//  CreateLiveEventViewController.swift
//  VideoLive
//
//  Created by Minhyuk Kim on 2023/10/13.
//

import UIKit
import PhotosUI
import MobileCoreServices
import SendbirdUIKit
import SendbirdLiveSDK
import Lottie
import SDWebImage
import Alamofire
class CreateLiveEventViewController: UIViewController, UINavigationControllerDelegate, SBUSelectablePhotoViewDelegate, SBUActionSheetDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
    
    let viewModel = MainViewModel()
    var anim: LottieAnimationView!
    var username  = ""
    
    var userImageTxt  = ""
    
    
    var coverImage: UIImage?
    
    public var leftBarButton: UIBarButtonItem?
    public var rightBarButton: UIBarButtonItem?
    
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var userCountLabel: UILabel!
    
    var selectedUserIds: [String] = [] {
        didSet {
            userCountLabel.text = "\(selectedUserIds.count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        if let userId = SendbirdLive.currentUser?.userId {
            selectedUserIds.append(userId)
        }
        let userIDes = ["12","14","65"]
        selectedUserIds = userIDes
        let backButton = UIBarButtonItem(
            title: SBUStringSet.Cancel,
            style: .plain,
            target: self,
            action: #selector(didTapLeftBarButton)
        )
        backButton.tintColor = SBUColorSet.primary200
        let createButton =  UIBarButtonItem(
            title: "Create",
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        createButton.tintColor = SBUColorSet.primary200
        createButton.setTitleTextAttributes([.font: SBUFontSet.button2], for: .normal)
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = createButton
        
        self.navigationController?.sbu_setupNavigationBarAppearance(
            tintColor: SBUColorSet.background500,
            shadowColor: .clear
        )
        
        let title = UILabel()
        title.text = "New Live Event"
        title.font = SBUFontSet.h3
        title.textColor = SBUColorSet.ondark01
        self.navigationItem.titleView = title
        
        titleTextField.font = SBUFontSet.subtitle1
        titleTextField.textColor = SBUColorSet.ondark01
        titleTextField.tintColor = SBUColorSet.ondark01
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "Add a title",
            attributes: [NSAttributedString.Key.foregroundColor: SBUColorSet.ondark03]
        )
        
//        self.fetchUserIds()
        
        
        anim = LottieAnimationView(name: "watings") // Replace "animationName" with your animation file's name
        
        // Set the frame or use Auto Layout constraints
        anim.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        anim.center = self.view.center
        
        // Configure animation properties
        anim.contentMode = .scaleAspectFill
        anim.loopMode = .loop
        
        // Add it to your view
        self.view.addSubview(anim)
        
        // Start playing the animation
        anim.play()
        getUserProfile()
    }
    
    @objc open func didTapLeftBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc open func didTapRightBarButton() {
        self.createLiveEvent()
    }
    
    
    //    open func createLiveEvent() {
    //          self.rightBarButton?.isEnabled = false
    //
    //          let configuration = LiveEvent.CreateParams(
    //              type: .video,
    //              title: titleTextField.text?.isEmpty == true ? nil : titleTextField.text,
    //              coverFile: coverImageView.image?.jpegData(compressionQuality: 0.8),
    //              userIdsForHost: Array(selectedUserIds),
    //              reactionKeys: ["LIKE"]
    //          )
    //
    //          SendbirdLive.createLiveEvent(config: configuration) { [weak self] result in
    //                 DispatchQueue.main.async {
    //                     guard let self = self else { return }
    //
    //                     switch result {
    //                     case .success(let liveEvent):
    //                         print(liveEvent.state.rawValue, "tttttaA")
    //                         liveEvent.setEventReady()
    //  //                       (self.navigationController?.viewControllers.first as? LiveEventListViewController)?.fetchLiveEvents(reset: true)
    //  //                       self.navigationController?.popViewController(animated: true)
    //                         self.showLiveEvent(liveEvent)
    //                     case .failure(let error):
    //                         print("Error creating live event: \(error)")
    //                         self.rightBarButton?.isEnabled = true
    //                         // Handle the error, show an alert, etc.
    //                     }
    //                 }
    //             }
    //      }
    
    func enterLiveEvent(_ liveEvent: LiveEvent) {
        liveEvent.enter { error in
            DispatchQueue.main.async {
                guard error == nil else {
                    SBUAlertView.show(
                        title: "Can't enter yet",
                        message: "This live event will open soon.",
                        oneTimetheme: .light,
                        confirmButtonItem: .init(title: SBUStringSet.OK, completionHandler: { _ in }),
                        cancelButtonItem: nil
                    )
                    return
                }
                
                self.performSegue(withIdentifier: "enterLiveEvent", sender: liveEvent)
            }
        }
    }
    open func createLiveEvent() {
        self.rightBarButton?.isEnabled = false
        
        let configuration = LiveEvent.CreateParams(
            type: .video,
            title: self.username,
            //            coverFile: coverImageView.image?.jpegData(compressionQuazlity: 0.8),
            userIdsForHost: Array(selectedUserIds),
            reactionKeys: ["LIKE"]
        )
        
        SendbirdLive.createLiveEvent(config: configuration) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let liveEvent):
                    print("LLLDIAS",liveEvent.state)
                    liveEvent.enterAsHost(options: .init(turnVideoOn: true, turnAudioOn: true)) { _ in
                        if liveEvent.state == .created {
                            liveEvent.setEventReady()
                        }
                        
                        
                        liveEvent.startStreaming(mediaOptions: nil)
                        self.performSegue(withIdentifier: "enterLiveEvent", sender: liveEvent)
                    }
                    
                    //                    self.enterLiveEvent(liveEvent)
                    
                    
                    
                case .failure(let error):
                    print("Error creating live event: \(error)")
                    self.rightBarButton?.isEnabled = true
                    // Handle the error, show an alert, etc.
                }
            }
        }
    }
    
    //        SendbirdLive.createLiveEvent(config: configuration) { [weak self] result in
    //            DispatchQueue.main.async {
    //                guard let self = self else { return }
    //
    //                switch result {
    //                case .success(let liveEvent):
    //                    print(liveEvent.state.rawValue, "tttttaA")
    //                    liveEvent.setEventReady()
    //                    //                       (self.navigationController?.viewControllers.first as? LiveEventListViewController)?.fetchLiveEvents(reset: true)
    //                    //                       self.navigationController?.popViewController(animated: true)
    //
    //                    liveEvent.enterAsHost(options: .init(turnVideoOn: true, turnAudioOn: true)) { _ in
    //                        if liveEvent.state == .created {
    //                            liveEvent.setEventReady()
    //                        }
    //
    ////                        liveEvent.startStreaming(mediaOptions: nil)
    //                        self.performSegue(withIdentifier: "enterLiveEvent", sender: liveEvent)
    //
    //                    }
    //
    //                    case .failure(let error):
    //                    print("Error creating live event: \(error.localizedDescription)")
    //                        self.rightBarButton?.isEnabled = true
    //                        // Handle the error, show an alert, etc.
    //                    }
    //
    //
    
    
    
    
    
    
    
    private func getUserProfile() {
        
        
        viewModel.getUserProfileData() { [weak self] success, error in
            if success {
                // Update your UI with the results
                // For example, reload a table view or collection view
                let data  = self?.viewModel.profileList?.results
                //                    self?.userImageTxt = data?.user_picture ?? ""
                //
                if  self?.userImageTxt == ""{
                    self?.coverImageView.image = UIImage(named: "navlogo")
                }else {
                    self?.coverImageView.sd_setImage(with:(URL(string: self?.userImageTxt ?? "")), completed: { (image, error, cachType, url) in
                        if error == nil {
                            self?.coverImageView.image = image!
                            
                        }
                    })
                }
                
                self?.coverImage = self?.coverImageView.image
                self?.username =  data?.user_name ?? ""
                //
                //                    self?.birthDate.text =  data?.profile_data?.birth_date ?? ""
                //                    self?.gender.text = data?.profile_data?.gender ?? ""
                //                    self?.email.text =  data?.mail ?? ""
                //                    self?.firstName.text =  data?.profile_data?.first_name ?? ""
                
                self?.anim.stop()
                
                self?.anim.isHidden = true
                
            } else if let error = error {
                // Handle the error, maybe show an alert to the user
                print("Error occurred during search: \(error.localizedDescription)")
                self?.showErrorHud(msg:"Error occurred during search:" )
                self?.anim.isHidden = true
                
                
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func selectCoverImage(_ sender: Any) {
        let removeItem = SBUActionSheetItem(
            title: SBUStringSet.RemovePhoto,
            color: SBUColorSet.error200,
            textAlignment: .center,
            completionHandler: nil
        )
        let cameraItem = SBUActionSheetItem(
            title: SBUStringSet.TakePhoto,
            textAlignment: .center,
            completionHandler: nil
        )
        let libraryItem = SBUActionSheetItem(
            title: SBUStringSet.ChoosePhoto,
            textAlignment: .center,
            completionHandler: nil
        )
        let cancelItem = SBUActionSheetItem(
            title: SBUStringSet.Cancel,
            color: SBUColorSet.primary200,
            completionHandler: nil
        )
        
        self.view.endEditing(true)
        
        SBUActionSheet.show(
            items: coverImage != nil
            ? [removeItem, cameraItem, libraryItem]
            : [cameraItem, libraryItem],
            cancelItem: cancelItem,
            oneTimetheme: .dark,
            delegate: self
        )
        
    }
    
    @IBAction func didSelectHostSelection(_ sender: Any) {
        performSegue(withIdentifier: "hostSelection", sender: nil)
    }
    
    
    
    func fetchUserIdsSendBird() {
        let urlString = "https://api-463780EA-658F-4CC7-B3D3-B9EC3401C650.sendbird.com/v3/users"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Api-Token": "115c832ff33c6a1bc84fce664e9f76c3055de8f6" // Replace with your API token
        ]
        
        AF.request(urlString, method: .get, headers: headers).responseDecodable(of: UserResponse.self) { response in
            switch response.result {
            case .success(let userResponse):
                self.selectedUserIds =   userResponse.users.map { $0.userId }
                print("User IDs: \(self.selectedUserIds.count)")
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchUserIds(nextPage: String? = nil) {
        var urlString = "https://api-6A2870E9-4E98-4044-85DE-24DF3DDECB4B.sendbird.com/v3/users"
        if let nextPage = nextPage, !nextPage.isEmpty {
            urlString += "?next=\(nextPage)"
            print("Fetching next page: \(urlString)")
        } else {
            print("Fetching first page or no more pages to fetch.")
        }

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Api-Token": "115c832ff33c6a1bc84fce664e9f76c3055de8f6"
        ]

        AF.request(urlString, method: .get, headers: headers).responseDecodable(of: UserResponse.self) { response in
            switch response.result {
            case .success(let userResponse):
                let userIds = userResponse.users.map { $0.userId }
                self.selectedUserIds.append(contentsOf: userIds)
                print("Fetched User IDs: \(userIds), Next: \(String(describing: userResponse.next))")

                if let next = userResponse.next, !next.isEmpty {
                    print("Next page exists, calling fetchUserIds again.")
                    self.fetchUserIds(nextPage: next)
                } else {
                    print("No more pages to fetch. Total User IDs fetched: \(self.selectedUserIds.count)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }




    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterLiveEvent",
           let destination =  segue.destination as? LiveEventViewControllers {
            destination.liveEvent = sender as? LiveEvent
        }
        
        guard segue.identifier == "hostSelection",
              let destination = segue.destination as? HostSelectionViewController else {
                  return
              }

        destination.selectedUserIds = selectedUserIds
   
    }

    public func didSelectActionSheetItem(index: Int, identifier: Int) {
        let type = coverImage != nil ? index : index + 1

        switch type {
        case 0:
            self.updateCoverImage(nil)
        case 1, 2:
            let sourceType: UIImagePickerController.SourceType = type == 1 ? .camera : .photoLibrary
            switch sourceType {
            case .camera:
                PermissionManager.shared.requestDeviceAccessIfNeeded(for: .video) { isGranted in
                    if isGranted {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.showCamera()
                        }
                    } else {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(
                                settingsURL,
                                options: [:],
                                completionHandler: nil
                            )
                        }
                    }
                }
            case .photoLibrary:
                PermissionManager.shared.requestPhotoAccessIfNeeded { status in
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        switch status {
                        case .all:
                            self.showPhotoLibraryPicker()
                        case .limited:
                            self.showLimitedPhotoLibraryPicker()
                        default:
                            PermissionManager.shared.showPhotoAccessPermissionAlert()
                        }
                    }
                }
            default: break

            }

        default: break
        }
    }

    /// Presents `UIImagePickerController` for using camera.
    open func showCamera() {
        let sourceType: UIImagePickerController.SourceType = .camera
        let mediaType: [String] = [
            String(kUTTypeImage)
        ]

        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.mediaTypes = mediaType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    /// Presents `UIImagePickerController`. If `SBUGlobals.UsingPHPicker`is `true`, it presents `PHPickerViewController` in iOS 14 or later.
    /// - NOTE: If you want to use customized `PHPickerConfiguration`, please override this method.
    open func showPhotoLibraryPicker() {
        if #available(iOS 14, *), SBUGlobals.isPHPickerEnabled {
            var configuration = PHPickerConfiguration()
            configuration.filter = .any(of: [.images])
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            return
        }

        let sourceType: UIImagePickerController.SourceType = .photoLibrary
        let mediaType: [String] = [
            String(kUTTypeImage)
        ]

        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.mediaTypes = mediaType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    open func showLimitedPhotoLibraryPicker() {
        let selectablePhotoVC = SBUSelectablePhotoViewController(mediaType: .image)
        selectablePhotoVC.delegate = self
        let nav = UINavigationController(rootViewController: selectablePhotoVC)
        self.present(nav, animated: true, completion: nil)
    }

    // MARK: SBUSelectablePhotoViewDelegate
    open func didTapSendImageData(_ data: Data) {
        guard let image = UIImage(data: data) else { return }
        self.updateCoverImage(image)
    }

    // MARK: UIImagePickerViewControllerDelegate
    /// Updates cover image
    /// - Parameter image: Image to be updated
    open func updateCoverImage(_ image: UIImage?) {
        self.coverImage = image
        self.coverImageView.image = image
        self.coverImageView.clipsToBounds = true
    }

    // MARK: - UIImagePickerViewControllerDelegate
    open func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

            picker.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                guard let originalImage = info[.originalImage] as? UIImage else { return }

                self.updateCoverImage(originalImage)
            }
        }

    // MARK: - PHPickerViewControllerDelegate
    /// Override this method to handle the `results` from `PHPickerViewController`.
    /// As defaults, it doesn't support multi-selection and live photo.
    /// - Important: To use this method, please assign self as delegate to `PHPickerViewController` object.
    @available(iOS 14, *)
    open func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        results.forEach {
            let itemProvider = $0.itemProvider
            // image
            if itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                itemProvider.loadItem(forTypeIdentifier: UTType.image.identifier, options: [:]) { _, _ in
                    if itemProvider.canLoadObject(ofClass: UIImage.self) {
                        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] imageItem, _ in
                            guard let self = self else { return }
                            guard let originalImage = imageItem as? UIImage else { return }
                            self.updateCoverImage(originalImage)
                        }
                    }
                }
            }
        }
    }
    @IBAction func customeCreateLiveEvent(_ sender: Any) {
        self.createLiveEvent()

    }
    
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
