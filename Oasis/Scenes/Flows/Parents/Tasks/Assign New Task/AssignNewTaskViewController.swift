//
//  AssignNewTaskViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol AssignNewTaskViewControllerOutput {
    func getTaskTypes() -> Single<[AssignNewTaskModels.ViewModels.Task]>
    func addTask(title: String, currency: String, amount: Int, childID: String, taskTypeID: Int) -> Single<Void>
}

class AssignNewTaskViewController: BaseViewController {
    
    var interactor: AssignNewTaskViewControllerOutput?
    var router: AssignNewTaskRouter?
    
    lazy var topTitleLabel :  ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Assign New Task".localized
        return lbl
    }()
    
    lazy var categoryLabel :  BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 20),
                          color: .black)
        lbl.text = "Category".localized
        return lbl
    }()
    
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
       scrollView.autoLayout()
       scrollView.backgroundColor = .clear
       scrollView.showsVerticalScrollIndicator = false
       return scrollView
   }()
   
   //Horizontal Labels
   lazy var stackView: UIStackView = {
       let stackView = UIStackView()
       stackView.axis = .vertical
       stackView.distribution = .fill
       stackView.spacing = 19
       stackView.autoLayout()
       stackView.backgroundColor = .clear
       return stackView
   }()
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.categoriesCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.categoriesCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var categoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 19
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var assignTaskButton : OasisAquaButton = {
        let btn = OasisAquaButton()
        btn.setTitle("+ Create task", for: .normal)
        btn.roundCorners = .all(radius: 30)
        btn.autoLayout()
        return btn
    }()
    
    lazy var suggestedTasksContainerView : BaseUIView = {
        let containerview = BaseUIView()
        containerview.backgroundColor = Constants.Colors.extraLightGrey
        containerview.roundCorners = .top(radius: 56)
        containerview.autoLayout()
        return containerview
    }()
    
    lazy var suggestedTasksLabel :  BaseLabel = {
        let lbl = BaseLabel()
        
        lbl.style = .init(font: MainFont.medium.with(size: 20), color: .black)
        lbl.text = "Suggested Tasks".localized
        lbl.autoLayout()
        return lbl
    }()
    
    private let taskTitleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.suggestedTitlesCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.taskTitleCollectionVC.identifier)
        return collectionView
    }()
    
    //Square Views
    private let tasksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.tasksCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.tasksCollectionCell.identifier)
        return collectionView
    }()
    
    var suggestedTasksArray = ["ALL","LEARNING", "SOCIAL", "HOUSEKEEPING", "FAMILY", "PETS", "GARDENING", "HELP"]

    var previouslySelectedCVC = CategoriesCollectionViewCell()
    var previouslyTasktitleSelectedCVC = SuggestedTitlesCollectionViewCell()
    
    var selectedTaskTitleID = 0
    var selectedCategoryID = 1

    
    var taskNameView : TitleWithTextFieldView!
    var taskAmountView : AmountWithCurrencyView!
    
    var currencies = ["LBP", "$"]
    var currencySelected : String = "LBP"
    var taskName : String?
    var taskAmount : String?
    var tasksTypesVMArray = [AssignNewTaskModels.ViewModels.Task]()
}

//MARK:- View Lifecycle
extension AssignNewTaskViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AssignNewTaskConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        subscribeForGetTaskTypes()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    private func setupUI(){
        addScrollViewAndStackView()
        addTopTitles()
        addCategoriesCollectionView()
        addTaskInfoViews()
        addAssignTaskButton()
        addSuggestedTasksContainerView()
        addCollectionviewsToContainerView()
    }
    
    private func addScrollViewAndStackView(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
    
    private func addTopTitles(){
        stackView.addArrangedSubview(topTitleLabel)
        stackView.addArrangedSubview(categoryLabel)
    }
    
    private func addCategoriesCollectionView(){
        stackView.addArrangedSubview(categoriesCollectionView)
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        categoriesCollectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func addTaskInfoViews(){
         taskNameView = TitleWithTextFieldView.init(requestTitle: "Task name".localized,
                                                    textsColor: .black,
                                                    usertext: "",
                                                    textSize: 22,
                                                    isAgeRequest: false,
                                                    labelHeight: 40,
                                                    placholderText: "Type here".localized,
                                                     frame: .zero)

         taskAmountView = AmountWithCurrencyView.init(amountPlaceHolder: 0.0,
                                                 amount: 0,
                                                 currency: "LBP",
                                                 titleLbl: "Amount to reward",
                                                     frame: .zero)
        
        stackView.addArrangedSubview(taskNameView)
        stackView.addArrangedSubview(taskAmountView)
        
        taskNameView.anyTextField.delegate = self
        taskAmountView.amountTextField.delegate = self
        
        NSLayoutConstraint.activate([
            taskNameView.heightAnchor.constraint(equalToConstant: 100),
            taskAmountView.heightAnchor.constraint(equalToConstant: 110)
        ])

        taskAmountView.currencyPicker.delegate = self
        taskAmountView.currencyPicker.dataSource = self
        
    }
    
    private func addAssignTaskButton(){
        stackView.addArrangedSubview(assignTaskButton)
        
        NSLayoutConstraint.activate([
            assignTaskButton.heightAnchor.constraint(equalToConstant: 40),
            //assignTaskButton.widthAnchor.constraint(equalToConstant: 120)
        
        ])
        assignTaskButton.onTap {
            self.validateFields()
        }
    }
    
    private func addSuggestedTasksContainerView(){
        stackView.addArrangedSubview(suggestedTasksContainerView)
        suggestedTasksContainerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func addCollectionviewsToContainerView(){
        suggestedTasksContainerView.addSubview(suggestedTasksLabel)
        suggestedTasksContainerView.addSubview(taskTitleCollectionView)
        suggestedTasksContainerView.addSubview(tasksCollectionView)
        
        taskTitleCollectionView.delegate = self
        taskTitleCollectionView.dataSource = self
        
        tasksCollectionView.dataSource = self
        tasksCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            suggestedTasksLabel.heightAnchor.constraint(equalToConstant: 40),
            suggestedTasksLabel.topAnchor.constraint(equalTo: suggestedTasksContainerView.topAnchor, constant: 30),
            suggestedTasksLabel.leadingAnchor.constraint(equalTo: suggestedTasksContainerView.leadingAnchor, constant: 30),
            
            taskTitleCollectionView.topAnchor.constraint(equalTo: suggestedTasksLabel.bottomAnchor, constant: 5),
            taskTitleCollectionView.leadingAnchor.constraint(equalTo: suggestedTasksContainerView.leadingAnchor, constant: 30),
            taskTitleCollectionView.trailingAnchor.constraint(equalTo: suggestedTasksContainerView.trailingAnchor),
            taskTitleCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            tasksCollectionView.topAnchor.constraint(equalTo: taskTitleCollectionView.bottomAnchor, constant: 20),
            tasksCollectionView.leadingAnchor.constraint(equalTo: suggestedTasksContainerView.leadingAnchor, constant: 30),
            tasksCollectionView.heightAnchor.constraint(equalToConstant: 165)

        ])

    }
    
    private func validateFields(){
        
        guard taskName.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in the Task Name", withCompletionHandler: nil)
            return
        }
        
        guard taskAmount.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in the Task Amount", withCompletionHandler: nil)
            return
        }
        
        subscribeForAddNewTask()
    }
}

//MARK:- NavBarAppearance
extension AssignNewTaskViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}



extension AssignNewTaskViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tasksCollectionView{
            return 5
        }else if collectionView == taskTitleCollectionView{
            return suggestedTasksArray.count
        }else{
            return tasksTypesVMArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tasksCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.tasksCollectionCell, for: indexPath)! as TasksCollectionViewCell
            cell.setupCell(title: "Gardening", subTitle: "Water plants in the garden and indoors")
            
            return cell
        }else if collectionView == taskTitleCollectionView {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.taskTitleCollectionVC, for: indexPath)! as SuggestedTitlesCollectionViewCell
            cell.setupCell(taskTitle: suggestedTasksArray[indexPath.row])
            if indexPath.row == 0{
                cell.greenBGView.backgroundColor = Constants.Colors.aquaMarine
                cell.taskLabel.textColor = .white
            }

            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.categoriesCollectionViewCell, for: indexPath)! as CategoriesCollectionViewCell
            
            cell.setupCell(category: tasksTypesVMArray[indexPath.row].title ?? "")
            cell.categoriesContainerView.roundCorners = .all(radius: 14.5)
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tasksCollectionView{
            
            
        }else if collectionView == taskTitleCollectionView{
            
            let selectedCell = taskTitleCollectionView.cellForItem(at: indexPath)! as! SuggestedTitlesCollectionViewCell
            
            guard previouslyTasktitleSelectedCVC == selectedCell else{
                return
            }
            selectedCell.greenBGView.backgroundColor = Constants.Colors.aquaMarine
            selectedCell.taskLabel.textColor = .white
            
            selectedTaskTitleID = indexPath.row
            
            if previouslyTasktitleSelectedCVC.greenBGView != nil{
                previouslyTasktitleSelectedCVC.greenBGView.backgroundColor = Constants.Colors.appGrey
                previouslyTasktitleSelectedCVC.taskLabel.textColor = .black
            }
            previouslyTasktitleSelectedCVC = selectedCell
            
        }else{
            
            let selectedCell = categoriesCollectionView.cellForItem(at: indexPath)! as! CategoriesCollectionViewCell
            
            if previouslySelectedCVC == selectedCell{
                selectedCell.categoriesContainerView.backgroundColor = Constants.Colors.appGrey
                selectedCell.categoryLabel.textColor = .black

            }else{
                selectedCell.categoriesContainerView.backgroundColor = Constants.Colors.appViolet
                selectedCell.categoryLabel.textColor = .white
                if previouslySelectedCVC.categoriesContainerView != nil{
                    previouslySelectedCVC.categoriesContainerView.backgroundColor = Constants.Colors.appGrey
                    previouslySelectedCVC.categoryLabel.textColor = .black
                }
            }
            previouslySelectedCVC = selectedCell
        }
        
        
    }
}

extension AssignNewTaskViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tasksCollectionView{
            return CGSize(width: 153, height: 164)
        }else if collectionView == taskTitleCollectionView{
            return CGSize(width: 93, height: 50)
        }else{
            return CGSize(width: tasksTypesVMArray[indexPath.row].title!.size(withAttributes: nil).width + 30 , height: 28)
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}

extension AssignNewTaskViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview == taskNameView{
            self.taskName = textField.text
        }else{
            self.taskAmount = textField.text//.notNilNorEmpty ? Int(textField.text!) : 0
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.superview == taskNameView{
            self.taskName = textField.text
        }else{
            self.taskAmount = textField.text//.notNilNorEmpty ? Int(textField.text!) : 0
        }
    }
}

extension AssignNewTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        currencies.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = currencies[row]
        currencySelected = currency
        taskAmountView.currencyLabel.text = currencySelected
        pickerView.isHidden = true
    }


}

//MARK:- Callbacks
extension AssignNewTaskViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            #warning("Retry Action does not set")
        }
    }
    
    private func subscribeForGetTaskTypes(){
        self.interactor?.getTaskTypes()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (tasks) in
                self!.display(successMessage: "Done")
                self?.tasksTypesVMArray = tasks
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func subscribeForAddNewTask(){
        self.interactor?.addTask(title: "", currency: "", amount: 0, childID: "", taskTypeID: 0)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self!.display(successMessage: "Done")
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
}
