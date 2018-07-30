//
//  TDPicker.swift
//  Base-Project
//
//  Created by Wassim on 7/30/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import TDPicker


class TDPicker  :NSObject ,  TDPickerViewDelegate , TDPickerViewDataSource {
    
    var picker : TDPickerView?
    
    var allOptionsTitle : String = "All".localized
    
    var shouldAddAllOptionsCell : Bool = false
    
    var shouldDismissOnFirstTap : Bool = true
    
    var numberOfRows : (() -> Int)!
    
    var titleForRow : ((_ row : Int) -> String)!
    
    var didSelectRow : (( _ row : Int) -> ())?
    
    var imageForRow : ((_ row : Int) -> UIImage?)?
    
    var headerBackgroundColor : UIColor = Constants.Colors.appColor
    
    func numberOfRows(in pickerView: TDPickerView!) -> Int {
        
        if shouldAddAllOptionsCell  {
            return numberOfRows() + 1
        }else {
            return numberOfRows()
        }
    }
    
    func tdPickerView(_ pickerView: TDPickerView!,
                      titleForRow row: Int) -> String! {
        
        if shouldAddAllOptionsCell, row == 0  {
            return allOptionsTitle
        }else {
            return titleForRow(row)
        }
        
    }
   
    func tdPickerView(_ pickerView: TDPickerView!,
                      didConfirmWithItemAtRow row: Int) {
        didSelectRow?(row)
        
    }
    func tdPickerView(_ pickerView: TDPickerView!, imageForRow row: Int) -> UIImage! {
        if self.imageForRow != nil {
            return imageForRow!(row) ?? UIImage()
        }
        return UIImage()
        
    }
    
    init(withTitle title : String,
         confirmButtonTitle confirm: String = "" ,
         andCancelButtonTitle  cancel : String = "" ) {
        super.init()
        picker = TDPickerView(headerTitle: title, cancelButtonTitle: confirm, confirmButtonTitle: cancel)
        picker?.delegate = self
        picker?.dataSource = self
        configUI()
    }
    
    override init() {
        super.init()
        picker = TDPickerView(headerTitle: "", cancelButtonTitle: "", confirmButtonTitle: "")
        picker?.delegate = self
        picker?.dataSource = self
        configUI()
    }
    
    func configUI(){
        picker?.headerBackgroundColor = headerBackgroundColor
        picker?.needFooterView = false
        picker?.confirmButtonNormalColor = .white
        picker?.cancelButtonNormalColor =  .white

    }
    
    func show(){
        picker?.show()
    }
    
}
