//
//  FiltersCollectionView.swift
//  SayTheirNames
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

final class FiltersCollectionView: UICollectionView {
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromContentInset
        layout.sectionInset = Self.layoutInsets
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = Self.estimatedItemSize
        
        super.init(frame: .zero, collectionViewLayout: layout)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSelf() {
        backgroundColor = .systemBackground
    }
}

extension FiltersCollectionView {
    private static let layoutInsets = UIEdgeInsets(left: 16, right: 16)
    private static let estimatedItemSize = CGSize(width: 103, height: 36)
}
