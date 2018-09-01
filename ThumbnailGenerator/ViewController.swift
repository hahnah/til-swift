import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePickerButton:UIButton = UIButton()
    var imagePicker: UIImagePickerController! = UIImagePickerController()
    var thumbnailLabel: UILabel = UILabel()
    var thumbnailView: UIImageView?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePickerButton.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width / 2, height: self.view.bounds.size.height / 12)
        self.imagePickerButton.center.x = self.view.bounds.width / 2
        self.imagePickerButton.center.y = self.view.bounds.height / 5
        self.imagePickerButton.backgroundColor = UIColor.blue
        self.imagePickerButton.tintColor = UIColor.white
        self.imagePickerButton.setTitle("Select image!", for: UIControlState.normal)
        self.imagePickerButton.addTarget(self, action: #selector(imagePickUpButtonClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(imagePickerButton)
        
        self.thumbnailLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width / 2, height: self.view.bounds.size.width / 2)
        self.thumbnailLabel.center = self.view.center
        self.thumbnailLabel.text = "Thumbnail here!"
        self.thumbnailLabel.textAlignment = .center
        self.thumbnailLabel.textColor = UIColor.white
        self.thumbnailLabel.backgroundColor = UIColor.gray
        self.view.addSubview(self.thumbnailLabel)
        
    }
    
    @objc func imagePickUpButtonClicked(sender: UIButton){
        self.thumbnailView?.removeFromSuperview()
        self.thumbnailView = nil
        
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.imagePicker.delegate = self
 
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let thumbnail: UIImage = self.generateThumbnail(sourceImage: image, objectiveEdgeLength: self.thumbnailLabel.bounds.width)
            self.thumbnailView = UIImageView(image: thumbnail)
            self.thumbnailLabel.addSubview(self.thumbnailView!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
