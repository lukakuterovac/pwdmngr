//
//  PasswordGeneratorViewState.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 04.06.2024..
//

import Foundation
import SwiftUI

class PasswordGeneratorViewState: ObservableObject {
    @Published var isShowingFullPassword: Bool = false
    @Published var isOptionsExpanded: Bool = false
    @Published var generatedPassword: String = ""
}
