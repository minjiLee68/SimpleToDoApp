//
//  TodoListViewController.swift
//  SimpleToDoApp
//
//  Created by 이민지 on 2022/01/24.
//

import UIKit

class TodoListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var isTodayButton: UIButton!
    
    let todoViewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //키보드 디랙션
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        todoViewModel.loadTasks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func isTodayButtonTapped(_ sender: Any) {
        // 투데이 버튼 토글 작업
        isTodayButton.isSelected = !isTodayButton.isSelected
    }
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        // Todo 태스크 추가
        guard let detail = inputTextField.text, detail.isEmpty == false else { return }
        let todo = TodoManager.shared.createTodo(detail: detail, isToday: isTodayButton.isSelected)
        todoViewModel.addTodo(todo)
        collectionView.reloadData()
        inputTextField.text = ""
        isTodayButton.isSelected = false
    }
    
    //탭 했을 때 키보드 내려오게 하기
    @IBAction func tapBG(_ sender: Any) {
        inputTextField.resignFirstResponder()
    }
    
}

extension TodoListViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        //키보드 위체이 따른 인풋 위치 변경
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            inputViewBottom.constant = adjustmentHeight
        } else {
            inputViewBottom.constant = 0
        }
    }
}

extension TodoListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 섹션
        todoViewModel.numOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 섹션 별 아이템 몇개>
        
    }
}

class TodoListCell: UICollectionViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var strikeThrounghView: UIView!
    
    @IBOutlet weak var strikeThrounghWidth: NSLayoutConstraint!
    
}

class TodoListHeadarView: UICollectionReusableView {
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
