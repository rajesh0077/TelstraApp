//
//  FactsTableViewCell.swift
//  TelstraApp
//
//  Created by RajeshDeshmukh on 30/06/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit
import SDWebImage // used for lazy loading of images

class FactsTableViewCell: UITableViewCell {
    
    /// Private Constants
    private struct Constant {
      static let borderWidth: CGFloat = 0.1
      static let imageWidth: CGFloat = 50
      static let imageheight: CGFloat = 50
      static let priority: Float = 600
      static let cornerRadius: CGFloat = 25
      static let spacing: CGFloat = 8
      static let verticalSpacing: CGFloat = 2
      static let numberOfLines: Int = 0
    }
    
    /// Computated property to set tableview cell data
    var rowCellModel: DisplayRowModel? {
        didSet {
            guard let model = rowCellModel else {return}
            if let title = model.title {
                lblTitle.text = title
            } else {
                lblTitle.text = ""
            }
            if let description = model.description {
                lblDescription.text = description
            } else {
                lblDescription.text = ""
            }
            if let href = model.imageHref {
                //imgView.downloaded(from: href)
                
                // using third party framework SDWebImage
                imgView.sd_setImage(with: URL(string: href), placeholderImage: UIImage(named: AppConstant.AppImage.placeholder))
            } else {
                imgView.image = UIImage(named: AppConstant.AppImage.placeholder)
            }
        }
    }
    
    /// Instance of UIImageView for image
    let imgView:UIImageView = {
      let img = UIImageView()
      img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
      img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
      img.layer.cornerRadius = FactsTableViewCell.Constant.cornerRadius
      img.clipsToBounds = true
      img.layer.masksToBounds = true
      img.layer.borderWidth = FactsTableViewCell.Constant.borderWidth
      img.layer.borderColor = AppConstant.AppColor.kColor_DarkGray.cgColor
      return img
    }()
    
    /// Instance of UILabel for title
    let lblTitle:UILabel = {
      let label = UILabel()
      label.font = AppConstant.AppFonts.kboldSystemFont16
      label.textColor = AppConstant.AppColor.kColor_black
      label.clipsToBounds = true
      label.numberOfLines = FactsTableViewCell.Constant.numberOfLines // used for multiline
      label.lineBreakMode = .byWordWrapping
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    /// Instance of UILabel for description
    let lblDescription:UILabel = {
      let label = UILabel()
      label.font =  AppConstant.AppFonts.ksystemFont14
      label.textColor =  AppConstant.AppColor.kColor_DarkGray
      label.clipsToBounds = true
      label.numberOfLines = FactsTableViewCell.Constant.numberOfLines
      label.lineBreakMode = .byWordWrapping
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    /// Configuration of cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      let marginGuide = contentView.layoutMarginsGuide
      
      // Configure imgView
      contentView.addSubview(imgView)
      imgView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
      imgView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
      imgView.widthAnchor.constraint(equalToConstant:FactsTableViewCell.Constant.imageWidth).isActive = true
      imgView.heightAnchor.constraint(equalToConstant:FactsTableViewCell.Constant.imageheight).isActive = true
      let con = imgView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor)
      con.priority = UILayoutPriority(FactsTableViewCell.Constant.priority)
      con.isActive = true
      
      // Configure lblTitle
      contentView.addSubview(lblTitle)
      lblTitle.translatesAutoresizingMaskIntoConstraints = false
      lblTitle.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: FactsTableViewCell.Constant.spacing).isActive = true
      lblTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
      lblTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
      
      // Configure lblDescription
      contentView.addSubview(lblDescription)
      lblDescription.translatesAutoresizingMaskIntoConstraints = false
      lblDescription.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: FactsTableViewCell.Constant.spacing).isActive = true
      lblDescription.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
      lblDescription.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
      lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: FactsTableViewCell.Constant.verticalSpacing).isActive = true
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
