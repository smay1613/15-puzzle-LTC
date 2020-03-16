import QtQuick 2.0
import QtQuick.Controls 2.12

Popup {
    signal newGame()
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
    }


    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 }
    }

    Image {
        anchors.fill: parent
        id: name
        source: "cup.jpg"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.newGame()
            }
        }
    }
}
