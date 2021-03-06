//  LimitTextView.swift
//  BSKAppCore
//
//  Created by εδΈζ on 2021/3/18.
//
import UIKit

private class BSKLimitTextDelegator: NSObject, UITextViewDelegate {
    weak var delegate: UITextViewDelegate?

    @available(iOS 2.0, *)
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return delegate?.textViewShouldBeginEditing?(textView) ?? true
    }

    @available(iOS 2.0, *)
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return delegate?.textViewShouldEndEditing?(textView) ?? true
    }

    @available(iOS 2.0, *)
    func textViewDidBeginEditing(_ textView: UITextView) {
        delegate?.textViewDidBeginEditing?(textView)
    }

    @available(iOS 2.0, *)
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.textViewDidEndEditing?(textView)
    }

    @available(iOS 2.0, *)
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let view = textView as? BSKLimitTextView, let maxLength = view.maxTextLength {
            var markedTextCount = 0
            if let markedTextRange = view.markedTextRange {
                let markedText = view.text(in: markedTextRange)
                markedTextCount = markedText?.count ?? 0
            }
            if text.count > 0, view.text.count - markedTextCount >= maxLength {
                return false
            }
        }

        return delegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true
    }

    @available(iOS 2.0, *)
    func textViewDidChange(_ textView: UITextView) {
        delegate?.textViewDidChange?(textView)
    }

    @available(iOS 2.0, *)
    func textViewDidChangeSelection(_ textView: UITextView) {
        delegate?.textViewDidChangeSelection?(textView)
    }

    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return delegate?.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? true
    }

    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return delegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? true
    }

    @available(iOS, introduced: 7.0, deprecated: 10.0)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return delegate?.textView?(textView, shouldInteractWith: URL, in: characterRange) ?? true
    }

    @available(iOS, introduced: 7.0, deprecated: 10.0)
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return delegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange) ?? true
    }
}

/// ζ―ζPlaceholder ε ιΏεΊ¦ιεΆη TextView
open class BSKLimitTextView: UITextView {
    // MARK: - ε¬εΌηε±ζ§

    /// δ»£ηοΌθ?Ύη½?ζΆζεζζΉεΌθ?Ύη½?οΌθ·εζΆε°θΏεδΈδΈͺ LimitTextDelegaterοΌδ½ θ?Ύη½?ηδ»£ηε―Ήθ±‘δΏε­ε¨ε?ηdelegateε±ζ§δΈ­
    override open var delegate: UITextViewDelegate? {
        get {
            return delegator
        }
        set {
            delegator.delegate = newValue
        }
    }

    /// ε δ½η¬¦
    open var placeholder: String? {
        didSet {
            if let text = placeholder, text.count > 0 {
                placeHolderLabel.isHidden = false
                placeHolderLabel.text = text
            } else {
                placeHolderLabel.isHidden = true
            }
        }
    }

    /// ζε€§ε―θΎε₯ζε­ιΏεΊ¦
    open var maxTextLength: Int? {
        didSet {
            updateTextLimit()
        }
    }

    /// θζ―ι’θ²
    override open var backgroundColor: UIColor? {
        didSet {
            textLimitLabelBackground.backgroundColor = backgroundColor
        }
    }

    /// εε?ΉθΎΉθ·
    override open var contentInset: UIEdgeInsets {
        get {
            return customContentInset
        }
        set {
            customContentInset = newValue
        }
    }

    /// ζΎη€Ίζε­ιεΆηLabel
    private(set) public lazy var textLimitLabel: UILabel = {
        let label = UILabel()
        self.textLimitLabelBackground.addSubview(label)
        return label
    }()

    /// ζΎη€Ίζε­ιεΆηLabelηε?Ήε¨οΌε½δΈεΈζζΎη€ΊδΈι’ηιεΆε­ζ°εδΈζζε»ζεΊι¨ηθΎΉθ·ζΆθ―·ιθζ­€θ§εΎ
    private(set) public lazy var textLimitLabelBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        self.addSubview(view)
        return view
    }()

    /// ζε­δΈΊη©ΊηζΆεζΎη€Ίηε δ½η¬¦Label
    private(set) public lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)

        placeHolderTop = label.topAnchor.constraint(equalTo: self.topAnchor, constant: self.textContainerInset.top)
        placeHolderTop?.isActive = true
        placeHolderLeft = label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.textContainerInset.left + 5)
        placeHolderLeft?.isActive = true
        
        label.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -self.textContainerInset.right - 5 - self.textContainerInset.left - 5).isActive = true
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// ζε­εθΎΉθ·
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            self.placeHolderLeft?.constant = self.textContainerInset.left + 5
            self.placeHolderTop?.constant = self.textContainerInset.top
        }
    }
    
    open func showLimitTextLabel(_ show:Bool ) {
        self.textLimitLabelBackground.alpha = show ? 1 : 0
        self.setNeedsLayout()
    }

    // MARK: - η§ζε±ζ§

    /// δΈ­ι΄δ»£ηοΌζθ·εηδ»£ηοΌε€ηδΊδ»ΆοΌηΆεε°εΆθ½¬εεΊε»γ
    private var delegator: BSKLimitTextDelegator = BSKLimitTextDelegator()
    /// θͺε?δΉηεε?ΉθΎΉθ·οΌε δΈΊεΊι¨ζε­ιΏεΊ¦ζη€Ίηε­ε¨οΌηε?ηContentInsetεθͺε?δΉθ?Ύη½?ηζδΈε?ε·?θ·οΌθΏδΈͺε±ζ§η¨δΊδΏε­θͺε?δΉθ?Ύη½?ηinset
    private var customContentInset: UIEdgeInsets = .zero

    private var placeHolderTop: NSLayoutConstraint?

    private var placeHolderLeft: NSLayoutConstraint?

    // MARK: - ιθ½½η³»η»ηζΉζ³

    override init(frame: CGRect = .zero, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        initView()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        updateTextLimitLabelFrame()
    }
    
    open override var text: String! {
        set {
            super.text = newValue
            textDidChange()
        }
        get {
            return super.text
        }
    }

    // MARK: - η§ζζΉζ³

    private func updateTextLimit() {
        var textCount = "\(text.count)"

        if let maxLength = maxTextLength {
            if text.count > maxLength, markedTextRange == nil {
                text = String(text[..<text.index(text.startIndex, offsetBy: maxLength)])
            }
            textCount = "\(text.count)/\(maxLength)"
        }
        textLimitLabel.text = textCount
        updateTextLimitLabelFrame()
    }

    private func updateTextLimitLabelFrame() {
        textLimitLabel.sizeToFit()
        var frame = textLimitLabel.frame
        frame.origin.x = self.frame.width - textContainerInset.right - frame.width - 5
        frame.origin.y = 5
        textLimitLabel.frame = frame

        textLimitLabelBackground.frame = CGRect(x: 0,
                                                y: self.frame.height - frame.height - 10 + contentOffset.y,
                                                width: self.frame.width,
                                                height: frame.height + 10)
        var inset = contentInset
        if !(textLimitLabelBackground.isHidden || textLimitLabelBackground.alpha == 0) && !textLimitLabel.isHidden {
            inset.bottom += frame.height + 10
        }
        super.contentInset = inset
    }

    private func initView() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
        super.delegate = delegator
    }

    @objc private func textDidChange() {
        updateTextLimit()
        if placeholder != nil {
            placeHolderLabel.isHidden = text.count > 0
        }
    }
}
