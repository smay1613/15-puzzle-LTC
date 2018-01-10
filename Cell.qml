import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4

Rectangle {
    property int cellValue
    property int cellIndex
    property alias mouseArea: _mouseArea

    color: "lightgreen"
    border {
        color: "black"
        width: 3
    }

    Text {
        id: _cellText

        anchors.centerIn: parent

        text: cellValue + 1
        font.pointSize: parent.height > parent.width ? parent.width * 0.6 : parent.height * 0.6
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton
    }
}
