import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4

Rectangle {
    property int cellValue
    property int cellIndex

    signal cellClicked(int button)

    color: "lightgreen"
    border {
        color: "black"
        width: 3
    }

    Text {
        id: _cellText

        function min(value1, value2) {
            return Math.min(value1, value2)
        }

        anchors.centerIn: parent

        text: cellValue + 1
        font.pointSize: min(parent.width, parent.height) * 0.6
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            cellClicked(mouse.button);
        }
    }
}


