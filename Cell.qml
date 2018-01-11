import QtQuick 2.5

import QtQuick.Controls 1.4

Rectangle {
    id: _cellRectangle

    property int cellValue: value
    property int cellIndex: index

    signal cellClicked(int button)

    color: "lightgreen"
    border {
        color: "black"
        width: 3
    }

    Text {
        id: _cellText

        anchors.centerIn: parent

        text: cellValue + 1
        font.pointSize: Math.min(_cellRectangle.width, _cellRectangle.height) * 0.6
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


