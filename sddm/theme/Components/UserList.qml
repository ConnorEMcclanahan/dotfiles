//
// This file is part of SDDM Sugar Candy.
// A theme for the Simple Display Desktop Manager.
//
// Copyright (C) 2018–2020 Marian Arlt
//
// SDDM Sugar Candy is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the
// Free Software Foundation, either version 3 of the License, or any later version.
//
// You are required to preserve this and any additional legal notices, either
// contained in this file or in other files that you received along with
// SDDM Sugar Candy that refer to the author(s) in accordance with
// sections §4, §5 and specifically §7b of the GNU General Public License.
//
// SDDM Sugar Candy is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SDDM Sugar Candy. If not, see <https://www.gnu.org/licenses/>
//

import QtQuick 2.11
import QtQuick.Controls 2.4
import Qt5Compat.GraphicalEffects

Item {
    id: usernameField

    height: root.font.pointSize * 4.5
    width: parent.width / 2
    anchors.horizontalCenter: parent.horizontalCenter

    property var selectedUser: selectUser.currentIndex
    property alias user: username.text

    ComboBox {

        id: selectUser

        width: 1
        height: 1
        anchors.left: parent.left
        z: 2

        model: userModel
        currentIndex: model.lastIndex
        textRole: "name"
        hoverEnabled: true
        contentItem: Item { }
        onActivated: {
            username.text = currentText
        }

        delegate: ItemDelegate {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            contentItem: Text {
                text: model.name
                font.pointSize: root.font.pointSize * 0.8
                font.capitalization: Font.Capitalize
                color: selectUser.highlightedIndex === index ? "white" : root.palette.window.hslLightness >= 0.8 ? root.palette.highlight : "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            highlighted: parent.highlightedIndex === index
            background: Rectangle {
                color: selectUser.highlightedIndex === index ? root.palette.highlight : "transparent"
            }
        }

        indicator: Item {
                id: usernameIconContainer
                width: 1
                height: 1
        }

        background: Rectangle {
            color: "transparent"
            border.color: "transparent"
        }

        popup: Popup {
            y: parent.height - username.height / 3
            rightMargin: config.ForceRightToLeft == "true" ? usernameField.width / 2 : undefined
            width: usernameField.width
            implicitHeight: contentItem.implicitHeight
            padding: 10

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight + 20
                model: selectUser.popup.visible ? selectUser.delegateModel : null
                currentIndex: selectUser.highlightedIndex
                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                radius: 10
                color: "#11111b"
            }

            enter: Transition {
                NumberAnimation { property: "opacity"; from: 0; to: 1 }
            }
        }

    }

    TextField {
        id: username
        text: config.ForceLastUser == "true" ? selectUser.currentText : null
        font.capitalization: Font.Capitalize
        anchors.centerIn: parent
        height: root.font.pointSize * 3
        width: parent.width
        placeholderText: config.TranslateUsernamePlaceholder || textConstants.userName
        selectByMouse: true
        horizontalAlignment: TextInput.AlignHCenter
        renderType: Text.QtRendering
        background: Rectangle {
            color: "transparent"
            border.color: "transparent"
            border.width: 0
        }
        Keys.onReturnPressed: loginButton.clicked()
        KeyNavigation.down: password
        z: 1

        states: [
            State {
                name: "focused"
                when: username.activeFocus
                PropertyChanges {
                    target: username.background
                    border.color: root.palette.highlight
                }
                PropertyChanges {
                    target: username
                    color: root.palette.highlight
                }
            }
        ]
    }

}
