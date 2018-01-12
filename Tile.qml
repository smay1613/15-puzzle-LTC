import QtQuick 2.5
import QtQuick.Controls 1.4

Rectangle {
    id: _cellRectangle

    signal cellClicked(int button)

    color: "lightgreen"
    border {
        color: "black"
        width: 3
    }

    Text {
        anchors.centerIn: parent

        text: cellValue + 1
        font.pointSize: Math.min(_cellRectangle.width, _cellRectangle.height) * 0.6
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton
        onClicked: {
            cellClicked(mouse.button);
        }
    }
}


