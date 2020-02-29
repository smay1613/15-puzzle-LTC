import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    id: root

    property string internalText: ""

    Rectangle {
        id: _tile

        anchors.fill: root

        color: "lightgreen"
        border.color: "black"
        border.width: 1
        radius: width * 0.1

        Text {
            text: internalText

            font.bold: true
            font.pointSize: root.height ? root.height * 0.33
                                         : 1
            anchors.centerIn: _tile
        }
    }

    DropShadow {
        anchors.fill: root

        source: _tile
        verticalOffset: 4
        horizontalOffset: verticalOffset / 2
    }
}

