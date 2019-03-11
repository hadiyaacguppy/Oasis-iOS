//
//  TDPicker.swift
//  Base-Project
//
//  Created by Wassim on 7/30/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import CZPicker

class TDPicker  :NSObject ,  CZPickerViewDelegate , CZPickerViewDataSource {
    
    var picker : CZPickerView?
    
    var allOptionsTitle : String = "All".localized
    
    var shouldAddAllOptionsCell : Bool = false
    
    var shouldDismissOnFirstTap : Bool = true
    
    var numberOfRows : (() -> Int)!
    
    var titleForRow : ((_ row : Int) -> String)!
    
    var didSelectRow : (( _ row : Int) -> ())?
    var imageForRow : ((_ row : Int) -> UIImage?)?
    
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        
        if shouldAddAllOptionsCell  {
            return numberOfRows() + 1
        }else {
            return numberOfRows()
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!,
                      titleForRow row: Int) -> String! {
        
        if shouldAddAllOptionsCell, row == 0  {
            return allOptionsTitle
        }else {
            return titleForRow(row)
        }
        
    }
    
    func czpickerView(_ pickerView: CZPickerView!,
                      didConfirmWithItemAtRow row: Int) {
        didSelectRow?(row)
        
    }
    func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        if self.imageForRow != nil {
            return imageForRow!(row) ?? UIImage()
        }
        return UIImage()
        
    }
    
    init(withTitle title : String,
         confirmButtonTitle confirm: String = "" ,
         andCancelButtonTitle  cancel : String = "" ) {
        super.init()
        picker = CZPickerView(headerTitle: title, cancelButtonTitle: confirm, confirmButtonTitle: cancel)
        picker?.delegate = self
        picker?.dataSource = self
        configUI()
    }
    
    override init() {
        super.init()
        picker = CZPickerView(headerTitle: "", cancelButtonTitle: "", confirmButtonTitle: "")
        picker?.delegate = self
        picker?.dataSource = self
        configUI()
    }
    
    func configUI(){
        picker?.headerBackgroundColor = .red
        picker?.needFooterView = false
        picker?.confirmButtonNormalColor = .white
        picker?.cancelButtonNormalColor =  .white
        picker?.confirmButtonBackgroundColor = .red
        picker?.confirmButtonBackgroundColor = .red
    }
    
    func show(){
        picker?.show()
    }
    
}
